/************************************************************************
Lab 9 Nios Software

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "aes.h"
#include "system.h"

// Pointer to base address of AES module, make sure it matches Qsys
// ? 可以这么做的原因或许是在avalon_aes_interface.sv 文件开头定义了 logic [15:0][31:0] Reg_unit;
volatile unsigned int * AES_PTR = (unsigned int *) AES_BASE;

// Execution mode: 0 for testing, 1 for benchmarking
int run_mode = 0;

/*
 * charToHex
 *  Convert a single character to the 4-bit value it represents.
 *
 *  Input: a character c (e.g. 'A')
 *  Output: converted 4-bit value (e.g. 0xA)
 */
char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <= 'F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <= 'f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

/*
 * charsToHex
 *  Convert two characters to byte value it represents.
 *  Inputs must be 0-9, A-F, or a-f.
 *
 *  Input: two characters c1 and c2 (e.g. 'A' and '7')
 *  Output: converted byte value (e.g. 0xA7)
 */
char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}

/*
 * SubBytes
 * The transformation process for each Byte in the State is pre-calculated and stored into
 * S-box for the encryption process.
 *
 * Input: state
 */

void SubBytes(unsigned char state[4][4])
{
	for (int i = 0; i < 4; i++)
		for (int j = 0; j < 4; j++){
			state[i][j] = aes_sbox[(int)state[i][j]];
		}
}

/*
*	bit-wise left shift then a conditional bit-wise
*	XOR with {1b} if the 8th bit before the shift is 1
*/
unsigned char xtime(unsigned char in)
{
	if (in & 0x80)
		return ((in<<1) ^ 0x1b);
	else
		return (in<<1);
}
/*
 * Mixcolumn
 * Each of the four Words in the updating State undergoes separate invertible linear transformations over 8 GF(2 ) such
 * that the four Bytes of each Word are linearly combined to form a new Word
 *
 * Input: state
 */

void MixColumns(unsigned char state[4][4])
{
	unsigned char b[4];
	unsigned char a[4];
	int i;
	for (i = 0; i < 4; i++)
	{
		// assign a1 to a4
		for (int j = 0; j < 4; j++)
			a[j] = state[j][i];

		b[0] = xtime(a[0]) ^ (xtime(a[1]) ^ a[1]) ^ a[2] ^ a[3];
		b[1] = a[0] ^ xtime(a[1]) ^ (xtime(a[2]) ^ a[2]) ^ a[3];
		b[2] = a[0] ^ a[1] ^ xtime(a[2]) ^ (xtime(a[3]) ^ a[3]);
		b[3] = (xtime(a[0]) ^ a[0]) ^ a[1] ^ a[2] ^ xtime(a[3]);
		for (int j = 0; j < 4; j++)
			state[j][i] = b[j];
	}
}

/*
 * Shiftrows
 * The rows in the updating State is cyclically shifted by a certain offset. 
 * Specifically, row n is left-circularly shifted by n-1 Bytes.
 * 
 * input: state
*/

void ShiftRows(unsigned char state[4][4])
{
	int row;
	unsigned char temp;
	for (row = 0; row < 4; row++)
	{
		for (int i =0; i < row; i++)
		{
			temp = state[row][0];
			state[row][0] = state[row][1];
			state[row][1] = state[row][2];
			state[row][2] = state[row][3];
			state[row][3] = temp;
		}
	}
}

/*
 *  SubWord
 *  Convert 16 bytes into sbox form.
 *
 *  Input: pointer to state
 *
 */
unsigned long SubWord(unsigned long word)
{
	unsigned char* temp = (unsigned char*)&word;
	unsigned char out[4];
	int i = 0;
	for (;i<4;i++){
		out[i] = aes_sbox[(int)temp[i]];
	}
	return *((unsigned long*)out);
}

/*
 * RotWord
 *  rotate the word
 *  Bytes ABCD -> BCDA
 *
 *  Input: address of word
 *  Output: the word after rotation
 */
unsigned long RotWord(unsigned long* word)
{
	return (((*word<<8) & 0xFFFFFFF0)|((*word>>24) & 0x000000FF));
}

/*
* KeyExpansion
* Key Expansion generates a Round Key ( N_b Words) at a time based on the previous
* Round Key (use the original Cipher Key to generate the first Round Key), for a total of
* N_r + 1 Round Keys, called the Key Schedule.
*
* input:  	key,
*			w,
*			Nk
*/
void KeyExpansion(unsigned char key[4][4], unsigned long w[44], unsigned int Nk)
{
	unsigned long temp;
	unsigned int i = 0;
	while (i < Nk)
	{
		w[i] = (unsigned long)((key[0][i]<<24) + (key[1][i]<<16) + (key[2][i]<<8) + (key[3][i]));
		i++;
	}
	i = Nk;
	while (i<4 * (10+1))
	{
		temp = w[i-1];
		if (i % Nk == 0)
			temp = SubWord(RotWord(&temp)) ^ Rcon[i/Nk];
		w[i] = w[i-Nk] ^ temp;
		i = i+1;
	}
}



/*
 * fetch the first second third and fourth byte and put them into 4 element array
 */

void splitIntoArray(unsigned long num, unsigned char array[4])
{
	unsigned long one = num >> 24;
	unsigned long two = num >> 16;
	unsigned long thr = num >> 8;
	unsigned long fou = num;
	array[0] = one & 0xFF;
	array[1] = two & 0xFF;
	array[2] = thr & 0xFF;
	array[3] = fou & 0xFF;
}

void AddRoundKey(unsigned char state[4][4], unsigned long* w, int round){
	int i;
	int j;
	for (i=0; i<4;i++){
		for (j=0;j<4;j++){
			state[i][j] = state[i][j] ^ ((w[j+4*round]>>((3-i)*8)) & 0xFF);
		}
	}
}

/*
 *  SubByte
 *  Convert one byte into sbox form.
 *
 *  Input: pointer to the byte
 */
void SubByte(unsigned char* byte)
{
	*byte = aes_sbox[(int)*byte];
}

/*
*	input:
*	msg_ascii 	//? scanf()存入的是ascii码，在这个函数中我们希望将其转化为Hex.
*	key_ascii	//? e.g. ECE2 -> 0xEC,0xE2. 重点是对单个字符，保留ascii码后4位，两个字符转化为2位Hex.
*
*	output:
*	msg_enc		//? 将这两个输出存入对应的register
*	key			
*/
void encrypt(unsigned char * msg_ascii, unsigned char * key_ascii, 
			 unsigned int * msg_enc, unsigned int * key)
{
	// Implement this function
	AES_PTR[14] = 0;
	AES_PTR[15] = 0;
	int i,j,round;
	unsigned long w[4*(10+1)];

	unsigned char state[4][4];
	unsigned char keyInit[4][4];
	// assign the words for state and key
	for (i=0;i<16;i++){
		state[i%4][i/4] = charsToHex(msg_ascii[2*i],msg_ascii[2*i+1]);
		keyInit[i%4][i/4] = charsToHex(key_ascii[2*i],key_ascii[2*i+1]);
	}

	// create words by KeyExpansion
	KeyExpansion(keyInit,w,4);
	AddRoundKey(state, w, 0);

	for (round=1; round<10;round++){
		SubBytes(state);
		ShiftRows(state);
		MixColumns(state);
		AddRoundKey(state, w, round);
	}
	// last round
	SubBytes(state);
	ShiftRows(state);
	AddRoundKey(state, w, 10);

	// assign output
	for (i=0; i<4; i++){
		msg_enc[i] = state[0][i]<<24 | state[1][i]<<16 | state[2][i]<<8 | state[3][i];
		key [i] = keyInit[0][i]<<24 | keyInit[1][i]<<16 | keyInit[2][i]<<8 | keyInit[3][i];
	}


}

/*
 * decrypt
 *  Perform AES decryption in hardware.
 *
 *  Input:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *              key - Pointer to 4x 32-bit int array that contains the input key
 *  Output: msg_dec - Pointer to 4x 32-bit int array that contains the decrypted message
 */
void decrypt(unsigned int * msg_enc, unsigned int * msg_dec, unsigned int * key)
{
	// Implement this function
	AES_PTR[14] = 0;
	AES_PTR[15] = 0;
	int i = 0;
	// set the AES_KEY and AES_MSG_EN
	//? 值得注意的是这里的赋值顺序，C代码index从小到大，Verilog index从大到小
	for (i=0; i<4; i++){
		AES_PTR[i] = key[3-i];
		AES_PTR[i+4] = msg_enc[3-i];
	}

	// set the AES_START to 1
	AES_PTR[14] = 1;

	// wait for AES_DONE, this process will be
	// implemented by hardware in hdl.
	while (AES_PTR[15] == 0)

	msg_dec[3] = AES_PTR[8];
	msg_dec[2] = AES_PTR[9];
	msg_dec[1] = AES_PTR[10];
	msg_dec[0] = AES_PTR[11];

	// set the AES_START to 0
	AES_PTR[14] = 0;
	AES_PTR[15] = 0;
}

/*
 *  main
 *  Allows the user to enter the message, key, and select execution mode
 */
int main()
{
	// Input Message and Key as 32x 8-bit ASCII Characters ([33] is for NULL terminator)
	unsigned char msg_ascii[33];
	unsigned char key_ascii[33];
	// Key, Encrypted Message, and Decrypted Message in 4x 32-bit Format to facilitate Read/Write to Hardware
	unsigned int key[4];
	unsigned int msg_enc[4];
	unsigned int msg_dec[4];

	printf("Select execution mode: 0 for testing, 1 for benchmarking: ");
	scanf("%d", &run_mode);

	if (run_mode == 0) {
		// Continuously Perform Encryption and Decryption
		while (1) {
			int i = 0;
			printf("\nEnter Message:\n");
			scanf("%s", msg_ascii);
			printf("\n");
			printf("\nEnter Key:\n");
			scanf("%s", key_ascii);
			printf("\n");
			encrypt(msg_ascii, key_ascii, msg_enc, key);
			printf("\nEncrpted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_enc[i]);
			}
			// printf("\nkey is: \n");
			// for(i = 0; i < 4; i++){
			// 	printf("%08x ", key[i]);
			// }
			// printf("\n");

			// Run Decryption
			decrypt(msg_enc, msg_dec, key);
			printf("\nDecrypted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_dec[i]);
			}
			printf("\n");
		}
	}
	else {
		// Run the Benchmark
		int i = 0;
		int size_KB = 2;
		// Choose a random Plaintext and Key
		for (i = 0; i < 32; i++) {
			msg_ascii[i] = 'a';
			key_ascii[i] = 'b';
		}
		// Run Encryption
		clock_t begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			encrypt(msg_ascii, key_ascii, msg_enc, key);
		clock_t end = clock();
		double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		double speed = size_KB / time_spent;
		printf("Software Encryption Speed: %f KB/s \n", speed);

		// Run Decryption
		begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			decrypt(msg_enc, msg_dec, key);
		end = clock();
		time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		speed = size_KB / time_spent;
		printf("Hardware Encryption Speed: %f KB/s \n", speed);
	}
	return 0;
}

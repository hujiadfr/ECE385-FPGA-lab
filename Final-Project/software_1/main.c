#include <stdio.h>
#include "system.h"
#include "time.h"
#include "alt_types.h"
#include <unistd.h>  // usleep
#include "io_handler.h"
#include "ship_logic.h"
#include "usb_main.h"
//#ifdef _WIN32
//#include <Windows.h>
//#else
//#include <unistd.h>
//#endif

#define UP_END 0
#define DOWN_END 479
#define NOPRESS 0
#define LEFT_END 0
#define RIGHT_END 637
#define MAX_KEY 4 // allow four keys pressed in the same time

// BASE of avalon_bus_interface
volatile unsigned int *game_file =(unsigned int*) 0x00000100;

int win;
int developer_mode;

enum Key_event
{
	PRESS_UP = 1, 
	PRESS_DOWN, 
	PRESS_LEFT, 
	PRESS_RIGHT, 
	PRESS_ATK, 
	PRESS_SKILL
}event;


void frame_clock (double frame_time){
	double time_to_switch = frame_time;
	clock_t begin = clock();
	clock_t end = clock();
	while ((double)(end-begin)/CLOCKS_PER_SEC <time_to_switch){
		end = clock();
	}
}


/*
 * WASD or J: Update saber motion accordingly.
 * or
 * ENTER: 		game_start = 1;
 * ESC:	  		game_start = 0, developer_mode = 0;
 * BACKSPACE: 	game_start = 0, developer_mode = 1;
 */
void key_event(int* game_start, saber_t* saber){
	unsigned long key;
	int key_array[4];
	int cur_key;
	
	key = get_keycode();
	key_array[0]= (key>>24) & 0xff;
	key_array[1]= (key>>16) & 0xff;
	key_array[2]= (key>>8) & 0xff;
	key_array[3]= key & 0xff;

	for (int i =0; i< MAX_KEY;i++){
		cur_key = key_array[i];
		if (cur_key == KEY_W ){
			press_w(saber);
		}
		else if (cur_key == KEY_S){
			press_s(saber);
		}
		if (cur_key == KEY_A){
			press_a(saber);
		}
		else if (cur_key == KEY_D){
			press_d(saber);
		}
		else if (cur_key == KEY_J){
			press_j(saber);
		}
		else{
			stop(saber);
		}
		// if (cur_key == KEY_K){
		// 	press_k(saber);
		// }
		// if (cur_key == KEY_L){
		// 	press_l(saber);
		// }

		if (cur_key == KEY_ENTER){
			*game_start = 1;
			return;
		}
		else if (cur_key == KEY_ESC){
			*game_start = 0;
			developer_mode = 0;
			return;
		}
		else if (cur_key == KEY_ESC){
			*game_start = 0;
			return;
		}
		else if (cur_key == KEY_BACKSPACE){
			*game_start = 0;
			developer_mode = 1;
			return;
		}
		else{
			return;
		}
	}
}
/*
 * 1. update saber state and x,y
 * 2. update gamefile
*/
void game_update(int *game_start,saber_t *saber){
	// update saber state and x, y
	update(saber);

	// send the information to the hardware
	gamefile_update(game_start, saber);
}

/*
 * gamefile_update : use characters information to update the game file,
 * 					which will communicate with the hardware
 */
void gamefile_update(int *game_start, saber_t *saber){
	game_file[0] = saber->exist;
	game_file[1] = saber->x;
	game_file[2] = saber->y;
	game_file[3] = saber->state;
	game_file[4] = saber->HP > 2;

	// game_file[7] = snowman->exist;
	// game_file[8] = snowman->x;
	// game_file[9] = snowman->y;
	// game_file[10] = snowman->state;

	// game_file[13] = gingerbreadman->exist;
	// game_file[14] = gingerbreadman->x;
	// game_file[15] = gingerbreadman->y;
	// game_file[16] = gingerbreadman->state;

	game_file[19] = *game_start;
	game_file[20] = *game_start==0;
	game_file[22] = saber->HP<=0;

	game_file[24] = saber -> HP;
	game_file[25] = *game_start;

	// game_file[26] = snowman->blood_state<=BLOOD3;
	// game_file[27] = gingerbreadman->blood_state<=BLOOD3;
	// game_file[28] = snowman->blood_state;
	// game_file[29] = gingerbreadman->blood_state;
	// game_file[30] = snowman->attack_x-20;
	// game_file[31] = snowman->attack_y;
	// game_file[32] = gingerbreadman->attack_x;
	// game_file[33] = gingerbreadman->attack_y;

	// game_file[35] = saber -> Excalibur_state < EXCALIBURNULL;
	// game_file[36] = (saber->FaceDirection==RIGHT)? saber->x+EXCALIBUR_LENGTH/2+EXCALIBUR_X_BIAS: saber->x-(EXCALIBUR_LENGTH/2+EXCALIBUR_X_BIAS);
	// game_file[37] = saber-> y+EXCALIBUR_Y_BIAS;
	// game_file[38] = saber->Excalibur_state;
	game_file[39] = saber->FaceDirection == LEFT;
	game_file[41] = win;

	// game_file[43] = saber->Excalibur_remain;
	game_file[44] = *game_start;
}

/*
 * test movement
 */
void test_round(int *game_start, saber_t *saber){
	saber_init(&saber);
	while(*game_start == 1){
		// use key code update saber state, vx and vy
		key_event(&game_start, &saber);
		game_update(&game_start, &saber);
	}
}

int main(){
	saber_t saber;
	int game_start = 0;
	usb_init();		// initialize usb
	developer_mode = 0;

	GAME_INITIAL:
	win = 0;
	while(game_start == 0){
		key_event(&game_start, &saber);
		gamefile_update(&game_start, &saber);
	}

	GAME_START:
	printf("game start\n");
	int frame_time = 0.2;
	while (1){
		frame_clock(frame_time);
		// wait until next clock
		test_round(&game_start, &saber);
		if (game_start == 0){
			printf("back to initial\n");
			goto GAME_INITIAL;
		}

		//win
		// win = 1;
		// while(1){
		// 	key_event(&game_start, &saber);
		// 	gamefile_update(&game_start, &saber);
		// 	if (game_start == 0){goto GAME_INITIAL;}
		// }
		// printf("saber vx :%x\n", saber.vx);
	}
}
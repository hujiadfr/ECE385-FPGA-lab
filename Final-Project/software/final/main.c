#include <stdio.h>
#include "system.h"
#include "time.h"
#include "alt_types.h"
#include <unistd.h>  // usleep
#include "io_handler.h"
#include "ship_logic.h"
#include "usb_main.h"
#include "torpedo.h"
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
volatile unsigned int *game_file =(unsigned int*) GAME_CORE_BASE;

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
void key_event(int* game_start, ship_t* ship, ship_t* ship2, torpedo_t *torpedo1, torpedo_t *torpedo2){
	unsigned long key;
	int key_array[4];
	int cur_key, cur_key2;
	
	key = get_keycode();
	key_array[0]= (key>>24) & 0xff;
	key_array[1]= (key>>16) & 0xff;
	key_array[2]= (key>>8) & 0xff;
	key_array[3]= key & 0xff;

	for (int i =0; i < 2;i++){
		cur_key = key_array[i];
		cur_key2 = key_array[i+2];
		if (cur_key == KEY_W || cur_key2 == KEY_W ){
			press_w(ship);
		}
		else if (cur_key == KEY_S || cur_key2 == KEY_S ){
			press_s(ship);
		}
		if (cur_key == KEY_A || cur_key2 == KEY_A){
			press_a(ship);
		}
		else if (cur_key == KEY_D || cur_key2 == KEY_D ){
			press_d(ship);
		}
		if (cur_key == KEY_J ||cur_key2 == KEY_J){
			press_j(ship, torpedo1, SHIP2);
		}
		else if(cur_key == KEY_M ||cur_key2 == KEY_M){
			press_j(ship2, torpedo2, SHIP1);
		}
		if (cur_key == KEY_UP || cur_key2 == KEY_UP){
			press_w(ship2);
		}
		else if (cur_key == KEY_DOWN || cur_key2 == KEY_DOWN){
			press_s(ship2);
		}
		if (cur_key == KEY_LEFT || cur_key2 == KEY_LEFT){
			press_a(ship2);
		}
		else if (cur_key == KEY_RIGHT || cur_key2 == KEY_RIGHT){
			press_d(ship2);
		}
//		else{
//			stop(ship);
//			stop(ship2);
//		}
		// if (cur_key == KEY_K){
		// 	press_k(ship);
		// }
		// if (cur_key == KEY_L){
		// 	press_l(ship);
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
void game_update(int *game_start,ship_t *ship, ship_t *ship2, torpedo_t *torpedo1, torpedo_t *torpedo2){
	// update saber state and x, y
	update(ship, ship2);
	detect_ship_attack(ship,ship2);
//	update_tor(torpedo1, torpedo2, ship, ship2);
	// send the information to the hardware
	gamefile_update(game_start, ship, ship2, torpedo1, torpedo2);
}

/*
 * gamefile_update : use characters information to update the game file,
 * 					which will communicate with the hardware
 */
void gamefile_update(int *game_start, ship_t *ship, ship_t *ship2, torpedo_t *torpedo1, torpedo_t *torpedo2){
	game_file[0] = ship->exist;
	game_file[1] = ship->x;
	game_file[2] = ship->y;
	game_file[3] = ship->state;
	game_file[4] = ship->HP > 2;

	game_file[7] = ship2->exist;
	game_file[8] = ship2->x;
	game_file[9] = ship2->y;
	game_file[10] = ship2->state;
	game_file[11] = ship2->HP > 2;

	game_file[12] = torpedo1->x[0];
	game_file[13] = torpedo1->x[1];
	game_file[14] = torpedo1->x[2];
	game_file[15] = torpedo1->x[3];
	game_file[16] = torpedo1->y[0];
	game_file[17] = torpedo1->y[1];
	game_file[18] = torpedo1->y[2];
	game_file[19] = torpedo1->y[3];

	game_file[19] = *game_start;
	game_file[20] = *game_start==0;
	game_file[21] = ship2->HP<=0;
	game_file[22] = ship->HP<=0;
	game_file[23] = ship2 -> HP;
	game_file[24] = ship -> HP;
	game_file[25] = *game_start;

	game_file[26] = torpedo2->x[0];
	game_file[27] = torpedo2->x[1];
	game_file[28] = torpedo2->x[2];
	game_file[29] = torpedo2->x[3];
	game_file[30] = torpedo2->y[0];
	game_file[31] = torpedo2->y[1];
	game_file[32] = torpedo2->y[2];
	game_file[33] = torpedo2->y[3];

	// game_file[35] = saber -> Excalibur_state < EXCALIBURNULL;
	// game_file[36] = (saber->FaceDirection==RIGHT)? saber->x+EXCALIBUR_LENGTH/2+EXCALIBUR_X_BIAS: saber->x-(EXCALIBUR_LENGTH/2+EXCALIBUR_X_BIAS);
	 game_file[37] = torpedo1->stop;
	 game_file[38] = torpedo2->stop;
	game_file[39] = ship->FaceDirection == LEFT;
	game_file[40] = ship2->FaceDirection == LEFT;
	game_file[41] = win;

	// game_file[43] = saber->Excalibur_remain;
	game_file[44] = *game_start;
}

/*
 * test movement
 */
void test_round(int *game_start, ship_t *ship, ship_t *ship2, torpedo_t *torpedo1, torpedo_t *torpedo2){
	ship_init(ship, ship2);
	init_tor(torpedo1, SHIP2);
	init_tor(torpedo2, SHIP1);
	while(*game_start == 1){
		// use key code update saber state, vx and vy
		detect_ship_attack(ship, ship2);
		key_event(game_start, ship, ship2, torpedo1, torpedo2);
		game_update(game_start, ship, ship2, torpedo1, torpedo2);
//		printf("%d\n",game_file[1]);
	}
}

int main(){
	printf("start");
	ship_t ship1, ship2;
	torpedo_t torpedo1, torpedo2;
	int game_start = 0;
	usb_init();		// initialize usb
	developer_mode = 0;
	int frame_time;
	frame_time = 2;
	while(1){
		win = 0;
		while(game_start == 0){
			key_event(&game_start, &ship1, &ship2, &torpedo1, &torpedo2);
			gamefile_update(&game_start, &ship1, &ship2, &torpedo1, &torpedo2);
		}
		printf("game start\n");

		while (1){
			frame_clock(frame_time);
			// wait until next clock
			test_round(&game_start, &ship1, &ship2, &torpedo1, &torpedo2);
			if (game_start == 0){
				printf("back to initial\n");
				break;
			}
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

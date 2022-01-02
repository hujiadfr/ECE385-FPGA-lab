#include "choose_ship.h"
#include "usb_main.h"
/*
 * WASD or J: Update saber motion accordingly.
 * or
 * ENTER: 		game_start = 1;
 * ESC:	  		game_start = 0, developer_mode = 0;
 * BACKSPACE: 	game_start = 0, developer_mode = 1;
 */
void choose_ship(int* player1_ready, int* player2_ready, ship_t* ship, ship_t* ship2){
	unsigned long key, key2, key3;
	int key_array[4];
	int cur_key, cur_key2;
	
	get_keycode(&key, &key2, &key3);
	key_array[0]= (key>>24) & 0xff;
	key_array[1]= (key>>16) & 0xff;
	key_array[2]= (key>>8) & 0xff;
	key_array[3]= key & 0xff;


		
        if(!*(player1_ready)){
            if (key_array[0] == KEY_A || key_array[1] == KEY_A ||
        			key_array[2] == KEY_A ||key_array[3] == KEY_A ||
        			key_array[4] == KEY_A || key_array[5] == KEY_A){
                if(ship->choose_ship == 0){
                    ship->choose_ship = SHIP_KIND_MAX;
                }
                else{
                    ship->choose_ship--;
                }
            }
            else if (key_array[0] == KEY_D || key_array[1] == KEY_D ||
    				key_array[2] == KEY_D || key_array[3] == KEY_D ||
    				key_array[4] == KEY_D || key_array[5] == KEY_D){
                if(ship->choose_ship == SHIP_KIND_MAX){
                    ship->choose_ship = 0;
                }
                else{
                    ship->choose_ship++;
                }
            }
            else if (key_array[0] == KEY_J ||key_array[1] == KEY_J
    				||key_array[2] == KEY_J ||key_array[3] == KEY_J
    				||key_array[4] == KEY_J ||key_array[5] == KEY_J){
                *player1_ready = 1;
                ship->ship_choose_ready = 1;
            }
        }

        if(!(*player2_ready)){
            if (  key_array[0] == KEY_LEFT ||key_array[1] == KEY_LEFT
				||key_array[2] == KEY_LEFT ||key_array[3] == KEY_LEFT
				||key_array[4] == KEY_LEFT ||key_array[5] == KEY_LEFT){
                if(ship2->choose_ship == 0){
                    ship2->choose_ship = SHIP_KIND_MAX;
                }
                else{
                    ship2->choose_ship--;
                }
            }
            else if ( key_array[0] == KEY_RIGHT ||key_array[1] == KEY_RIGHT
    				||key_array[2] == KEY_RIGHT ||key_array[3] == KEY_RIGHT
    				||key_array[4] == KEY_RIGHT ||key_array[5] == KEY_RIGHT){
                if(ship2->choose_ship == SHIP_KIND_MAX){
                    ship2->choose_ship = 0;
                }
                else{
                    ship2->choose_ship++;
                }
            }
            else if (key_array[0] == KEY_SPACE ||key_array[1] == KEY_SPACE||
    				key_array[2] == KEY_SPACE|| key_array[3] == KEY_SPACE||
    				key_array[4] == KEY_SPACE || key_array[5] == KEY_SPACE){
                *player2_ready = 1;
                ship2->ship_choose_ready = 1;
            }
		}

		if(player1_ready && player2_ready){
            return;
        }
		else if (cur_key == KEY_ESC){
			*player1_ready = 0;
            *player2_ready = 0;
            ship->ship_choose_ready = 0;
            ship2->ship_choose_ready = 0;
			return;
		}

}


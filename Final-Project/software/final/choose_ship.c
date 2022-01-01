// #include "choose_ship.h"
#include "ship_logic.h"
#include "usb_main.h"
/*
 * WASD or J: Update saber motion accordingly.
 * or
 * ENTER: 		game_start = 1;
 * ESC:	  		game_start = 0, developer_mode = 0;
 * BACKSPACE: 	game_start = 0, developer_mode = 1;
 */
void choose_ship(int* player1_ready, int* player2_ready, ship_t* ship, ship_t* ship2){
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
		
        if(!player1_ready){
            if (cur_key == KEY_A || cur_key2 == KEY_A){
                if(ship->choose_ship == 0){
                    ship->choose_ship = SHIP_KIND_MAX;
                }
                else{
                    ship->choose_ship--;
                }
            }
            else if (cur_key == KEY_D || cur_key2 == KEY_D ){
                if(ship->choose_ship == SHIP_KIND_MAX){
                    ship->choose_ship = 0;
                }
                else{
                    ship->choose_ship++;
                }
            }
            else if (cur_key == KEY_J){
                player1_ready = 1;
            }
        }

        if(!player2_ready){
            if (cur_key == KEY_LEFT || cur_key2 == KEY_LEFT){
                if(ship2->choose_ship == 0){
                    ship2->choose_ship = SHIP_KIND_MAX;
                }
                else{
                    ship2->choose_ship--;
                }
            }
            else if (cur_key == KEY_RIGHT || cur_key2 == KEY_RIGHT){
                if(ship2->choose_ship == SHIP_KIND_MAX){
                    ship2->choose_ship = 0;
                }
                else{
                    ship2->choose_ship++;
                }
            }
            else if (cur_key == KEY_SPACE){
                player2_ready;
            }
		}

		if(player1_ready && player2_ready){
            return;
        }
		else if (cur_key == KEY_ESC){
			player1_ready = 0;
            player2_ready = 0;
			return;
		}
	}
}

void ship_choose_update(int* player1_ready, int* player2_ready, ship_t *ship, ship_t *ship2){
    game_file[60] = ship->choose_ship;
    game_file[61] = ship2->choose_ship;
    game_file[62] = ship->ship_choose_ready;
    game_file[63] = ship2->ship_choose_ready;
}
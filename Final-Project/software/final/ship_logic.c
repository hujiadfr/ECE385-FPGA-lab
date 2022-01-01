#include "ship_logic.h"
#include <stdio.h>

void press_w(ship_t *saber){
    if (saber->vy > -VY_MOST){
    	saber->vy--;
    }
}

void press_s(ship_t *saber){
    if (saber->vy < VY_MOST){
    	saber->vy++;
    }
}

void press_a(ship_t *saber){
	if (saber->state == STOP){
		saber->state = WALK_LEFT1;
		saber->vx--;
		saber->FaceDirection = LEFT;
	}
	else if (saber->state == WALK_LEFT1 ){
		if (saber->vx > -VX_MOST){
			saber->vx--;
		}
	}
	else if(saber->state == WALK_RIGHT1){
		saber->state = WALK_LEFT1;
		saber -> vx--;
		saber->FaceDirection = LEFT;
	}
}

void press_d(ship_t *saber){
	if (saber->state == STOP){
		saber->vx++;
		saber->state = WALK_RIGHT1;
		saber->FaceDirection = RIGHT;
	}
	else if (saber->state == WALK_RIGHT1 ){
		if (saber->vx < VX_MOST){
			saber->vx++;
		}
	}
	else if(saber->state == WALK_LEFT1){
		saber->state = WALK_RIGHT1;
		saber -> vx++;
		saber->FaceDirection = RIGHT;
	}
}

// attack

// void press_k(saber_t *saber){
// 	if (saber->Excalibur_remain ==0){
// 		return;
// 	}
// 	if (saber->state <= WALK_LEFT6){
// 		saber-> state = EXCALIBUR_LEFT1;
// 		saber-> state_count = 0;
// 		saber-> Excalibur_state = EXCALIBUR1;
// 		saber-> Excalibur_count = 0;
// 		saber-> Excalibur_remain --;
// 	}else if (saber->state >= WALK_RIGHT1 &&saber->state <= WALK_RIGHT6){
// 		saber-> state = EXCALIBUR_RIGHT1;
// 		saber-> Excalibur_state = EXCALIBUR1;
// 		saber-> Excalibur_count = 0;
// 		saber-> Excalibur_remain --;
// 	}
// }


void ship_init(ship_t *ship, ship_t *ship2){
	ship -> exist = 1;
	ship -> vx = 0;
	ship -> vy = 0;
	ship -> x = INIT_X;
	ship -> y = INIT_Y;
	ship -> HP = 3;
	ship -> ATK = 3;
	ship -> state = WALK_RIGHT1;
	ship -> state_count = 0;
	// ship -> Excalibur_state = EXCALIBURNULL;
	// ship -> Excalibur_damage = 5;
	// ship -> Excalibur_remain = 3;
	ship -> IsFighting = 0;
	ship -> FaceDirection = RIGHT;
	ship -> injuring =0;

	ship2 -> exist = 1;
	ship2 -> vx = 0;
	ship2 -> vy = 0;
	ship2 -> x = INIT_X2;
	ship2 -> y = INIT_Y2;
	ship2 -> HP = 3;
	ship2 -> ATK = 3;
	ship2 -> state = WALK_RIGHT1;
	ship2 -> state_count = 0;
	// ship2 -> Excalibur_state = EXCALIBURNULL;
	// ship2 -> Excalibur_damage = 5;
	// ship2 -> Excalibur_remain = 3;
	ship2 -> IsFighting = 0;
	ship2 -> FaceDirection = RIGHT;
	ship2 -> injuring =0;
}


void update(ship_t *ship, ship_t *ship2){
	ship -> x = ship ->x + ship->vx;
	ship -> y = ship ->y + ship->vy;
	ship2 -> x = ship2 ->x + ship2->vx;
	ship2 -> y = ship2 ->y + ship2->vy;
	// if (saber->injuring){
	// 	saber->exist = (saber->injuring-1)/2 % 2;
	// 	saber->injuring = (saber->injuring>=8)?0:saber->injuring+1;
	// }

	// if (saber->Excalibur_state< EXCALIBURNULL ){
	// 	if (saber->Excalibur_count ++ >EXCALIBUR_COUNT_MAX){
	// 		saber->Excalibur_state++;
	// 		saber->Excalibur_count = 0;
	// 	}
	// }

	// boundary check
	if (ship-> x < LEFT_MOST){ship-> x = LEFT_MOST;}
	if (ship-> x > RIGHT_MOST){ship-> x = RIGHT_MOST;}
	if (ship-> y < UP_MOST){ship-> y = UP_MOST;}
	if (ship-> y > DOWN_MOST){ship-> y = DOWN_MOST;}

	if (ship2-> x < LEFT_MOST){ship2-> x = LEFT_MOST;}
	if (ship2-> x > RIGHT_MOST){ship2-> x = RIGHT_MOST;}
	if (ship2-> y < UP_MOST){ship2-> y = UP_MOST;}
	if (ship2-> y > DOWN_MOST){ship2-> y = DOWN_MOST;}

	update_helper(ship, ATTACK, ATTACK);
	// update_helper(ship, EXCALIBUR_LEFT1, EXCALIBUR_LEFT4);
	// update_helper(ship, EXCALIBUR_RIGHT1, EXCALIBUR_RIGHT4);

	update_helper(ship2, ATTACK, ATTACK);
	update_helper(ship2, ATTACK, ATTACK);
	// update_helper(ship2, EXCALIBUR_LEFT1, EXCALIBUR_LEFT4);
	// update_helper(ship2, EXCALIBUR_RIGHT1, EXCALIBUR_RIGHT4);
	// update_helper(saber, GET_HITTED, saber->state);

	// update_helper(saber, POSE_LEFT1, POSE_LEFT2);
	// update_helper(saber, POSE_RIGHT1, POSE_RIGHT2);
}

void stop(ship_t *ship){
	if(ship-> vx == 0 && ship-> vy == 0){
		ship->state = STOP;
	}
}

// help update the frame state information
void update_helper(ship_t *ship, int state_start, int state_end){
	int final_frame;
	final_frame = ship->FaceDirection == RIGHT? WALK_RIGHT1:WALK_LEFT1;
	if (ship->HP == 0){
		ship->exist = 0;
	}
	if (ship->state >= state_start && ship->state<= state_end){
		ship->vx = 0;
		ship->vy = 0;
		if (ship->state_count ++ > STATE_COUNT_MAX){
			ship->state = (ship->state == state_end)? final_frame:ship->state+1;
			ship->state_count = 0;
			ship->IsFighting = 0;
		}
	}
}

//����Ƿ��ڴ��������ڣ��Ƿ���1 ���Ƿ���0
int detect(ship_t *ship, int x, int y, int dis){
	int dis_x, dis_y;
	dis_x = ship->x - x;
	dis_y = ship->y - y;
	if (dis_x*dis_x + dis_y*dis_y < dis*dis)
		return 1;
	else
		return 0;
}

void detect_ship_attack(ship_t *ship1, ship_t *ship2){
	int flag = detect(ship1, ship2->x, ship2->y, 40);
	if(flag){ //ײ����
		ship1->vx = 0;
		ship2->vx = 0;
		ship1->vy = 0;
		ship2->vy = 0;
	}
	return ;
}


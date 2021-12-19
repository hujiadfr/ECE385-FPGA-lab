#include "ship_logic.h"
#include <stdio.h>

void press_w(saber_t *saber){
    if (saber->vy > -VY_MOST){
    	saber->vy--;
    }
}

void press_s(saber_t *saber){
    if (saber->vy < VY_MOST){
    	saber->vy++;
    }
}

void press_a(saber_t *saber){
    if (saber->state == WALK_LEFT1 ){
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

void press_d(saber_t *saber){
    if (saber->state == WALK_RIGHT1 ){
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
void press_j(saber_t *saber){
    if (saber->state == WALK_LEFT1){
		saber-> state = ATTACK_LEFT1;
		saber-> state_count = 0;
		saber-> IsFighting = 1;
	}else if (saber->state == WALK_RIGHT1){
		saber-> state = ATTACK_RIGHT1;
		saber-> state_count = 0;
		saber-> IsFighting = 1;
	}
}

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


void saber_init(saber_t *saber){
	saber -> exist = 1;
	saber -> vx = 0;
	saber -> vy = 0;
	saber -> x = INIT_X;
	saber -> y = INIT_Y;
	saber -> HP = 3;
	saber -> ATK = 3;
	saber -> state = WALK_RIGHT1;
	saber -> state_count = 0;
	saber -> Excalibur_state = EXCALIBURNULL;
	saber -> Excalibur_damage = 5;
	saber -> Excalibur_remain = 3;
	saber -> IsFighting = 0;
	saber -> FaceDirection = RIGHT;
	saber -> injuring =0;
}


void update(saber_t *saber){
	saber -> x = saber ->x + saber->vx;
	saber -> y = saber ->y + saber->vy;

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
	if (saber-> x < LEFT_MOST){saber-> x = LEFT_MOST;}
	if (saber-> x > RIGHT_MOST){saber-> x = RIGHT_MOST;}
	if (saber-> y < UP_MOST){saber-> y = UP_MOST;}
	if (saber-> y > DOWN_MOST){saber-> y = DOWN_MOST;}

	update_helper(saber, ATTACK_LEFT1, ATTACK_LEFT1);
	update_helper(saber, ATTACK_RIGHT1, ATTACK_RIGHT1);
	update_helper(saber, EXCALIBUR_LEFT1, EXCALIBUR_LEFT4);
	update_helper(saber, EXCALIBUR_RIGHT1, EXCALIBUR_RIGHT4);
	// update_helper(saber, GET_HITTED, saber->state);

	// update_helper(saber, POSE_LEFT1, POSE_LEFT2);
	// update_helper(saber, POSE_RIGHT1, POSE_RIGHT2);
}

void stop(saber_t *saber){
	if(saber-> vx == 0 && saber-> vy == 0){
		saber->state = STOP;
	}
}

// help update the frame state information
void update_helper(saber_t*saber, int state_start, int state_end){
	int final_frame;
	final_frame = saber->FaceDirection == RIGHT? WALK_RIGHT1:WALK_LEFT1;
	if (saber->HP == 0){
		saber->exist = 0;
	}
	if (saber->state >= state_start && saber->state<= state_end){
		saber->vx = 0;
		saber->vy = 0;
		if (saber->state_count ++ > STATE_COUNT_MAX){
			saber->state = (saber->state == state_end)? final_frame:saber->state+1;
			saber->state_count = 0;
			saber->IsFighting = 0;
		}
	}
}

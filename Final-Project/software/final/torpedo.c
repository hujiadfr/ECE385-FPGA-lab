#include "torpedo.h"
#include "ship_logic.h"
#include <stdio.h>
#include "system.h"

void generate_tor(torpedo_t *torpedo, ship_t *ship, int target){
	if(!torpedo -> stop){
		printf("The cooldown period has not yet passed");
		return;
	}
	if (target == 1){
		torpedo->stop = 0;
		torpedo->x[0] = ship->x-20;
		torpedo->x[1] = ship->x-20;
		torpedo->x[2] = ship->x-20;
		torpedo->x[3] = ship->x-20;
		torpedo->y[0] = ship->y-20;

		for (int i=1; i<4; i++)
			torpedo->y[i] = torpedo->y[i-1] + 20;

		torpedo->vx[0] = 4;
		torpedo->vy[0] = -3;
		torpedo->vx[1] = 5;
		torpedo->vy[1] = -1;
		torpedo->vx[2] = 5;
		torpedo->vy[2] = 1;
		torpedo->vx[3] = 4;
		torpedo->vy[3] = 3;

		torpedo->attack_state[0] = TRACING;
		torpedo->attack_state[1] = TRACING;
		torpedo->attack_state[2] = TRACING;
		torpedo->attack_state[3] = TRACING;

		torpedo->target = target;
	}
	else{
		torpedo->stop = 0;
		torpedo->x[0] = ship->x+20;
		torpedo->x[1] = ship->x+20;
		torpedo->x[2] = ship->x+20;
		torpedo->x[3] = ship->x+20;
		torpedo->y[0] = ship->y-20;
		for (int i=1; i<4; i++)
			torpedo->y[i] = torpedo->y[0] + i*6;

		torpedo->vx[0] = -4;
		torpedo->vy[0] = -3;
		torpedo->vx[1] = -5;
		torpedo->vy[1] = -1;
		torpedo->vx[2] = -5;
		torpedo->vy[2] = 1;
		torpedo->vx[3] = -4;
		torpedo->vy[3] = 3;

		torpedo->attack_state[0] = TRACING;
		torpedo->attack_state[1] = TRACING;
		torpedo->attack_state[2] = TRACING;
		torpedo->attack_state[3] = TRACING;

		torpedo->target = target;
	}
}


void press_j(ship_t *ship, torpedo_t *torpedo, int target){
//    if (ship->state == WALK_LEFT1){
		ship-> state = ATTACK;
		ship-> state_count = 0;
		ship-> IsFighting = 1;
		generate_tor(torpedo, ship, target);
//	}else if (ship->state == WALK_RIGHT1){
//		ship-> state = ATTACK;
//		ship-> state_count = 0;
//		ship-> IsFighting = 1;
//		generate_tor(torpedo, ship, target);
//	}
}

void upstate_tor(torpedo_t *torpedo, ship_t *ship1, ship_t *ship2){
	int i;
	if(torpedo->stop)
		return;
	for(i = 0; i < 4 ;i++){
		if (torpedo->x[i] > RIGHT_MOST || torpedo->x[i] < LEFT_MOST){
			torpedo->x[i] = 0;
			torpedo->y[i] = 0;
			torpedo->vx[i] = 0;
			torpedo->vy[i] = 0;
			torpedo->attack_state[i] = DESTROY;
		}
		else if (torpedo->y[i] < UP_MOST || torpedo->y[i] > DOWN_MOST){
			torpedo->x[i] = 0;
			torpedo->y[i] = 0;
			torpedo->vx[i] = 0;
			torpedo->vy[i] = 0;
			torpedo->attack_state[i] = DESTROY;
		}
		else if (detect(ship1,torpedo->x[i], torpedo->y[i], 25) && torpedo->target == 0){
			torpedo->x[i] = 0;
			torpedo->y[i] = 0;
			torpedo->vx[i] = 0;
			torpedo->vy[i] = 0;
			torpedo->attack_state[i] = HIT;
			if (ship2->choose_ship == 0)
				ship1->HP -= 2;
			else
				ship1->HP -= 4;
		}
		else if (detect(ship2,torpedo->x[i], torpedo->y[i], 25) && torpedo->target == 1){
			torpedo->x[i] = 0;
			torpedo->y[i] = 0;
			torpedo->vx[i] = 0;
			torpedo->vy[i] = 0;
			torpedo->attack_state[i] = HIT;
			if (ship1->choose_ship == 0)
				ship2->HP -= 2;
			else
				ship2->HP -= 4;
		}
		else if (detect(ship1,torpedo->x[i], torpedo->y[i], 150) && torpedo->target == 0) //distance > 150; torpedo Permanently switch to inertial guidance
		{
			torpedo->attack_state[i] = INERTIAL;
		}
		else if (detect(ship2,torpedo->x[i], torpedo->y[i], 150) && torpedo->target == 1) //distance > 150; torpedo Permanently switch to inertial guidance
		{
			torpedo->attack_state[i] = INERTIAL;
		}
	}
}


void move_tor(torpedo_t *torpedo, ship_t *target){
	int i;
	if(torpedo->stop)
		return;
	for (i = 0; i < 4; i++){
		int disx = target->x - torpedo->x[i];
		disx = disx<0? (-disx):(disx);
		int disy = target->y - torpedo->y[i];
		disy = disy<0? (-disy):(disy);
		int dis = (int)((disx*disx) + (disy*disy));
		if(torpedo->attack_state[i] == TRACING){
//			torpedo->vx[i] = disx;
//			torpedo->vy[i] = disy;
			torpedo->x[i] += torpedo->vx[i];
			torpedo->y[i] += torpedo->vy[i];
		}
		else if(torpedo->attack_state[i] == INERTIAL){
			torpedo->x[i] += torpedo->vx[i];
			torpedo->y[i] += torpedo->vy[i];
		}
	}
}

void ifstop_tor(torpedo_t *torpedo){
	if(torpedo->stop)
		return;
	if((torpedo->attack_state[0] == HIT || torpedo->attack_state[0] == DESTROY) &&
	   (torpedo->attack_state[1] == HIT || torpedo->attack_state[1] == DESTROY) &&
	   (torpedo->attack_state[2] == HIT || torpedo->attack_state[2] == DESTROY) &&
	   (torpedo->attack_state[3] == HIT || torpedo->attack_state[3] == DESTROY)){
		torpedo->stop = 1;
		for(int i = 0; i < 4; i++){
			torpedo->attack_state[i] = 0;
			torpedo->vx[i] = 0;
			torpedo->vy[i] = 0;
			torpedo->x[i] = 0;
			torpedo->y[i] = 0;
		}
	}
}

void init_tor(torpedo_t *torpedo, int target){
	for(int i = 0; i < 4; i++){
		torpedo->attack_state[i] = 0;
		torpedo->vx[i] = 0;
		torpedo->vy[i] = 0;
		torpedo->x[i] = 0;
		torpedo->y[i] = 0;
	}
	torpedo->stop = 1;
	torpedo->target = target;
}

void update_tor(torpedo_t *torpedo1,torpedo_t *torpedo2, ship_t *ship1, ship_t *ship2){
	move_tor(torpedo1, ship2);
	move_tor(torpedo2, ship1);
	upstate_tor(torpedo1, ship1, ship2);
	upstate_tor(torpedo2, ship1, ship2);
	ifstop_tor(torpedo1);
	ifstop_tor(torpedo2);

}

void press_z(ship_t *target){
	target->HP -= 4;

}

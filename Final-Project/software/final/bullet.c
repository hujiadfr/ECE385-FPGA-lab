/*
 * bullet.c
 *
 *  Created on: 2022Äê1ÔÂ2ÈÕ
 *      Author: jiaru
 */
#include "bullet.h"
#include "ship_logic.h"
void generate_bullet(ship_t *ship, int target, bullet_t *bullet){
	if (!bullet->stop)
		return;
	bullet->target = target;
	int i = 0;
	if(target == 1)
		for (i = 0; i < 10; i++){
			bullet->x[i] = ship->x;
			bullet->y[i] = ship->y;
			bullet->vx[i] = 10;
			bullet->vy[i] = -5 + i;
			bullet->stop = 0;
		}
	else
		for (i = 0; i < 10; i++){
			bullet->x[i] = ship->x;
			bullet->y[i] = ship->y;
			bullet->vx[i] = -10;
			bullet->vy[i] = -5 + i;
			bullet->stop = 0;
		}

}

void update_bullet(bullet_t *bullet1, bullet_t *bullet2, ship_t *ship1, ship_t *ship2){
	int i;
	if (!bullet1->stop){
		for(i = 0; i < 10; i++)
		{
			bullet1->x[i] += bullet1->vx[i];
			bullet1->y[i] += bullet1->vy[i];
			if(bullet1->x[i] >= RIGHT_MOST || bullet1->x[i] <= LEFT_MOST){
				bullet1->x[i] = 1000;
				bullet1->y[i] = 1000;
				bullet1->vx[i] = 0;
				bullet1->vy[i] = 0;
			}
			if(bullet1->y[i] <= UP_MOST || bullet1->y[i] >= DOWN_MOST){
				bullet1->x[i] = 1000;
				bullet1->y[i] = 1000;
				bullet1->vx[i] = 0;
				bullet1->vy[i] = 0;
			}
			if(detect(ship2, bullet1->x[i], bullet1->y[i], 6)){
				if (ship1->choose_ship == 0)
					ship2->HP -= 3;
				else
					ship2-> HP -= 1;
				bullet1->x[i] = 1000;
				bullet1->y[i] = 1000;
				bullet1->vx[i] = 0;
				bullet1->vy[i] = 0;
			}
		}

	}
	if(bullet1->vx[0] == 0 && bullet1->vx[1] == 0
	&& bullet1->vx[2] == 0 && bullet1->vx[3]== 0 &&
	bullet1->vx[4] == 0 && bullet1->vx[5] == 0
	&& bullet1->vx[6] == 0 && bullet1->vx[7]== 0 &&
		bullet1->vx[8] == 0 && bullet1->vx[9]== 0 ){
		bullet1->stop = 1;
	}
	if (!bullet2->stop){
		for(i = 0; i < 10; i++){
			bullet2->x[i] += bullet2->vx[i];
			bullet2->y[i] += bullet2->vy[i];
			if(bullet2->x[i] >= RIGHT_MOST || bullet2->x[i] <= LEFT_MOST){
				bullet2->x[i] = 1000;
				bullet2->y[i] = 1000;
				bullet2->vx[i] = 0;
				bullet2->vy[i] = 0;
			}
			if(bullet2->y[i] <= UP_MOST || bullet2->y[i] >= DOWN_MOST){
				bullet2->x[i] = 1000;
				bullet2->y[i] = 1000;
				bullet2->vx[i] = 0;
				bullet2->vy[i] = 0;
			}
			if(detect(ship1, bullet2->x[i], bullet2->y[i], 6)){
				if (ship2->choose_ship == 0)
					ship1->HP -= 3;
				else
					ship1->HP -= 1;
				bullet2->x[i] = 1000;
				bullet2->y[i] = 1000;
				bullet2->vx[i] = 0;
				bullet2->vy[i] = 0;
			}
		}
	}
	if(bullet2->vx[0] == 0 && bullet2->vx[1] == 0
				&& bullet2->vx[2] == 0 && bullet2->vx[3]== 0 &&
				bullet2->vx[4] == 0 && bullet2->vx[5] == 0
				&& bullet2->vx[6] == 0 && bullet2->vx[7]== 0 &&
				 bullet2->vx[8] == 0 && bullet2->vx[9]== 0 ){
		bullet2->stop = 1;
	}
}

void init_bullet(bullet_t *bullet1, bullet_t *bullet2){
	int i;
	bullet1->stop = 1;
	bullet2->stop = 1;
	for (i = 0; i < 10; i++)
	{
		bullet1->x[i] = 1000;
		bullet1->y[i] = 1000;
		bullet2->x[i] = 1000;
		bullet2->y[i] = 1000;
		bullet1->vx[i] = 0;
		bullet2->vx[i] = 0;
		bullet1->vy[i] = 0;
		bullet2->vy[i] = 0;
		bullet1->target = 1;
		bullet2->target =0;
	}
}



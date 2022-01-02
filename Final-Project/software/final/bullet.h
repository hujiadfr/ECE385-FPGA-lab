#ifndef _BULLET_H
#define _BULLET_H_
#include "ship_logic.h"
typedef struct bullet_t{
	int stop;
    int x[10],y[10];                // position
    int vx[10],vy[10];              // velocity
    int target;
}bullet_t;
void generate_bullet(ship_t * ship, int target, bullet_t *bullet);
void update_bullet(bullet_t *bullet1, bullet_t *bullet2, ship_t *ship1, ship_t *ship2);
void init_bullet(bullet_t *bullet1, bullet_t *bullet2);
#endif

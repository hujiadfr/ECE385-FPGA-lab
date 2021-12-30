#ifndef TORPEDO_H_
#define TORPEDO_H_
#include "ship_logic.h"

typedef struct torpedo_t{
    int x[4],y[4];                // position
    int vx[4],vy[4];              // velocity
    int attack_state[4];
    int stop;
    int target;
}torpedo_t;

enum attack_state
{
	TRACING = 0,
	HIT,
	INERTIAL, //×·×ÙÊ§°Ü£¬¹ßÐÔµ¼º½×´Ì¬
	DESTROY,
}attack_state;

enum target
{
	SHIP1 = 0,
	SHIP2,
}target;

void press_j(ship_t *ship,torpedo_t *torpedo, int target);
void upstate_tor(torpedo_t *torpedo, ship_t *ship1, ship_t *ship2);
void move_tor(torpedo_t *torpedo, ship_t *target);
void ifstop_tor(torpedo_t *torpedo);
void init_tor(torpedo_t *torpedo, int target);
void update_tor(torpedo_t *torpedo1,torpedo_t *torpedo2, ship_t *ship1, ship_t *ship2);
#endif

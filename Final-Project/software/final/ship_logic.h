#ifndef SHIP_LOGIC_H_
#define SHIP_LOGIC_H_

#define TRUE 1
#define FALSE 0

//---------------------
#define UP_MOST 40
#define LEFT_MOST 33
#define RIGHT_MOST 607
#define DOWN_MOST 400
#define INIT_X 50
#define INIT_Y 240
#define INIT_X2 300
#define INIT_Y2 240
#define VY_MOST 3
#define VX_MOST 4
#define STATE_COUNT_MAX 1
#define EXCALIBUR_COUNT_MAX 1
#define RIGHT 0
#define LEFT 1
#define ATTACK_RANGEX 65
#define ATTACK_RANGEY 20
#define EXCALIBUR_WIDTH 182
#define EXCALIBUR_LENGTH 400
#define EXCALIBUR_X_BIAS -70
#define EXCALIBUR_Y_BIAS -15
#define WALK_FRAME 6
#define ATK_FRAME  4
#define EXCALIBUR_FRAME 4
#define POSE_FRAME  2
typedef struct ship_t{
	int exist;
    int x,y;                // position
    int vx,vy;              // velocity
    int HP;
    int ATK;                // 
    // 改成 MoveDirection
    int FaceDirection; 		// -1 for left and 1 for right
    int state;
    int state_count; 		// frame count for each state
    // 改成其他武器
    int Excalibur_state;	// excalibur animation state
    int Excalibur_count;	// frame clock for excalibur
    int Excalibur_remain;	// the remaining skill times
    // 改成isFiring
    int IsFighting;
    // 改成getHit
    int injuring;		// just be attacked
    int Excalibur_damage;
}ship_t;

enum SHIP1_state
{
    STOP = 0,
    GET_HITTED,
    FIRING,
    WALK_LEFT1, 
    // WALK_LEFT2, 
    // WALK_LEFT3, 
    // WALK_LEFT4, 
    // WALK_LEFT5, 
    // WALK_LEFT6,
    WALK_RIGHT1, 
    // WALK_RIGHT2, 
    // WALK_RIGHT3, 
    // WALK_RIGHT4, 
    // WALK_RIGHT5, 
    // WALK_RIGHT6,    
    ATTACK_LEFT1, 
    // ATTACK_LEFT2, 
    // ATTACK_LEFT3, 
    // ATTACK_LEFT4,
    EXCALIBUR_LEFT1, 
    EXCALIBUR_LEFT2, 
    EXCALIBUR_LEFT3, 
    EXCALIBUR_LEFT4,
    // POSE_LEFT1, 
    // POSE_LEFT2,
    ATTACK_RIGHT1, 
    // ATTACK_RIGHT2, 
    // ATTACK_RIGHT3, 
    // ATTACK_RIGHT4,
    EXCALIBUR_RIGHT1, 
    EXCALIBUR_RIGHT2, 
    EXCALIBUR_RIGHT3, 
    EXCALIBUR_RIGHT4,
    // POSE_RIGHT1, 
    // POSE_RIGHT2
} ship_state;

enum Excalibur_state
{
    EXCALIBUR1 = 0, 
    EXCALIBUR2, 
    EXCALIBUR3, 
    EXCALIBUR4, 
    EXCALIBUR5, 
    EXCALIBUR6, 
    EXCALIBUR7, 
    EXCALIBUR8,
    EXCALIBURNULL
}Excalibur_state;

void press_w(ship_t *saber);
void press_s(ship_t *saber);
void press_a(ship_t *saber);
void press_d(ship_t *saber);
void press_j(ship_t *saber);
// void press_k(saber_t *saber);
// void press_l(saber_t *saber);
void ship_init(ship_t *ship, ship_t *ship2);
void update(ship_t *ship, ship_t *ship2);
void stop(ship_t *saber);
void update_helper(ship_t*saber, int state_start, int state_end);
#endif /* SABER_LOGIC_H_ */

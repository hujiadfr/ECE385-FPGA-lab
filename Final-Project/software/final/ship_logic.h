#ifndef SHIP_LOGIC_H_
#define SHIP_LOGIC_H_

#define TRUE 1
#define FALSE 0

//---------------------
#define UP_MOST 40
#define LEFT_MOST 33
#define RIGHT_MOST 607
#define DOWN_MOST 450
#define INIT_X 50
#define INIT_Y 240
#define INIT_X2 557
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
#define SHIP_KIND_MAX 2

typedef struct ship_t{
	int exist;
    int x,y;                // position
    int vx,vy;              // velocity
    int HP;
    int ATK;                // 
    // 閺�瑙勫灇 MoveDirection
    int FaceDirection; 		// -1 for left and 1 for right
    int state;
    int state_count; 		// frame count for each state
    // 閺�瑙勫灇閸忔湹绮锕�娅�
    int Excalibur_state;	// excalibur animation state
    int Excalibur_count;	// frame clock for excalibur
    int Excalibur_remain;	// the remaining skill times
    // 閺�瑙勫灇isFiring
    int IsFighting;
    // 閺�瑙勫灇getHit
    int injuring;		// just be attacked
    int Excalibur_damage;

    int choose_ship;
    int ship_choose_ready;
}ship_t;

enum SHIP1_state
{
    STOP = 0,
    GET_HITTED, // 1
    WALK_LEFT1, // 2
    WALK_RIGHT1, //3
    ATTACK,     // 4
    DEAD        // 5
} ship_state;

void press_w(ship_t *saber);
void press_s(ship_t *saber);
void press_a(ship_t *saber);
void press_d(ship_t *saber);

// void press_k(saber_t *saber);
// void press_l(saber_t *saber);
void ship_init(ship_t *ship, ship_t *ship2);
void update(ship_t *ship, ship_t *ship2);
void stop(ship_t *saber);
void update_helper(ship_t*saber, int state_start, int state_end);

int detect(ship_t *ship, int x, int y, int dis);
void detect_ship_attack(ship_t *ship1, ship_t *ship2);
#endif /* SABER_LOGIC_H_ */

#ifndef PingPong_Constants_h
#define PingPong_Constants_h

extern int const kBallSize;
extern float const kBallSpeed;
extern int const kPaddleHeight;
extern int const kPaddleWidth;
extern float const kPaddleSpeed;

typedef enum {
    directionNE = 0, // Up-Right
    directionSE = 1, // Down-Right
    directionSW = 2, // Down-Left
    directionNW = 3, // Up-Left
    directionDefault = directionSE
} Direction;


#endif

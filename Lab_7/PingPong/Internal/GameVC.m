#import "GameVC.h"
#import "Ball.h"
#import "Paddle.h"
#import "Constants.h"


@interface GameVC ()

@property (nonatomic) IBOutlet Paddle *topPaddle;
@property (nonatomic) IBOutlet Paddle *bottomPaddle;
@property (nonatomic) IBOutlet Ball *ball;
@property (nonatomic) CGRect mainFrame;
@property (nonatomic) BOOL pause;

@end

@implementation GameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainFrame = [[UIScreen mainScreen] applicationFrame];
    
    self.topPaddle = [[Paddle alloc]
                      initWithPosition:(CGPoint){self.mainFrame.size.width / 2,
                      self.mainFrame.origin.y + kPaddleHeight}
                      andColor:[UIColor blueColor]];
    [self.view addSubview:self.topPaddle];
    
    self.bottomPaddle = [[Paddle alloc]
                      initWithPosition:(CGPoint){self.mainFrame.size.width / 2,
                          self.mainFrame.size.height - kPaddleHeight}
                      andColor:[UIColor greenColor]];
    [self.view addSubview:self.bottomPaddle];
    
    self.ball = [[Ball alloc]
                      initWithPosition:(CGPoint){self.mainFrame.size.width / 2,
                                                 self.mainFrame.size.height / 2 }
                      andColor:[UIColor redColor]];
    [self.view addSubview:self.ball];
    
    self.pause = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainViewTapped:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)mainViewTapped:(UITapGestureRecognizer *)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self startGameProcess];
    });
}

- (void)startGameProcess
{
    self.pause = !self.pause;
    while (YES && !self.pause) {
        [self moveBall];
        if (self.ball.direction == directionNE || self.ball.direction == directionNW) {
            [self moveTopPaddle];
        }
        else if (self.ball.direction == directionSE || self.ball.direction == directionSW) {
            [self moveBottomPaddle];
        }
    }
}

- (void)moveBall
{
    CGPoint ballPosition = self.ball.position;
    switch (self.ball.direction) {
        case directionSE: {
            ballPosition.y = ballPosition.y + self.ball.speed;
            ballPosition.x = ballPosition.x + self.ball.speed;
            // collision with bottom paddle
            if (CGRectIntersectsRect(self.ball.frame, self.bottomPaddle.frame)) {
                self.ball.direction = directionNE;
            }
            // collision with right board
            else if (ballPosition.x + self.ball.frame.size.width >= self.mainFrame.size.width) {
                self.ball.direction = directionSW;
            }
            // collision with bottom board
            else if (ballPosition.y + self.ball.frame.size.height >= self.mainFrame.size.height) {
                [self gameOver];
            }
            break;
        }
        case directionSW: {
            ballPosition.y = ballPosition.y + self.ball.speed;
            ballPosition.x = ballPosition.x - self.ball.speed;
            // collision with bottom board
            if (CGRectIntersectsRect(self.ball.frame, self.bottomPaddle.frame)) {
                self.ball.direction = directionNW;
            }
            // collision with left board
            else if (ballPosition.x <= 0) {
                self.ball.direction = directionSE;
            }
            else if (ballPosition.y + self.ball.frame.size.height >= self.mainFrame.size.height) {
                [self gameOver];
            }
            break;
        }
        case directionNE: { // top right
            ballPosition.y = ballPosition.y - self.ball.speed;
            ballPosition.x = ballPosition.x + self.ball.speed;
            // collision with top board
            if (CGRectIntersectsRect(self.ball.frame, self.topPaddle.frame)) {
                self.ball.direction = directionSE;
            }
            // collision with right board
            else if (ballPosition.x + self.ball.frame.size.width >= self.mainFrame.size.width) {
                self.ball.direction = directionNW;
            }
            else if (ballPosition.y - self.ball.frame.size.height <= 0) {
                [self gameOver];
            }
            break;
        }
        case directionNW: { // top left
            ballPosition.y = ballPosition.y - self.ball.speed;
            ballPosition.x = ballPosition.x - self.ball.speed;
            // collision with top board
            if (CGRectIntersectsRect(self.ball.frame, self.topPaddle.frame)) {
                self.ball.direction = directionSW;
            }
            // collision with left board
            else if (ballPosition.x <= 0) {
                self.ball.direction = directionNE;
            }
            else if (ballPosition.y - self.ball.frame.size.height <= 0) {
                [self gameOver];            }
            break;
        }
    }
    if (!self.pause){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ball.position = ballPosition;
        });
    }
}


- (void)moveTopPaddle
{
    int xBallPosition = self.ball.position.x;
    int xPaddlePosition = self.topPaddle.position.x;
    CGPoint paddlePosition = self.topPaddle.position;
    
    if (xPaddlePosition < xBallPosition &&
        xPaddlePosition + self.topPaddle.frame.size.width / 2 < self.mainFrame.size.width) {
        paddlePosition.x = self.topPaddle.position.x + self.topPaddle.speed;
    }
    else if (xPaddlePosition + self.topPaddle.frame.size.width / 2 > xBallPosition &&
             xPaddlePosition - self.topPaddle.frame.size.width / 2  > 0) {
        paddlePosition.x = self.topPaddle.position.x - self.topPaddle.speed;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.topPaddle.position = paddlePosition;
    });
}

- (void)moveBottomPaddle
{
    int xBallPosition = self.ball.position.x;
    int xPaddlePosition = self.bottomPaddle.position.x;
    CGPoint paddlePosition = self.bottomPaddle.position;
    
    if (xPaddlePosition < xBallPosition &&
        xPaddlePosition + self.bottomPaddle.frame.size.width / 2  < self.mainFrame.size.width) {
        paddlePosition.x = self.bottomPaddle.position.x + self.bottomPaddle.speed;
    }
    else if (xPaddlePosition + self.bottomPaddle.frame.size.width / 2 > xBallPosition &&
             xPaddlePosition - self.bottomPaddle.frame.size.width / 2 > 0) {
        paddlePosition.x = self.bottomPaddle.position.x - self.bottomPaddle.speed;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bottomPaddle.position = paddlePosition;
    });
}

- (void)gameOver
{
    self.pause = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.ball.position = CGPointMake(self.mainFrame.size.width / 2, self.mainFrame.size.height / 2);
    });
}


@end

#import "Ball.h"
#import "Constants.h"

@implementation Ball

- (instancetype)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        _speed = kBallSpeed;
        _direction = directionDefault;
        self.frame = CGRectMake(position.x, position.y, kBallSize, kBallSize);
        [self setPosition:position];
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = YES;
    }
    return self;
}

- (instancetype)initWithPosition:(CGPoint)position andColor:(UIColor *)color
{
    self = [self initWithPosition:position];
    if (self) {
        self.backgroundColor = color;
    }
    return self;
}

- (void)setPosition:(CGPoint)position
{
    _position = position;
    self.center = position;
}

@end

#import "Ball.h"
#import "Constants.h"

@implementation Ball

- (instancetype)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        _speed = kBallSpeed;
        _direction = directionDefault;
        self.position = position;
        self.backgroundColor = [UIColor redColor];
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
    CGRect pos = CGRectMake(position.x, position.y, kBallSize, kBallSize);
    self.frame = pos;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.layer.cornerRadius = self.frame.size.width/2;
    self.clipsToBounds = YES;
}

@end

#import "Paddle.h"
#import "Constants.h"

@implementation Paddle

- (instancetype)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        _speed = kPaddleSpeed;
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
    CGRect pos = CGRectMake(position.x, position.y, kPaddleWidth, kPaddleHeight);
    self.frame = pos;
}


@end

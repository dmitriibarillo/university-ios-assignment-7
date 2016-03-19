#import <UIKit/UIKit.h>

@interface Paddle : UIView

@property (nonatomic, readwrite) CGPoint position;
@property (nonatomic, readwrite) float speed;

- (instancetype)initWithPosition:(CGPoint)position;

- (instancetype)initWithPosition:(CGPoint)position andColor:(UIColor *)color;

@end

#import <UIKit/UIKit.h>

@interface Ball : UIView

@property (nonatomic, readwrite) CGPoint position;
@property (nonatomic, readwrite) float speed;
@property (nonatomic, readwrite) int direction;

- (instancetype)initWithPosition:(CGPoint)position;

- (instancetype)initWithPosition:(CGPoint)position andColor:(UIColor *)color;


@end


#import <Foundation/Foundation.h>

@interface PadovanNumber : NSObject

@property (nonatomic, readonly) unsigned long long value;
@property (nonatomic, readonly) int step;

- (void)nextValue;

@end

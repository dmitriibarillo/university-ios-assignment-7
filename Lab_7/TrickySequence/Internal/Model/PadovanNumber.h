#import <Foundation/Foundation.h>

@interface PadovanNumber : NSObject

@property (atomic, readonly) SInt32 value;
@property (atomic, readonly) int step;
@property (nonatomic, readonly) NSLock *lock;

/**
 * Generates the next element of sequence of padovan numbers.
 * Additional information about padovan numbers you can find on https://oeis.org/A000931
 */
- (void)nextValue;

@end

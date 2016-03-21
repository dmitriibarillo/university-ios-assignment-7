#import "PadovanNumber.h"

@interface PadovanNumber ()

@property (atomic, readwrite) SInt32 value;
@property (atomic, readwrite) int step;

@end

@implementation PadovanNumber

- (SInt32)performStep:(int)step
{
    if (step == 0) {
        return 1;
    }
    else if (step <= 2) {
        return 0;
    }
    else {
        SInt32 number1 = [self performStep:(step - 2)];
        SInt32 number2 = [self performStep:(step - 3)];
        
        return number1 + number2;
    }
}

- (void)nextValue
{
    self.value = [self performStep:self.step++];
}

@end

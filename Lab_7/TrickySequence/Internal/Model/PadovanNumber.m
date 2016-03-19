#import "PadovanNumber.h"

@interface PadovanNumber ()

@property (atomic, readwrite) unsigned long long value;
@property (atomic, readwrite) int step;

@end

@implementation PadovanNumber

- (unsigned long long)performStep:(int)step
{
    if (step == 0) {
        return 1;
    }
    else if (step <= 2) {
        return 0;
    }
    else {
        unsigned long long number1 = [self performStep:(step - 2)];
        unsigned long long number2 = [self performStep:(step - 3)];
        
        return number1 + number2;
    }
}

- (void)nextValue
{
    self.value = [self performStep:self.step++];
}

@end

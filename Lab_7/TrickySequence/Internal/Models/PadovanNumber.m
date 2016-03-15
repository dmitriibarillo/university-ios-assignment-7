#import "PadovanNumber.h"

@interface PadovanNumber ()

@property (nonatomic, readwrite) unsigned long long value;
@property (nonatomic, readwrite) int step;

@end

@implementation PadovanNumber

- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = 0;
        _step = 0;
    }
    
    return self;
}

- (unsigned long long)step:(int)step
{
    if (step == 0) {
        return 1;
    }
    else if (step <= 2) {
        return 0;
    }
    else {
        unsigned long long number1 = [self step:(step - 2)];
        unsigned long long number2 = [self step:(step - 3)];
        
        return number1 + number2;
    }
}

- (void)nextValue
{
    self.value = [self step:self.step++];
}

@end

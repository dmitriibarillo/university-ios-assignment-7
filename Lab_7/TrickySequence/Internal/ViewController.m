#import "ViewController.h"
#import "PadovanNumber.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *numberLabel;
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) PadovanNumber *number;
@property (nonatomic) BOOL pause;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pause = YES;
    self.number = [[PadovanNumber alloc] init];

    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                selector:@selector(updateNumberLabel)];
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (IBAction)buttonTaped
{
    self.pause = !self.pause;
    self.displayLink.paused = self.pause;
    [self.button setTitle:@"Stop" forState:UIControlStateNormal];
    
    if (!self.pause) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self runCalculating];
        });
    }
}

- (void)runCalculating
{
    while (YES && !self.pause) {
        [self.number nextValue];
    }
    [self didFinishCalculation];
}

- (void)didFinishCalculation
{
    [self.button setEnabled:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.button setTitle:@"Start" forState:UIControlStateNormal];
        [self.button setEnabled:YES];
    });
}

- (void)updateNumberLabel
{
    @synchronized (self ) {
        self.numberLabel.text = [NSString stringWithFormat:@"Step:%d number is %d",
                             self.number.step, (int)self.number.value];
    }
}

@end

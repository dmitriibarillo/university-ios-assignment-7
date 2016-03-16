#import "ViewController.h"
#import "PadovanNumber.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) PadovanNumber *number;
@property (nonatomic, readwrite) BOOL pause;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pause = NO;
    self.number = [[PadovanNumber alloc] init];

    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self
                                                selector:@selector(updateNumberLabel)];
    
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (IBAction)buttonTaped:(id)sender
{
    self.pause = !self.pause;
    [self chageButtonText];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self runCalculating];
    });
}

- (void)chageButtonText
{
    if (self.pause) {
        [self.button setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else {
        [self.button setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)runCalculating
{
    while (YES && self.pause) {
        [self.number nextValue];
    }
}

- (void)updateNumberLabel
{
    self.numberLabel.text = [NSString stringWithFormat:@"Step:%d number is %llu",
                             self.number.step, self.number.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

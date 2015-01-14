#import "ViewController.h"
#import "SampleClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  int value = OrgJ2objcSampleSharedSampleClass_incrementWithInt_(2);
  NSLog(@"%d", value);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

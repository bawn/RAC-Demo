//
//  TestViewController.m
//  RACWeatherExample
//
//  Created by beik on 6/27/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "TestViewController.h"
#import <ReactiveCocoa.h>
static NSInteger numberLimit = 5;

@interface TestViewController ()<UITextFieldDelegate, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *timeButton;


@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __block NSInteger number = numberLimit;
    self.timeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    @weakify(self);
    RACSignal *timeSignal = [[[[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] take:numberLimit] startWith:@(1)] map:^id(NSDate *date) {
        NSLog(@"%@", date);
        @strongify(self);
        if (number == 0) {
            [self.timeButton setTitle:@"重新发送" forState:UIControlStateNormal];
            return @YES;
        }
        else{
            
            self.timeButton.titleLabel.text = [NSString stringWithFormat:@"%d", number--];
            return @NO;
        }
    }] takeUntil:self.rac_willDeallocSignal];
    
    self.timeButton.rac_command = [[RACCommand alloc]initWithEnabled:timeSignal signalBlock:^RACSignal *(id input) {
        number = numberLimit;
        return timeSignal;
    }];
    [self.timeButton setTitle:[@(numberLimit) stringValue] forState:UIControlStateNormal];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

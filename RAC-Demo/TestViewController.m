//
//  TestViewController.m
//  RACWeatherExample
//
//  Created by beik on 6/27/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "TestViewController.h"
#import <ReactiveCocoa.h>

static NSInteger numberLimit1 = 5;

static NSInteger numberLimit2 = 5;

@interface TestViewController ()

@property (nonatomic, strong) IBOutlet UIButton *timeButton1;
@property (nonatomic, strong) IBOutlet UIButton *timeButton2;

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
    
    // 立即开启倒计时
    
    __block NSInteger number1 = numberLimit1;
    self.timeButton1.titleLabel.textAlignment = NSTextAlignmentCenter;

    @weakify(self);
    RACSignal *timeSignal1 = [[[[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] take:numberLimit1] startWith:@(1)] map:^id(NSDate *date) {
        NSLog(@"%@", date);
        @strongify(self);
        if (number1 == 0) {
            [self.timeButton1 setTitle:@"重新发送" forState:UIControlStateNormal];
            return @YES;
        }
        else{
            
//            self.timeButton1.titleLabel.text = [NSString stringWithFormat:@"%d", number1--];
#warning modify button title
            [self.timeButton1 setTitle:[NSString stringWithFormat:@"%ld", (long)number1--] forState:UIControlStateDisabled];
            return @NO;
        }
    }] takeUntil:self.rac_willDeallocSignal];
    
    self.timeButton1.rac_command = [[RACCommand alloc]initWithEnabled:timeSignal1 signalBlock:^RACSignal *(id input) {
        number1 = numberLimit1;
        return timeSignal1;
    }];
    [self.timeButton1 setTitle:[@(numberLimit1) stringValue] forState:UIControlStateNormal];
    

    
    
    // 点击开始倒计时
    self.timeButton2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.timeButton2 setTitle:@"点击发送" forState:UIControlStateNormal];
    __block NSInteger number2 = numberLimit2;
    
    RACSignal *timeSignal2 = [[[[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] take:numberLimit2] startWith:@(1)] doNext:^(NSDate *date) {
        @strongify(self);
        NSLog(@"%@", date);
        if (number2 == 0) {
           [self.timeButton2 setTitle:@"重新发送" forState:UIControlStateNormal];
            self.timeButton2.enabled = YES;
        }
        else{
#warning modify button title
//            self.timeButton2.titleLabel.text = [NSString stringWithFormat:@"%d", number2--];
            [self.timeButton2 setTitle:[NSString stringWithFormat:@"%ld", (long)number2--] forState:UIControlStateDisabled];
            self.timeButton2.enabled = NO;// 倒计时期间不可点击
        }
    }]takeUntil:self.rac_willDeallocSignal];

    self.timeButton2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        number2 = numberLimit2;
        return timeSignal2;
    }];

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

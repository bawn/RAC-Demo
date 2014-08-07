//
//  DelegateViewController.m
//  RAC-Demo
//
//  Created by beik on 7/21/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "RACDelegateViewController.h"

@interface RACDelegateViewController ()
@property (nonatomic, strong) IBOutlet UIButton *button;


@end

@implementation RACDelegateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.delegateSignal = [self rac_signalForSelector:@selector(dismiss:)];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (IBAction)dismiss:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
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

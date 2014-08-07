//
//  TextViewViewController.m
//  RAC-Demo
//
//  Created by beik on 7/3/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "RACTextViewController.h"
#import <ReactiveCocoa/RACChannel.h>

static NSInteger EnityDescriptionMaxLength = 50;

@interface RACTextViewController ()

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *numberButton;

@end

@implementation RACTextViewController

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
    [self.textView becomeFirstResponder];
    RACChannelTerminal *characterRemainingTerminal = RACChannelTo(_numberButton, title);
    
    [[self.textView.rac_textSignal map:^id(NSString *text) {
        return [@(EnityDescriptionMaxLength - (NSInteger)text.length) stringValue];
    }] subscribe:characterRemainingTerminal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

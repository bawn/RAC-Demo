//
//  TableViewController.m
//  RACWeatherExample
//
//  Created by beik on 6/26/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "TableViewController.h"
#import "RACDelegateViewController.h"

@interface TableViewController ()


@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        RACDelegateViewController *delegateVC = (RACDelegateViewController *)nav.topViewController;
        [delegateVC.delegateSignal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
    }
}


@end

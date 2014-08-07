//
//  DelegateViewController.h
//  RAC-Demo
//
//  Created by beik on 7/21/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RACDelegateViewController : UIViewController

@property (nonatomic, strong) RACSignal *delegateSignal;

@end

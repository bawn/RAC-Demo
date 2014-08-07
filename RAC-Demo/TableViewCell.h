//
//  TableViewCell.h
//  RAC-Demo
//
//  Created by beik on 8/7/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RACSignal.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *detailLabel;

- (void)configureCellWithSignal:(RACSignal *)signal;

@end

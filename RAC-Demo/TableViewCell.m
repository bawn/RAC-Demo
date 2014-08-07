//
//  TableViewCell.m
//  RAC-Demo
//
//  Created by beik on 8/7/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "TableViewCell.h"
#import "Model.h"

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureCellWithSignal:(RACSignal *)signal{
    @weakify(self);
    [signal subscribeNext:^(Model *model) {
        @strongify(self);
        self.titleLabel.text = model.title;
        self.detailLabel.text = model.detail;
    }];
}

@end

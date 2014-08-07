//
//  RACTableViewController.m
//  RAC-Demo
//
//  Created by beik on 8/7/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "RACTableViewController.h"
#import "DataSourceGeneralModel.h"
#import "TableViewCell.h"
#import "Model.h"

static NSString *CelIdentifier = @"CellIdentifier";

@interface RACTableViewController ()<UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DataSourceGeneralModel *model;

@end

@implementation RACTableViewController

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
    self.model = [[DataSourceGeneralModel alloc] initWithCellIdentifier:CelIdentifier
                                                     configureCellBlock:^(TableViewCell *cell, RACSignal *signal) {
        [cell configureCellWithSignal:signal];
    }];
    
    Model *model = [[Model alloc]init];
    model.title = @"titel";
    model.detail = @"detail";
    
    
    self.model.dataSource = @[model];
    
    self.tableView.dataSource = _model;
}

- (IBAction)updateData:(id)sender{
    Model *model1 = [[Model alloc]init];
    model1.title = @"titel1";
    model1.detail = @"detail1";
    
    self.model.dataSource = @[model1];
    
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

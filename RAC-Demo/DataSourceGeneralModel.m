//
//  GeneralModel.m
//  Money
//
//  Created by beik on 7/18/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import "DataSourceGeneralModel.h"

@interface DataSourceGeneralModel ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;
@property (nonatomic, strong) RACSignal *signal;

@end

@implementation DataSourceGeneralModel

- (id)initWithCellIdentifier:(NSString *)aCellIdentifier
          configureCellBlock:(CellConfigureBlock)aConfigureCellBlock{
    self = [super init];
    if (self) {
        _cellIdentifier = aCellIdentifier;
        _configureCellBlock = [aConfigureCellBlock copy];
        _signal = RACObserve(self, dataSource);
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSource[(NSUInteger) indexPath.row];
}


#pragma mark - UITableViewDataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier
                                                            forIndexPath:indexPath];
    if (self.configureCellBlock) {
        @weakify(self);
        self.configureCellBlock(cell, [self.signal map:^id(NSArray *array) {
            @strongify(self);
            return [self itemAtIndexPath:indexPath];
        }]);

    }
    return cell;
}

#pragma mark - UICollectionView Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    if (self.configureCellBlock) {
        @weakify(self);
        self.configureCellBlock(cell, [self.signal map:^id(NSArray *array) {
            @strongify(self);
            return [self itemAtIndexPath:indexPath];
        }]);
    }
    return cell;
}

@end

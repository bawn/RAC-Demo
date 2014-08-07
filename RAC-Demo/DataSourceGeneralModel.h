//
//  GeneralModel.h
//  Money
//
//  Created by beik on 7/18/14.
//  Copyright (c) 2014 beik. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CellConfigureBlock)(id cell, RACSignal *signal);

@interface DataSourceGeneralModel : NSObject<UICollectionViewDataSource, UITableViewDataSource>


@property (nonatomic, strong) NSArray *dataSource;


- (id)initWithCellIdentifier:(NSString *)aCellIdentifier
          configureCellBlock:(CellConfigureBlock)aConfigureCellBlock;


@end

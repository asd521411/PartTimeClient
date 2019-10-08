//
//  PomeloHotPositionTableViewCell.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/18.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CollectionDidSelectItemBlock)(CommonModel *common, NSInteger integer);

@interface PomeloHotPositionTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *cellArr;

@property (nonatomic, copy) CollectionDidSelectItemBlock collectionDidSelectItemBlock;

@end

NS_ASSUME_NONNULL_END

//
//  DiscoveryRankTableViewCell.h
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/2.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiscoveryRankTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *rankNum;
@property (nonatomic, strong) UIImageView *rankImgV;
@property (nonatomic, strong) CommonModel *commonModel;

@end

NS_ASSUME_NONNULL_END

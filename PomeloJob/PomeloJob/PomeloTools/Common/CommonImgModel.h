//
//  CommonImgModel.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/16.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonImgModel : NSObject

@property (nonatomic, assign) NSInteger imgid;
@property (nonatomic, copy) NSString *imgpath;
@property (nonatomic, copy) NSString *imgtype;
@property (nonatomic, copy) NSString *positionid;


@end

NS_ASSUME_NONNULL_END

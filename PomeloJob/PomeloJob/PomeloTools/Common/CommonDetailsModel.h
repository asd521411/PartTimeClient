//
//  CommonDetailsModel.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/9.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonDetailsModel : NSObject

@property (nonatomic, copy) NSString *pay;
@property (nonatomic, copy) NSString *workContent;
@property (nonatomic, copy) NSString *workTime;
@property (nonatomic, copy) NSString *workRequire;
@property (nonatomic, copy) NSString *otherWelfare;

@property (nonatomic, copy) NSArray *rowArr;

@property (nonatomic, copy) NSString *payLeft;
@property (nonatomic, copy) NSString *workContentLeft;
@property (nonatomic, copy) NSString *workTimeLeft;
@property (nonatomic, copy) NSString *workRequireLeft;
@property (nonatomic, copy) NSString *otherWelfareLeft;

//

@property (nonatomic, copy) NSString *positioninfo;



@end

NS_ASSUME_NONNULL_END

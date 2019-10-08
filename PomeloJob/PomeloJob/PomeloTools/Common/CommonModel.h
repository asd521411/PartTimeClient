//
//  CommonModel.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/4.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonModel : NSObject

@property (nonatomic, copy) NSString *tagImgVStr;

@property (nonatomic, copy) NSString *position;


//h职位标题
@property (nonatomic, copy) NSString *positionname;

//职位描述
@property (nonatomic, copy) NSString *positioninfo;

//工作地点
@property (nonatomic, copy) NSString *positionworkaddressinfo;
@property (nonatomic, copy) NSString *positionworkaddressname;
@property (nonatomic, copy) NSString *positiontypeimg;
@property (nonatomic, copy) NSString *positionicon;
@property (nonatomic, copy) NSString *cardinfos;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *positionCreatetime;
@property (nonatomic, copy) NSString *positionStatus;
@property (nonatomic, copy) NSString *positioncardinfo;
@property (nonatomic, copy) NSString *positioncompang;
@property (nonatomic, copy) NSString *positionid;
@property (nonatomic, copy) NSString *positionpaytypeid;
//结算方式
@property (nonatomic, copy) NSString *positionpaytypename;
//要求男女
@property (nonatomic, copy) NSString *positionsexreq;
@property (nonatomic, copy) NSString *positiontelnum;
@property (nonatomic, copy) NSString *positionteltype;
@property (nonatomic, copy) NSString *positiontypeid;
@property (nonatomic, copy) NSString *positiontypename;
@property (nonatomic, copy) NSString *positionworkaddressid;
//工作时间
@property (nonatomic, copy) NSString *positionworktime;
//工资
@property (nonatomic, copy) NSString *positonmoney;

@property (nonatomic, copy) NSString *positontime;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy) NSArray *positionList;
@property (nonatomic, copy) NSString *companyimg;
@property (nonatomic, copy) NSString *companyScale;

@end

NS_ASSUME_NONNULL_END

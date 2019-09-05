//
//  LocationViewController.h
//  AvengerAgent
//
//  Created by 草帽~小子 on 2018/9/25.
//  Copyright © 2018年 meiliwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^currentSelectItemLevel1)(NSString *titleName1);//级别1不限
typedef void(^currentSelectItemSubway)(NSString *name, NSInteger subId, NSInteger level);//地铁
//typedef void(^currentSelectItemRetion)(RegionModel *region, RegionModel *area, RegionModel *station, NSInteger level);//区域

@interface LocationViewController : BaseViewController

//@property (nonatomic, copy) currentSelectItemLevel1 currentSelectItemLevel1;
//@property (nonatomic, copy) currentSelectItemSubway currentSelectItemSubway;
//@property (nonatomic, copy) currentSelectItemRetion currentSelectItemRetion;

@end

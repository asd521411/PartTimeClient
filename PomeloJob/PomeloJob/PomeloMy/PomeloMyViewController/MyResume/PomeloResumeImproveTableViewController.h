//
//  PomeloResumeImproveTableViewController.h
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/20.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ResumeImproveType) {
    ResumeImproveType_EducationBackground = 0,//学历
    ResumeImproveType_StatusOfJobSeeking,//求职状态
    ResumeImproveType_JobWantedStyle,//求职类型
    ResumeImproveType_Expected_Salary,//期望薪资
    //ResumeImproveType,E_
};

typedef void(^ImproveSelectonBlock)(ResumeImproveType improveType, NSString *type);

@interface PomeloResumeImproveTableViewController : UITableViewController

@property (nonatomic, assign) ResumeImproveType resumeImproveType;
@property (nonatomic, copy) ImproveSelectonBlock improveSelectonBlock;

@end

NS_ASSUME_NONNULL_END

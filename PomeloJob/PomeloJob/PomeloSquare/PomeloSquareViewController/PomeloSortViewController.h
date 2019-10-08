//
//  PomeloSortViewController.h
//  AvengerAgent
//
//  Created by 草帽~小子 on 2018/9/25.
//  Copyright © 2018年 meiliwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^currentSelectItemTitle)(NSString *title);

@interface PomeloSortViewController : UIViewController

@property (nonatomic, copy) currentSelectItemTitle currentSelectItemTitle;

@end



#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^CurrentSelectItemLevel1)(NSString *titleName1);//级别1不限
typedef void(^CurrentSelectItemLevel2)(NSString *titleName2);//地铁
//typedef void(^currentSelectItemRetion)(RegionModel *region, RegionModel *area, RegionModel *station, NSInteger level);//区域

@interface PomeloLocationViewController : BaseViewController

@property (nonatomic, copy) CurrentSelectItemLevel1 currentSelectItemLevel1;
@property (nonatomic, copy) CurrentSelectItemLevel2 currentSelectItemLevel2;


@end

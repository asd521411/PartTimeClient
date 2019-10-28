//
//  BusinessRelationViewController.m
//  PomeloJob
//
//  Created by 草帽~小子 on 2019/10/28.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "BusinessRelationViewController.h"

@interface BusinessRelationViewController ()

@property (nonatomic, strong) UIImageView *wechatImg;
@property (nonatomic, strong) UIView *showBackV;

@end

@implementation BusinessRelationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商务洽谈";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[ECUtil colorWithHexString:@"4a4a4a"],NSForegroundColorAttributeName, KFontNormalSize18,NSFontAttributeName,nil]];
    
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)setupSubViews {
    
    UIWindow *win = [[UIApplication sharedApplication] delegate].window;
    self.showBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, win.width, win.height)];
    self.showBackV.backgroundColor = [UIColor whiteColor];
    //[win addSubview:self.showBackV];
    [self.view addSubview:self.showBackV];
    
    self.wechatImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechatimg"]];
    self.wechatImg.frame = CGRectMake(0, 100, KSCREEN_WIDTH, KSCREEN_WIDTH);
    [self.showBackV addSubview:self.wechatImg];
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, self.wechatImg.bottom + 10, KSCREEN_WIDTH, 10)];
    la.text = @"长按图片保存";
    la.textColor = [ECUtil colorWithHexString:@"e5e5e5"];
    la.textAlignment = NSTextAlignmentLeft;
    [self.showBackV addSubview:la];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActon:)];
    [self.showBackV addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.showBackV addGestureRecognizer:press];
    
}
- (void)tapActon:(UIGestureRecognizer *)tap {
    self.showBackV.hidden = YES;
    [self.showBackV removeFromSuperview];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)press {

//    __block ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
//    [lib writeImageToSavedPhotosAlbum:self.wechatImg.image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//
//        NSLog(@"assetURL = %@, error = %@", assetURL, error);
//        lib = nil;
//    }];
    //UIImage *img = [UIImage imageWithCGImage:self.wechatImg.image.CGImage];
    
    if (press.state == UIGestureRecognizerStateBegan) {
        NSData *imageData = UIImageJPEGRepresentation(self.wechatImg.image, 0.1);
        UIImage *newImage = [UIImage imageWithData:imageData];
        UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [SVProgressHUD showWithStatus:@"保存成功！"];
    [SVProgressHUD dismissWithDelay:1];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

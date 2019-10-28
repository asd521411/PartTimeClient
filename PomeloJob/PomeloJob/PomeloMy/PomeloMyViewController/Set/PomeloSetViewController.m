//
//  PomeloSetViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/6.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloSetViewController.h"

#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface PomeloSetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) UILabel *cacheLab;

@end

@implementation PomeloSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIButton *exit = [UIButton buttonWithType:UIButtonTypeCustom];
    exit.backgroundColor = kColor_Main;
    exit.frame = CGRectMake(95,  self.tableView.height - [ECStyle navigationbarHeight] - [ECStyle toolbarHeight] - 100, KSCREEN_WIDTH - 95 * 2, 40);
    exit.layer.cornerRadius = 20;
    exit.layer.masksToBounds = YES;
    [self.tableView addSubview:exit];
    [exit setTitle:@"退出登录" forState:UIControlStateNormal];
    //[ECUtil gradientLayer:exit startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_light colorArr2:KColorGradient_dark location1:0 location2:0];
    [exit addTarget:self action:@selector(exitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.listArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.listArr[indexPath.section][indexPath.row][@"title"];
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = KFontNormalSize14;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            self.cacheLab.frame = CGRectMake(KSCREEN_WIDTH-125, 0, 100, cell.height);
            [cell addSubview:self.cacheLab];
        }else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [ECUtil colorWithHexString:@"f8f8f8"];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(self.listArr[indexPath.section][indexPath.row][@"vcname"]) alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row ==1) {
            [self removeCache];
            self.cacheLab.text = [self getCachesSize];
        }
    }
}

- (void)exitBtnAction:(UIButton *)send {
    [NSUserDefaultMemory defaultSetMemory:@"" unityKey:USERID];
    [NSUserDefaultMemory defaultSetMemory:@"" unityKey:USERINFO];
//    if ([[UserInfoManager shareInstance] exit]) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@[@{@"title":@"修改个人信息",
                         @"vcname":@"ChangePersonInfoViewController"},//PomeloChangeBindingPNViewController
                       //@{@"title":@"修改密码",
                       //@"vcname":@"PomeloChangePasswordViewController"}
                           ],
                     @[//@{@"title":@"通知提醒",
                       //  @"vcname":@"PomeloNotificationViewController"},
                       @{@"title":@"意见反馈",
                        @"vcname":@"PomeloCoupleBackViewController"},
                       @{@"title":@"清除缓存",
                         @"vcname":@""}],
                     @[@{@"title":@"关于我们",
                         @"vcname":@"PomeloAboutUsViewController"}]
                     ];
    }
    return _listArr;
}

- (UILabel *)cacheLab {
    if (_cacheLab == nil) {
        _cacheLab = [[UILabel alloc] init];
        _cacheLab.text = [self getCachesSize];
        _cacheLab.font = kFontNormalSize(14);
        _cacheLab.textAlignment = NSTextAlignmentRight;
    }
    return _cacheLab;
}

// 缓存大小
-(NSString *)getCachesSize{
    // 调试
#ifdef DEBUG
    
    // 如果文件夹不存在 or 不是一个文件夹, 那么就抛出一个异常
    // 抛出异常会导致程序闪退, 所以只在调试阶段抛出。发布阶段不要再抛了,--->影响用户体验
    
    BOOL isDirectory = NO;
    
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        
        NSException *exception = [NSException exceptionWithName:@"文件错误" reason:@"请检查你的文件路径!" userInfo:nil];
        
        [exception raise];
    }
    
    //发布
#else
    
#endif
    
    //1.获取“cachePath”文件夹下面的所有文件
    NSArray *subpathArray= [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSString *filePath = nil;
    long long totalSize = 0;
    
    for (NSString *subpath in subpathArray) {
        
        // 拼接每一个文件的全路径
        filePath =[cachePath stringByAppendingPathComponent:subpath];
        
        BOOL isDirectory = NO;   //是否文件夹，默认不是
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];   // 判断文件是否存在
        
        // 文件不存在,是文件夹,是隐藏文件都过滤
        if (!isExist || isDirectory || [filePath containsString:@".DS"]) continue;
        
        // attributesOfItemAtPath 只可以获得文件属性，不可以获得文件夹属性，
        //这个也就是需要遍历文件夹里面每一个文件的原因
        
        long long fileSize = [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
        
        totalSize += fileSize;
        
    }
    
    // 2.将文件夹大小转换为 M/KB/B
    NSString *totalSizeString = nil;
    
    if (totalSize > 1000 * 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fM",totalSize / 1000.0f /1000.0f];
        
    } else if (totalSize > 1000) {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0f ];
        
    } else {
        
        totalSizeString = [NSString stringWithFormat:@"%.1fB",totalSize / 1.0f];
        
    }
    
    return totalSizeString;
    
}

// 清除缓存
- (void)removeCache{
    
    // 1.拿到cachePath路径的下一级目录的子文件夹
    // contentsOfDirectoryAtPath:error:递归
    // subpathsAtPath:不递归
    
    NSArray *subpathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
    
    // 2.如果数组为空，说明没有缓存或者用户已经清理过，此时直接return
    if (subpathArray.count == 0) {
        [SVProgressHUD showWithStatus:@"缓存已清理"];
        [SVProgressHUD dismissWithDelay:0.5];
        return ;
    }

    NSError *error = nil;
    NSString *filePath = nil;
    BOOL flag = NO;
    
    NSString *size = [self getCachesSize];
    
    for (NSString *subpath in subpathArray) {
        
        filePath = [cachePath stringByAppendingPathComponent:subpath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            
            // 删除子文件夹
            BOOL isRemoveSuccessed = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            
            if (isRemoveSuccessed) { // 删除成功
                
                flag = YES;
            }
        }
        
    }
    
    if (NO == flag){
        [SVProgressHUD showWithStatus:@"缓存已清理"];
        [SVProgressHUD dismissWithDelay:0.5];
    }else{
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"为您腾出%@空间",size]];
        [SVProgressHUD dismissWithDelay:1];
    }
    return ;
    
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

//
//  MyViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/3.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UIView *centerBackView;
@property (nonatomic, strong) UIView *lowerBackView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArr;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    [self setupTableView];
    
    // Do any additional setup after loading the view.
}



- (void)setupSubViews {
    
    CGFloat backHeight = SCREENHEIGHT * 5 / 10;
    CGFloat space = 15;
    
    self.headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [ECStyle navigationbarHeight], SCREENWIDTH, backHeight)];
    self.headBackView.backgroundColor = [HWRandomColor randomColor];
    [self.view addSubview:self.headBackView];
    
    // MARK: top

    self.topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, backHeight / 2)];
    self.topBackView.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.topBackView];

    CGFloat height = 20;

    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(space, space, SCREENWIDTH / 2, height)];
    lab1.textColor = BLACKCOLOR;
    lab1.font = LARGEFont;
    lab1.text = @"18345067097";
    [self.topBackView addSubview:lab1];

    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab1.bottom + space, SCREENWIDTH * 3 / 5, height)];
    lab2.textColor = BLACKCOLOR;
    lab2.font = NORMALFont;
    lab2.text = @"暂无个性签名，添加彰显你的个性";
    [self.topBackView addSubview:lab2];

    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab2.bottom + space, SCREENWIDTH / 2, height)];
    lab3.textColor = BLACKCOLOR;
    lab3.font = NORMALFont;
    NSArray *arr1 = @[@"沟通能力强", @"效率高"];
    NSString *text1 = [arr1 componentsJoinedByString:@" "];
    lab3.text = text1;
    [self.topBackView addSubview:lab3];

    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH - space - 80, space, 80, 80)];
    headImg.backgroundColor = [HWRandomColor randomColor];
    headImg.layer.cornerRadius = 40;
    headImg.layer.masksToBounds = YES;
    [self.topBackView addSubview:headImg];
    
    // MARK: center
    
    self.centerBackView = [[UIView alloc] initWithFrame:CGRectMake(space, self.topBackView.bottom - backHeight / 4 / 3, SCREENWIDTH - space * 2, backHeight / 4)];
    self.centerBackView.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.centerBackView];
    NSArray *arr = @[@{@"img":@"",@"title":@"看过我"},
                     @{@"img":@"",@"title":@"我看过"},
                     @{@"img":@"",@"title":@"已申请"},
                     @{@"img":@"",@"title":@"待面试"},
                     @{@"img":@"",@"title":@"收藏"}];
    
    CGFloat centerSpace = 10;
    CGFloat btnWid = (SCREENWIDTH - space * 2 - centerSpace * 6) / 5;
    
    for (NSInteger i = 0; i < arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(centerSpace + (i % 5) * (btnWid + centerSpace), (self.centerBackView.height - btnWid) / 2, btnWid, btnWid);
        btn.backgroundColor = [HWRandomColor randomColor];
        btn.tag = 666 + i;
        [self.centerBackView addSubview:btn];
        [btn setTitle:arr[i][@"title"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(centerBtnACtion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // MARK: lower

    self.lowerBackView = [[UIView alloc] initWithFrame:CGRectMake(space, self.headBackView.height - backHeight / 4, SCREENWIDTH - space * 2, backHeight / 4)];
    self.lowerBackView.backgroundColor = [HWRandomColor randomColor];
    [self.headBackView addSubview:self.lowerBackView];
    
    CGFloat ligH = 10;
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(space, ligH, SCREENWIDTH / 2, height)];
    lab4.textColor = BLACKCOLOR;
    lab4.font = LARGEFont;
    lab4.text = @"我的简历";
    [self.lowerBackView addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab1.bottom, self.lowerBackView.width - 100, height)];
    lab5.textColor = BLACKCOLOR;
    lab5.font = SMALLFont;
    lab5.text = @"完善简历能提高你的录取率哦";
    [self.lowerBackView addSubview:lab5];
    
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(space, lab2.bottom, SCREENWIDTH / 5, height)];
    lab6.backgroundColor = [HWRandomColor randomColor];
    lab6.textColor = BLACKCOLOR;
    lab6.font = SMALLFont;
    lab6.text = @"去完善 >";
    lab6.layer.cornerRadius = 3;
    lab6.layer.masksToBounds = YES;
    [self.lowerBackView addSubview:lab6];
    
    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.lowerBackView.right - 60 - space - (self.lowerBackView.height - 60) / 2, (self.lowerBackView.height - 60) / 2, 60, 60)];
    imgV1.backgroundColor = [HWRandomColor randomColor];
    [self.lowerBackView addSubview:imgV1];
    
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headBackView.bottom, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [HWRandomColor randomColor];
    self.tableView.rowHeight = 60;
    self.tableView.delegate =  self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}


#pragma target action
- (void)centerBtnACtion:(UIButton *)send {
    if (send.tag == 666) {
        
    }else if (send.tag == 667) {
        
    }else if (send.tag == 668) {
        
    }else if (send.tag == 669) {
        
    }else if (send.tag == 670) {
        
    }
}

#pragma mark delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.listArr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    return cell;
}


- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@"设置", @"联系我们", @"意见反馈",@"关于我们"];
    }
    return _listArr;
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

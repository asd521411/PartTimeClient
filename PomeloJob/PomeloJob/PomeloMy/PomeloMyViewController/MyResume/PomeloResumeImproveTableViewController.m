//
//  PomeloResumeImproveTableViewController.m
//  PartTime
//
//  Created by 草帽~小子 on 2019/9/20.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PomeloResumeImproveTableViewController.h"
#import "PomeloResumeImproveTableViewCell.h"

@interface PomeloResumeImproveTableViewController ()

@property (nonatomic, strong) NSArray *educationBackgroundArr;
@property (nonatomic, strong) NSArray *statusOfJobSeekingArr;
@property (nonatomic, strong) NSArray *jobWantedStyleArr;
@property (nonatomic, strong) NSArray *expected_SalaryArr;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation PomeloResumeImproveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //[self.tableView registerClass:[PomeloResumeImproveTableViewCell class] forCellReuseIdentifier:@"PomeloResumeImproveTableViewCell"];
    
}

- (void)setupSubViews {
    switch (self.resumeImproveType) {
        case ResumeImproveType_EducationBackground:
            self.listArr = [NSMutableArray arrayWithArray:self.educationBackground];
            [self.tableView reloadData];
            break;
        case ResumeImproveType_StatusOfJobSeeking:
            self.listArr = [NSMutableArray arrayWithArray:self.statusOfJobSeeking];
            [self.tableView reloadData];
            break;
        case ResumeImproveType_JobWantedStyle:
            self.listArr = [NSMutableArray arrayWithArray:self.jobWantedStyleArr];
            [self.tableView reloadData];
            break;
        case ResumeImproveType_Expected_Salary:
            self.listArr = [NSMutableArray arrayWithArray:self.expected_SalaryArr];
            [self.tableView reloadData];
            break;
        default:
            break;
    }

}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return self.listArr.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    PomeloResumeImproveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PomeloResumeImproveTableViewCell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = self.listArr[indexPath.row];
    
    return cell;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.improveSelectonBlock) {
        self.improveSelectonBlock(self.resumeImproveType, self.listArr[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)expected_SalaryArr {
    if (!_expected_SalaryArr) {
        _expected_SalaryArr = @[@"0~3000",
                                @"3001~5000",
                                @"5001~8000",
                                @"8001~10000",
                                @"10001~13000",
                                @"13001~15000",
                                @"15000以上"];
    }
    return _expected_SalaryArr;
}

- (NSArray *)jobWantedStyleArr {
    if (!_jobWantedStyleArr) {
        _jobWantedStyleArr = @[@"长期",
                               @"短期",
                               @"周六日",
                               @"法定假日"];
    }
    return _jobWantedStyleArr;
}

- (NSArray *)statusOfJobSeeking {
    if (!_statusOfJobSeekingArr) {
        _statusOfJobSeekingArr = @[@"离职-随时到岗",
                                   @"一周内离职",
                                   @"本月内离职"];
    }
    return _statusOfJobSeekingArr;
}

- (NSArray *)educationBackground {
    if (!_educationBackgroundArr) {
        _educationBackgroundArr = @[@"空",
                                 @"初中以下",
                                 @"初中",
                                 @"中专",
                                 @"高中",
                                 @"专科",
                                 @"本科",
                                 @"研究生",
                                 @"硕士",
                                 @"博士",
                                 @"博士后",
                                 ];
    }
    return _educationBackgroundArr;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  PastTodayController.m
//  Day1UP
//
//  Created by ramborange on 16/9/28.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "PastTodayController.h"
#import "TodayOnHistoryViewCell.h"
#import "ToadyOnHistory.h"
#import "MonthDaySelectView.h"
#import "HistoryTDetailController.h"
@interface PastTodayController () <UITableViewDelegate,UITableViewDataSource>
{

}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MonthDaySelectView *mdsView;

@end

@implementation PastTodayController
-(void)dealloc {
    _tableview = nil;
    _dataArray = nil;
    
    _mdsView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"today on history";
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[TodayOnHistoryViewCell class] forCellReuseIdentifier:@"cellId"];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _mdsView = [[MonthDaySelectView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 240)];
    [self.view addSubview:_mdsView];
    __weak __typeof(self)weakself = self;
    _mdsView.dateSelectBlock = ^(NSString *retString) {
//        NSLog(@"%@",retString);
        [weakself requestDataWithDateString:retString];
    };
    [_mdsView hideSelf];
    
    
    [self requestDataWithDateString:[self getTodayDateString]];    
}

- (void)searchBtnClicked {
    [_mdsView showSelf];
}

- (NSString *)getTodayDateString {
    NSDateFormatter *forma = [[NSDateFormatter alloc] init];
    [forma setDateFormat:@"MM/dd"];
    NSDate *date = [NSDate date];
    NSString *retString = [forma stringFromDate:date];
    NSArray *strArray = [retString componentsSeparatedByString:@"/"];
    
    NSString *checkString;
    if ([strArray[0] hasPrefix:@"0"]) {
        if ([strArray[1] hasPrefix:@"0"]) {
            checkString = [NSString stringWithFormat:@"%@/%@",[strArray[0] substringFromIndex:1],[strArray[1] substringFromIndex:1]];
        }else {
            checkString = [NSString stringWithFormat:@"%@/%@",[strArray[0] substringFromIndex:1],strArray[1]];
            
        }
    }else {
        if ([strArray[1] hasPrefix:@"0"]) {
            checkString = [NSString stringWithFormat:@"%@/%@",strArray[0],[strArray[1] substringFromIndex:1]];
        }else {
            checkString = [NSString stringWithFormat:@"%@/%@",strArray[0],strArray[1]];
            
        }
    }
    return checkString;
}


- (void)requestDataWithDateString:(NSString *)date {
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[app_key2,date] forKeys:@[@"key",@"date"]];
    [request RequestDataWithMethod:@"GET" Url:events_list param:dic successed:^(NSDictionary *responseDic) {
//        NSLog(@"%@",responseDic);
        NSArray *results = responseDic[@"result"];
        if ([responseDic[@"reason"] isEqualToString:@"success"]) {
            self.dataArray = [NSMutableArray arrayWithCapacity:0];
            if (results.count) {
                for (NSDictionary *dic in results) {
                    ToadyOnHistory *th = [[ToadyOnHistory alloc] init];
                    [th setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:th];
                }
                [self.tableview reloadData];
                
            }else {
                [SVProgressHUD showInfoWithStatus:@"历史上的今天无事件"];
            }
        }else {
            [SVProgressHUD showInfoWithStatus:@"请求失败"];
        }
        
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma mark - tableview delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodayOnHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    ToadyOnHistory *th = self.dataArray[indexPath.row];
    cell.dateLabel.text = th.date;
    cell.titleLabel.text = th.title;
    [cell.img jk_setImageWithString:[th.title substringToIndex:1] color:[UIColor jk_randomColor] circular:YES fontName:@"Gillsans"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HistoryTDetailController *vc = [[HistoryTDetailController alloc] init];
    ToadyOnHistory *th = self.dataArray[indexPath.row];
    vc.eventId = th.e_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

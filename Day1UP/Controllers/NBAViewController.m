//
//  NBAViewController.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "NBAViewController.h"
#import "teamMatch.h"
#import "TR.h"
#import "WebviewController.h"
#import "TRViewCell.h"

@interface NBAViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *teammatchArray;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation NBAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"NBA News";
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView = [UIView new];
    [self.view addSubview:tableview];
    [tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [tableview registerClass:[TRViewCell class] forCellReuseIdentifier:@"trcellId"];
    self.tableview = tableview;
    
    [self requestNBAData];
    
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==1?self.teammatchArray.count:self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section==1?30:120;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"视频锦集",@"赛事赛程"][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
        teamMatch *tm = self.teammatchArray[indexPath.row];
        cell.textLabel.text = tm.name;
        cell.textLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:17];
        return cell;
    }else {
        TR *tr = self.listArray[indexPath.row];
        TRViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trcellId" forIndexPath:indexPath];
        [cell setTr:tr];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section) {
        teamMatch *tm = self.teammatchArray[indexPath.row];
        WebviewController *vc = [[WebviewController alloc] init];
        vc.url = [NSURL URLWithString:tm.url];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        TR *tr = self.listArray[indexPath.row];
        WebviewController *vc = [[WebviewController alloc] init];
        vc.url = [NSURL URLWithString:tr.link1url];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)requestNBAData {
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:app_key5 forKey:@"key"];
    [SVProgressHUD showWithStatus:@"加载中"];
    __weak __typeof(self)weakself = self;
    [request RequestDataWithMethod:@"GET" Url:nba_api param:dic successed:^(NSDictionary *responseDic) {
//        NSLog(@"%@",responseDic);
        [SVProgressHUD dismiss];
        if (![responseDic[@"error_code"] integerValue]) {
            weakself.listArray = [NSMutableArray arrayWithCapacity:0];
            weakself.teammatchArray = [NSMutableArray arrayWithCapacity:0];
            NSDictionary *resultDic = responseDic[@"result"];
            NSString *title = resultDic[@"title"];
            self.title = title;
            NSArray *listArray = resultDic[@"list"];
            NSArray *teammatchs = resultDic[@"teammatch"];
            for (NSDictionary *dic in teammatchs) {
                teamMatch *tm = [[teamMatch alloc] init];
                [tm setValuesForKeysWithDictionary:dic];
                [weakself.teammatchArray addObject:tm];
            }
            for (NSDictionary *dic in listArray) {
                NSArray *trArray = dic[@"tr"];
                for (NSDictionary *dic in trArray) {
                    TR *tr = [[TR alloc] init];
                    [tr setValuesForKeysWithDictionary:dic];
                    [self.listArray addObject:tr];
                }
            }
        }
        [weakself.tableview reloadData];
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
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

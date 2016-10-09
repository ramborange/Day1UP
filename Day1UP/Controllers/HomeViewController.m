//
//  HomeViewController.m
//  Day1UP
//
//  Created by ramborange on 16/9/28.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "HomeViewController.h"
#import "RootViewController.h"
#import "HomeTableViewCell.h"
#import "PastTodayController.h"
#import "HappyViewController.h"
#import "RobotViewController.h"
#import "NBAViewController.h"
#import "WeiXinJXController.h"
#import "JiakaoViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gillsans" size:20]}];
    [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
    self.title = @"Data Type（from Juhe.cn）";
    
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [UIView new];
    _tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableview];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"cellId"];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    [cell.img jk_setImageWithString:@[@"图",@"历",@"笑",@"问",@"N",@"微",@"驾"][indexPath.row] color:[UIColor jk_randomColor] circular:YES fontName:@"Gillsans-Light"];
    cell.titleLabel.text = @[@"图书电商数据",@"历史上的今天",@"笑话大全",@"问答机器人",@"NBA赛事",@"微信精选",@"驾照题库"][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc;
    if (indexPath.row==0) {
        vc = [[RootViewController alloc] init];
    }else if (indexPath.row==1) {
        vc = [[PastTodayController alloc] init];
    }else if (indexPath.row==2) {
        vc = [[HappyViewController alloc] init];
    }else if (indexPath.row==3) {
        vc = [[RobotViewController alloc] init];
    }else if (indexPath.row==4) {
        vc = [[NBAViewController alloc] init];
    }else if (indexPath.row==5) {
        vc = [[WeiXinJXController alloc] init];
    }else {
        vc = [[JiakaoViewController alloc] init];
    }
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

//
//  JokeContentController.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JokeContentController.h"
#import "JokeModel.h"
#import "JokeViewCell.h"
@interface JokeContentController ()


@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation JokeContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self.tableView registerClass:[JokeViewCell class] forCellReuseIdentifier:@"jokecellid"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = RGBA(0.95, 0.95, 0.95, 1);

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshJokeData)];
    [self.tableView.mj_header beginRefreshing];

}

- (void)refreshJokeData {
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    NSInteger dateInterval = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *dateString = @(dateInterval).stringValue;
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@"desc",@1,@20,dateString,app_key3] forKeys:@[@"sort",@"page",@"pagesize",@"time",@"key"]];
    __weak __typeof(self)weaself = self;
    [request RequestDataWithMethod:@"GET" Url:joke_list param:dic successed:^(NSDictionary *responseDic) {
//        NSLog(@"response: %@",responseDic);
        [weaself.tableView.mj_header endRefreshing];
        if ([responseDic[@"reason"] isEqualToString:@"Success"]) {
            NSArray *results = responseDic[@"result"][@"data"];
            if (results.count) {
                weaself.dataArray = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *dic in results) {
                    JokeModel *jm = [[JokeModel alloc] init];
                    [jm setValuesForKeysWithDictionary:dic];
                    [weaself.dataArray addObject:jm];
                }
            }
            [weaself.tableView reloadData];

            if (weaself.tableView.mj_footer==nil) {
                weaself.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJokeData)];
            }
        }

    } failed:^(NSError *error) {
        [weaself.tableView.mj_header endRefreshing];
        NSLog(@"error:%@",error);
    }];
}

- (void)loadMoreJokeData {
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    JokeModel *jkModel = [self.dataArray lastObject];
    NSString *dateString = jkModel.unixtime;
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@"desc",@1,@20,dateString,app_key3] forKeys:@[@"sort",@"page",@"pagesize",@"time",@"key"]];
    __weak __typeof(self)weaself = self;
    [request RequestDataWithMethod:@"GET" Url:joke_list param:dic successed:^(NSDictionary *responseDic) {
        //        NSLog(@"response: %@",responseDic);
        [weaself.tableView.mj_footer endRefreshing];
        if ([responseDic[@"reason"] isEqualToString:@"Success"]) {
            NSArray *results = responseDic[@"result"][@"data"];
            if (results.count) {
                for (NSDictionary *dic in results) {
                    JokeModel *jm = [[JokeModel alloc] init];
                    [jm setValuesForKeysWithDictionary:dic];
                    [weaself.dataArray addObject:jm];
                }
            }
            [weaself.tableView reloadData];
        }
    } failed:^(NSError *error) {
        [weaself.tableView.mj_header endRefreshing];
        NSLog(@"error:%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)getHeightWith:(NSString *)str {
    NSMutableParagraphStyle *p = [[NSMutableParagraphStyle alloc] init];
    p.lineSpacing = 5;
    p.paragraphSpacing = 5;
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:str];
    [as addAttribute:NSParagraphStyleAttributeName value:p range:NSMakeRange(0, [str length])];
    [as addAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:17]} range:NSMakeRange(0, [str length])];
    
    CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:as withConstraints:CGSizeMake(self.view.bounds.size.width-20, MAXFLOAT) limitedToNumberOfLines:0];
    return size.height+20;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JokeModel *jkModel = self.dataArray[indexPath.row];
    
    return [self getHeightWith:jkModel.content];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JokeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jokecellid" forIndexPath:indexPath];
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    JokeModel *jkModel = self.dataArray[indexPath.row];
    cell.jkModel = jkModel;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end

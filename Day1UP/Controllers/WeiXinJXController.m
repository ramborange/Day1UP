//
//  WeiXinJXController.m
//  Day1UP
//
//  Created by ramborange on 16/10/8.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "WeiXinJXController.h"
#import "WeixinJX.h"
#import "WeixinJXCell.h"
#import "WebviewController.h"

@interface WeiXinJXController ()
{
    @private
    NSInteger currentPageNum;
    NSInteger totalPageNum;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation WeiXinJXController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"微信精选";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[WeixinJXCell class] forCellReuseIdentifier:@"wcellId"];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];

    currentPageNum = 1;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNewData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadMoreJxData {
    if (currentPageNum<totalPageNum) {
        currentPageNum++;
        [self requestData];
    }else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)requestNewData {
    currentPageNum = 1;
    [self requestData];
}

- (void)requestData {
    if (currentPageNum==1) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    NSDictionary *paramDic = @{@"key":app_key6,@"pno":@(currentPageNum),@"ps":@(20)};
    __weak __typeof(self)weakself = self;
    [request RequestDataWithMethod:@"GET" Url:wxJX_api param:paramDic successed:^(NSDictionary *responseDic) {
//        NSLog(@"success:%@",responseDic);
        if (currentPageNum<2) {
            [weakself.tableView.mj_header endRefreshing];
        }else if (currentPageNum<totalPageNum){
            [weakself.tableView.mj_footer endRefreshing];
        }else {
            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        NSDictionary *resultDic = responseDic[@"result"];
        totalPageNum = [resultDic[@"totalPage"] integerValue];
        NSArray *listArray = resultDic[@"list"];
        for (NSDictionary *dic in listArray) {
            WeixinJX *jx = [[WeixinJX alloc] init];
            [jx setValuesForKeysWithDictionary:dic];
            [weakself.dataArray addObject:jx];
        }
        if (listArray.count>=20) {
            if (weakself.tableView.mj_footer==nil) {
                weakself.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:weakself refreshingAction:@selector(loadMoreJxData)];
            }
        }
        [weakself.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeixinJXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wcellId" forIndexPath:indexPath];
    
    WeixinJX *jx = self.dataArray[indexPath.row];
    [cell setJx:jx];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    WeixinJX *jx = self.dataArray[indexPath.row];
    WebviewController *vc = [[WebviewController alloc] init];
    vc.url = [NSURL URLWithString:jx.url];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

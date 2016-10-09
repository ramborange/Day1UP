//
//  DetailViewController.m
//  Day1UP
//
//  Created by ramborange on 16/9/27.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "DetailViewController.h"
#import "BookInfo.h"
#import "BookDetailCell.h"
#import "BookInfoController.h"
@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{

}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Book List";

    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView = [UIView new];
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [tableview.mj_header beginRefreshing];
    [self.view addSubview:tableview];
    [tableview registerClass:[BookDetailCell class] forCellReuseIdentifier:@"cellId"];
    self.tableview = tableview;
    
}

- (void)requestData {
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:app_key,@"key",self.currentCatalogId,@"catalog_id",@0,@"pn",@30,@"rn", nil];
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    __weak __typeof(self)weakSelf = self;
    [request RequestDataWithMethod:@"GET" Url:book_query param:paramDic successed:^(NSDictionary *responseDic) {
//        NSLog(@"%@",responseDic);
        NSArray *results = responseDic[@"result"][@"data"];
        [_tableview.mj_header endRefreshing];
        if (results.count) {
            for (NSDictionary *dic in results) {
                BookInfo *bi = [[BookInfo alloc] init];
                [bi setValuesForKeysWithDictionary:dic];
                [weakSelf.dataArray addObject:bi];
            }
            [weakSelf.tableview reloadData];
            if (weakSelf.tableview.mj_footer==nil) {
                weakSelf.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            }
            if (results.count<30) {
                [weakSelf.tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }
        
    } failed:^(NSError *error) {
        NSLog(@"error: %@",error);
    }];

}

- (void)loadMoreData {
    if (self.dataArray.count) {
        NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:app_key,@"key",self.currentCatalogId,@"catalog_id",@(self.dataArray.count),@"pn",@30,@"rn", nil];
        DataRequestHelper *request = [[DataRequestHelper alloc] init];
        __weak __typeof(self)weakSelf = self;
        [request RequestDataWithMethod:@"GET" Url:book_query param:paramDic successed:^(NSDictionary *responseDic) {
            //        NSLog(@"%@",responseDic);
            if ([responseDic[@"resultcode"] integerValue]==200) {
                NSArray *results = responseDic[@"result"][@"data"];
                if (results.count<30) {
                    [weakSelf.tableview.mj_footer endRefreshingWithNoMoreData];
                }else {
                    [weakSelf.tableview.mj_footer endRefreshing];
                }
                for (NSDictionary *dic in results) {
                    BookInfo *bi = [[BookInfo alloc] init];
                    [bi setValuesForKeysWithDictionary:dic];
                    [weakSelf.dataArray addObject:bi];
                }
                [weakSelf.tableview reloadData];
            }else {
                [weakSelf.tableview.mj_footer endRefreshingWithNoMoreData];
            }
            
            
        } failed:^(NSError *error) {
            NSLog(@"error: %@",error);
        }];
    }
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    BookInfo *bi = self.dataArray[indexPath.row];
    [cell configCellWith:bi];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BookInfoController *bookInfoViewcontroller = [[BookInfoController alloc] init];
    bookInfoViewcontroller.currentBookInfo = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:bookInfoViewcontroller animated:YES];
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

//
//  JokeImgController.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JokeImgController.h"
#import "JokeImgeViewCell.h"
#import "ImgModel.h"
@interface JokeImgController ()<MWPhotoBrowserDelegate>


@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JokeImgController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[JokeImgeViewCell class] forCellReuseIdentifier:@"cellImgId"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshImgData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.backgroundColor = RGBA(0.95, 0.95, 0.95, 1);
}

- (void)refreshImgData {
    NSInteger date = [[NSDate date] timeIntervalSince1970];
    NSString *datestring = @(date).stringValue;
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@"desc",@1,@20,datestring,app_key3] forKeys:@[@"sort",@"page",@"pagesize",@"time",@"key"]];
    __weak __typeof(self)weakself = self;
    [request RequestDataWithMethod:@"GET" Url:joke_img param:dic successed:^(NSDictionary *responseDic) {
        //NSLog(@"%@",responseDic);
        [weakself.tableView.mj_header endRefreshing];
        if ([responseDic[@"reason"] isEqualToString:@"Success"]) {
            NSArray *results = responseDic[@"result"][@"data"];
            if (results.count) {
                weakself.dataArray = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *dic in results) {
                    ImgModel *im = [[ImgModel alloc] init];
                    [im setValuesForKeysWithDictionary:dic];
                    [weakself.dataArray addObject:im];
                }
                if (weakself.tableView.mj_footer==nil) {
                    weakself.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreImgData)];
                }
            }
        }
        [weakself.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];

}

- (void)loadMoreImgData {
    ImgModel *im = [self.dataArray lastObject];
    NSString *datestring = im.unixtime;
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@"desc",@1,@20,datestring,app_key3] forKeys:@[@"sort",@"page",@"pagesize",@"time",@"key"]];
    __weak __typeof(self)weakself = self;
    [request RequestDataWithMethod:@"GET" Url:joke_img param:dic successed:^(NSDictionary *responseDic) {
        //NSLog(@"%@",responseDic);
        [weakself.tableView.mj_footer endRefreshing];
        if ([responseDic[@"reason"] isEqualToString:@"Success"]) {
            NSArray *results = responseDic[@"result"][@"data"];
            if (results.count) {
                for (NSDictionary *dic in results) {
                    ImgModel *im = [[ImgModel alloc] init];
                    [im setValuesForKeysWithDictionary:dic];
                    [weakself.dataArray addObject:im];
                }
            }
        }
        [weakself.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImgModel *im = self.dataArray[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:im keyPath:@"imgModel" cellClass:[JokeImgeViewCell class] contentViewWidth:self.view.bounds.size.width];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JokeImgeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellImgId" forIndexPath:indexPath];
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    ImgModel *im = self.dataArray[indexPath.row];
    [cell setImgModel:im];

//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MWPhotoBrowser *pb = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [pb setCurrentPhotoIndex:indexPath.row];
    [self.navigationController pushViewController:pb animated:YES];
}

#pragma mark - MWPhotoBrowser delegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.dataArray.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index<self.dataArray.count) {
        ImgModel *im = self.dataArray[index];
        MWPhoto *mwp = [[MWPhoto alloc] initWithURL:[NSURL URLWithString:im.url]];
        return mwp;
    }
    return nil;
}

@end

//
//  HistoryTDetailController.m
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "HistoryTDetailController.h"
#import "Photo.h"
#import "ContentViewCell.h"
#import "ImageViewCell.h"
@interface HistoryTDetailController ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate>


@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonnull, strong) NSMutableArray *pbArray;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HistoryTDetailController

-(void)dealloc {
    _titleLabel = nil;
    _tableview = nil;
    _dataArray = nil;
    _pbArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"event detail";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableview];
    
    [_tableview registerClass:[ContentViewCell class] forCellReuseIdentifier:@"contentCellId"];
    [_tableview registerClass:[ImageViewCell class] forCellReuseIdentifier:@"imageCellId"];
    
 
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.bounds.size.width-40, 40)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont fontWithName:@"Gillsans" size:20];
    [headerView addSubview:_titleLabel];
    _tableview.tableHeaderView = headerView;
    
    
    
    
    [self requestData];
}

- (void)requestData {
    DataRequestHelper *rquest = [[DataRequestHelper alloc] init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[app_key2,self.eventId] forKeys:@[@"key",@"e_id"]];
    [rquest RequestDataWithMethod:@"GET" Url:event_detail param:dic successed:^(NSDictionary *responseDic) {
//        NSLog(@"%@",responseDic);
        if ([responseDic[@"reason"] isEqualToString:@"success"]) {
            NSDictionary *result = [responseDic[@"result"] firstObject];
            _titleLabel.text = result[@"title"];

            self.dataArray = [NSMutableArray arrayWithCapacity:0];
            self.pbArray = [NSMutableArray arrayWithCapacity:0];
            
            NSString *content = result[@"content"];
            NSArray *photos = result[@"picUrl"];
            
            NSMutableArray *photosTmp = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in photos) {
                Photo *p = [[Photo alloc] init];
                [p setValuesForKeysWithDictionary:dic];
                MWPhoto *mwp = [[MWPhoto alloc] initWithURL:[NSURL URLWithString:p.url]];
                [self.pbArray addObject:mwp];
                [photosTmp addObject:p];
            }
            if (photosTmp.count) {
                NSInteger uniLength = [content length]/(photosTmp.count+1);
                for (int i=0; i<=photosTmp.count; i++) {
                    if (i<photosTmp.count) {
                        [self.dataArray addObject:@{@"kind":@"content",@"data":[content substringWithRange:NSMakeRange(uniLength*i, uniLength)]}];
                        [self.dataArray addObject:@{@"kind":@"photo",@"data":photosTmp[i]}];
                    }else {
                        [self.dataArray addObject:@{@"kind":@"content",@"data":[content substringWithRange:NSMakeRange(uniLength*i, ([content length]-uniLength*i))]}];

                    }
                }
            }else {
                [self.dataArray addObject:@{@"kind":@"content",@"data":content}];
            }
            
            [_tableview reloadData];
        }
        
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

#pragma mark - 获取高度
- (CGFloat)getHeightWith:(NSString *)contentString {
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 5.0;
    para.paragraphSpacing = 5.0;
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:contentString];
    [as addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, [contentString length])];
    [as addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:17]} range:NSMakeRange(0, [contentString length])];
    
    CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:as withConstraints:CGSizeMake(self.view.bounds.size.width-20, MAXFLOAT) limitedToNumberOfLines:0];
    return size.height+20;
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count) {
        NSDictionary *dic = self.dataArray[indexPath.row];
        if ([dic[@"kind"] isEqualToString:@"content"]) {
            NSString *content = dic[@"data"];
            return [self getHeightWith:content];
        }else {
            return 240.0;
        }
    }
    return 0.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count) {
        NSDictionary *dic = self.dataArray[indexPath.row];
        if ([dic[@"kind"] isEqualToString:@"content"]) {
            ContentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCellId" forIndexPath:indexPath];
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            NSString *contentString = dic[@"data"];
            cell.contentString = contentString;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            ImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCellId" forIndexPath:indexPath];
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            
            Photo *p = dic[@"data"];
            cell.photo = p;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataArray[indexPath.row];
    Photo *photo = dic[@"data"];
    
    MWPhotoBrowser *pb = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [pb setCurrentPhotoIndex:([photo.pid integerValue]-1)];
    [self.navigationController pushViewController:pb animated:YES];
    
}

#pragma mark - MWPhotoBrowser Delegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.pbArray.count;
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index<self.pbArray.count) {
        return self.pbArray[index];
    }else {
        return nil;
    }
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

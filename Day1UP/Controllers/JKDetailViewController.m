//
//  JKDetailViewController.m
//  Day1UP
//
//  Created by ramborange on 16/10/9.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JKDetailViewController.h"
#import "JKModel.h"
#import "JKCollectionViewCell.h"
@interface JKDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{

}
@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JKDetailViewController
-(void)dealloc {
    _collectionview = nil;
    _dataArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"dataFromJuhe";
    [SVProgressHUD showWithStatus:@"加载中"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0;
    flowLayout.minimumInteritemSpacing = 0.0;
    self.collectionview = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.pagingEnabled = YES;
    self.collectionview.backgroundColor = [UIColor whiteColor];
    self.collectionview.showsHorizontalScrollIndicator = NO;
//    [self.collectionview setScrollEnabled:NO];
    [self.view addSubview:self.collectionview];
    [self.collectionview registerClass:[JKCollectionViewCell class] forCellWithReuseIdentifier:@"jkcellId"];

    [self requestJKData];
}

#pragma mark - collectionview delegate & datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, self.view.size.height-64);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jkcellId" forIndexPath:indexPath];
    JKModel *jm = self.dataArray[indexPath.row];
    [cell setJkModel:jm];
    
    return cell;
}

- (void)requestJKData {
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    __weak __typeof(self)weakself = self;
    [request RequestDataWithMethod:@"GET" Url:jiakao_api param:self.paramDicInfo successed:^(NSDictionary *responseDic) {
        [SVProgressHUD dismiss];
//        NSLog(@"success:%@",responseDic);
        if (![responseDic[@"error_code"] integerValue]) {
            weakself.dataArray = [NSMutableArray arrayWithCapacity:0];
            NSArray *results = responseDic[@"result"];
            for (NSDictionary *dic in results) {
                JKModel *jm = [[JKModel alloc] init];
                [jm setValuesForKeysWithDictionary:dic];
                [weakself.dataArray addObject:jm];
            }
            [weakself.collectionview reloadData];
        }
    } failed:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
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

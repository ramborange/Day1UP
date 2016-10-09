//
//  RootViewController.m
//  Day1UP
//
//  Created by ramborange on 16/9/26.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "RootViewController.h"
#import "BookCatalog.h"
#import "DetailViewController.h"
#import "ListCollectionCell.h"
@interface RootViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{

}
@property (nonnull, nonatomic, strong) UICollectionView *collectionview;
@property (nullable, nonatomic, strong) NSMutableArray *bookDataArray;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Book Catalog";
    self.bookDataArray = [NSMutableArray arrayWithCapacity:0];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionview = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.backgroundColor = [UIColor whiteColor];
    _collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [_collectionview.mj_header beginRefreshing];
    [self.view addSubview:_collectionview];
    [_collectionview registerClass:[ListCollectionCell class] forCellWithReuseIdentifier:@"collectionCellId"];
}

- (void)requestData {
    self.bookDataArray = [NSMutableArray arrayWithCapacity:0];
    DataRequestHelper *request = [[DataRequestHelper alloc] init];
    __weak __typeof(self)weakSelf = self;
    [request RequestDataWithMethod:@"GET" Url:book_catalog param:@{@"key":app_key} successed:^(NSDictionary *responseDic) {
//        NSLog(@"success: %@",responseDic);
        [weakSelf.collectionview.mj_header endRefreshing];
        NSArray *results = responseDic[@"result"];
        if (results.count) {
            for (NSDictionary *dic in results) {
                BookCatalog *ba = [[BookCatalog alloc] init];
                [ba setValuesForKeysWithDictionary:dic];
                [weakSelf.bookDataArray addObject:ba];
            }
        }
        [weakSelf.collectionview reloadData];

    } failed:^(NSError *error) {
        [weakSelf.collectionview.mj_header endRefreshing];
        NSLog(@"error: %@",error);
    }];
}

#pragma mark - delegate of collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bookDataArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.bounds.size.width-2.0)/2.0, 60.0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCellId" forIndexPath:indexPath];
    BookCatalog *bc = self.bookDataArray[indexPath.row];
    cell.titleLabel.text = bc.catalog;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    BookCatalog *bc = self.bookDataArray[indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.currentCatalogId = bc.catalogId;
    
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back_item"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_item"];
    
    
    
    
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

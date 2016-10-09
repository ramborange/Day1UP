//
//  HappyViewController.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "HappyViewController.h"
#import "JokeImgController.h"
#import "JokeContentController.h"
@interface HappyViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) JokeImgController *imgcontroller;
@property (nonatomic, strong) JokeContentController *jokecontroller;

@end

@implementation HappyViewController
- (void)dealloc {
    _imgcontroller = nil;
    _jokecontroller = nil;
    _scrollview = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.translucent = NO;
    
    UISegmentedControl *titleSeg = [[UISegmentedControl alloc] initWithItems:@[@"幽默段子",@"搞笑动图"]];
    titleSeg.frame = CGRectMake(0, 0, 160, 30);
    [titleSeg setSelectedSegmentIndex:0];
    titleSeg.tag = 32;
    [titleSeg setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:17]} forState:UIControlStateNormal];
    [titleSeg addTarget:self action:@selector(titleSegClicked:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = titleSeg;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:view];
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    _scrollview.delegate = self;
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    [_scrollview setContentSize:CGSizeMake(self.view.bounds.size.width*2, 0)];
    [self.view addSubview:_scrollview];
    
    _jokecontroller = [[JokeContentController alloc] init];
    _imgcontroller = [[JokeImgController alloc] init];
    [self addChildViewController:_jokecontroller];
    [self addChildViewController:_imgcontroller];
    
    _jokecontroller.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
    _imgcontroller.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height-64);
    [_scrollview addSubview:_jokecontroller.view];
    [_scrollview addSubview:_imgcontroller.view];
}

#pragma mark - scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger idnex = scrollView.contentOffset.x/self.view.bounds.size.width;
    UISegmentedControl *seg = (UISegmentedControl *)[self.navigationItem.titleView viewWithTag:32];
    [seg setSelectedSegmentIndex:idnex];
    if (idnex) {
        [self.imgcontroller.tableView reloadData];
    }
}
#pragma mark - end

- (void)titleSegClicked:(UISegmentedControl *)seg {
    if (seg.selectedSegmentIndex) {
        //img
        [self.imgcontroller.tableView reloadData];
        [_scrollview setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:YES];
    }else {
        //joke
        [_scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
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

//
//  JiakaoViewController.m
//  Day1UP
//
//  Created by ramborange on 16/10/8.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JiakaoViewController.h"
#import "JKDetailViewController.h"
@interface JiakaoViewController ()
{
    NSInteger subjectType;
    NSInteger modelType;
    NSInteger testType;
    
    BOOL subjectTypeIsSelect;
    BOOL modelTypeIsSelect;
    BOOL testTypeIsSelect;
}
@end

@implementation JiakaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"驾考题库";
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollview.showsVerticalScrollIndicator = NO;
    [scrollview setContentSize:CGSizeMake(self.view.bounds.size.width, 650)];
    [self.view addSubview:scrollview];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
    infoLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
    infoLabel.textColor = [UIColor darkGrayColor];
    infoLabel.text = @"选择考试科目类型";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    [scrollview addSubview:infoLabel];
    
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@[@"科目一",@"科目四"][i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(50, 60+40*i, self.view.bounds.size.width-100, 30);
        btn.tag = 100+i;
        btn.layer.cornerRadius = 6;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:btn];
    }
    
    UILabel *infoLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 40)];
    infoLabel2.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
    infoLabel2.textColor = [UIColor darkGrayColor];
    infoLabel2.text = @"选择驾照类型";
    infoLabel2.textAlignment = NSTextAlignmentCenter;
    [scrollview addSubview:infoLabel2];
    
    for (int i=0; i<6; i++) {
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:@[@"C1",@"C2",@"A1",@"A2",@"B1",@"B2"][i] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
        btn2.frame = CGRectMake(50, 190+40*i, self.view.bounds.size.width-100, 30);
        btn2.tag = 200+i;
        btn2.layer.cornerRadius = 6;
        btn2.layer.masksToBounds = YES;
        [btn2 addTarget:self action:@selector(btn2Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:btn2];
    }
    
    
    UILabel *infoLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 440, self.view.bounds.size.width, 40)];
    infoLabel3.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
    infoLabel3.textColor = [UIColor darkGrayColor];
    infoLabel3.text = @"选择测试类型";
    infoLabel3.textAlignment = NSTextAlignmentCenter;
    [scrollview addSubview:infoLabel3];
    
    for (int i=0; i<2; i++) {
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn3 setTitle:@[@"随机（随机100题）",@"顺序（全部题目）"][i] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn3 setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
        btn3.frame = CGRectMake(50, 480+40*i, self.view.bounds.size.width-100, 30);
        btn3.tag = 300+i;
        btn3.layer.cornerRadius = 6;
        btn3.layer.masksToBounds = YES;
        [btn3 addTarget:self action:@selector(btn3Clicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:btn3];
    }
    
//    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [commitBtn setTitle:@"开始" forState:UIControlStateNormal];
//    [commitBtn setBackgroundImage:[UIImage imageWithColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]] forState:UIControlStateNormal];
//    commitBtn.frame = CGRectMake(self.view.bounds.size.width/2-50, 580, 100, 40);
//    commitBtn.layer.cornerRadius = 6;
//    commitBtn.layer.masksToBounds = YES;
//    [scrollview addSubview:commitBtn];
//    [commitBtn addTarget:self action:@selector(commitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commitBtnClicked {
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjects:@[app_key7,@((subjectType?4:1)),@[@"c1",@"c2",@"a1",@"a2",@"b1",@"b2"][modelType],@[@"rand",@"order"][testType]] forKeys:@[@"key",@"subject",@"model",@"testType"]];
    JKDetailViewController *vc = [[JKDetailViewController alloc] init];
    vc.paramDicInfo = paramDic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnClicked:(UIButton *)btn {
    for (int i=0; i<2; i++) {
        UIButton *btn = [self.view viewWithTag:100+i];
        [btn setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    subjectType = btn.tag-100;
    subjectTypeIsSelect = YES;
    
    if (subjectTypeIsSelect&&modelTypeIsSelect&&testTypeIsSelect) {
        [self commitBtnClicked];
    }
}

- (void)btn2Clicked:(UIButton *)btn {
    for (int i=0; i<6; i++) {
        UIButton *btn = [self.view viewWithTag:200+i];
        [btn setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    modelType = btn.tag-200;
    modelTypeIsSelect = YES;
    
    if (subjectTypeIsSelect&&modelTypeIsSelect&&testTypeIsSelect) {
        [self commitBtnClicked];
    }
}

- (void)btn3Clicked:(UIButton *)btn {
    for (int i=0; i<2; i++) {
        UIButton *btn = [self.view viewWithTag:300+i];
        [btn setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
    }
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    testType = btn.tag-300;
    testTypeIsSelect = YES;
    
    if (subjectTypeIsSelect&&modelTypeIsSelect&&testTypeIsSelect) {
        [self commitBtnClicked];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (int i=0; i<6; i++) {
        if (i<2) {
            UIButton *btn = [self.view viewWithTag:100+i];
            [btn setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
            UIButton *btn3 = [self.view viewWithTag:300+i];
            [btn3 setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
        }
        UIButton *btn2 = [self.view viewWithTag:200+i];
        [btn2 setBackgroundImage:[UIImage imageWithColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]] forState:UIControlStateNormal];
    }
    
    subjectTypeIsSelect = NO;
    modelTypeIsSelect = NO;
    testTypeIsSelect = NO;
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

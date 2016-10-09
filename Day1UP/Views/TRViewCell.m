//
//  TRViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/10/8.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "TRViewCell.h"
#import "WebviewController.h"
#import "NBAViewController.h"

@implementation TRViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.player1Logo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.player1Logo];
        
        self.player1Name = [[UILabel alloc] init];
        self.player1Name.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        self.player1Name.textColor = [UIColor darkGrayColor];
        self.player1Name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.player1Name];
        
        self.player2Logo = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.player2Logo];
        
        self.player2Name = [[UILabel alloc] init];
        self.player2Name.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        self.player2Name.textColor = [UIColor darkGrayColor];
        self.player2Name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.player2Name];
        
        self.scoreLabel = [[UILabel alloc] init];
        self.scoreLabel.font = [UIFont fontWithName:@"Gillsans" size:20];
        self.scoreLabel.textColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.scoreLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont fontWithName:@"Gillsans" size:15];
        self.timeLabel.textColor = [UIColor blackColor];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.timeLabel];
        
//        self.link1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.link1Btn setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
//        self.link1Btn.titleLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
//        [self.contentView addSubview:self.link1Btn];
        
        self.link2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.link2Btn setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        self.link2Btn.titleLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        [self.contentView addSubview:self.link2Btn];
        
        UIView *view = self.contentView;
        self.player1Logo.sd_layout
        .topSpaceToView(view,10)
        .leftSpaceToView(view,100)
        .widthIs(80)
        .heightIs(80);
        
        self.player1Name.sd_layout
        .topSpaceToView(_player1Logo,0)
        .leftSpaceToView(view,100)
        .widthRatioToView(_player1Logo,1)
        .heightIs(20);
        
        self.player2Logo.sd_layout
        .topSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .widthIs(80)
        .heightIs(80);
        
        self.player2Name.sd_layout
        .topSpaceToView(_player2Logo,0)
        .rightSpaceToView(view,10)
        .widthRatioToView(_player2Logo,1)
        .heightIs(20);
        
        self.scoreLabel.sd_layout
        .centerYEqualToView(_player1Logo)
        .leftSpaceToView(_player1Logo,10)
        .rightSpaceToView(_player2Logo,10)
        .heightIs(20);
        
        self.timeLabel.sd_layout
        .centerYEqualToView(_player1Logo)
        .leftSpaceToView(view,0)
        .widthIs(100)
        .heightIs(20);
        
//        self.link1Btn.sd_layout
//        .leftSpaceToView(view,0)
//        .topSpaceToView(_timeLabel,20)
//        .widthIs(100)
//        .heightIs(20);
        
        self.link2Btn.sd_layout
        .leftSpaceToView(view,0)
        .topSpaceToView(_timeLabel,10)
        .widthIs(100)
        .heightIs(20);
        
    }
    return self;
}

- (void)setTr:(TR *)tr {
    self.player1Name.text = tr.player1;
    self.player2Name.text = tr.player2;
    [self.player1Logo sd_setImageWithURL:[NSURL URLWithString:tr.player1logobig] forState:UIControlStateNormal];
    [self.player2Logo sd_setImageWithURL:[NSURL URLWithString:tr.player2logobig] forState:UIControlStateNormal];
    self.scoreLabel.text = tr.score;
    self.timeLabel.text = tr.time;
//    [self.link1Btn setTitle:tr.link1text forState:UIControlStateNormal];
    [self.link2Btn setTitle:tr.link2text forState:UIControlStateNormal];
    
    __weak __typeof(tr)weaktr = tr;
    HomeViewController *vc = [(AppDelegate *)[UIApplication sharedApplication].delegate rootViewcontroller];
    NBAViewController *nbaVc = [vc.navigationController.viewControllers lastObject];
    __weak __typeof(nbaVc)weakNbaVc = nbaVc;
    
    [_player1Logo jk_addActionHandler:^(NSInteger tag) {
        WebviewController *vc = [[WebviewController alloc] init];
        vc.url = [NSURL URLWithString:weaktr.player1url];
        [weakNbaVc.navigationController pushViewController:vc animated:YES];
    }];
    
    [_player2Logo jk_addActionHandler:^(NSInteger tag) {
        WebviewController *vc = [[WebviewController alloc] init];
        vc.url = [NSURL URLWithString:weaktr.player2url];
        [weakNbaVc.navigationController pushViewController:vc animated:YES];
    }];
    
//    [_link1Btn jk_addActionHandler:^(NSInteger tag) {
//        WebviewController *vc = [[WebviewController alloc] init];
//        vc.url = [NSURL URLWithString:weaktr.link1url];
//        [weakNbaVc.navigationController pushViewController:vc animated:YES];
//    }];
    
    [_link2Btn jk_addActionHandler:^(NSInteger tag) {
        WebviewController *vc = [[WebviewController alloc] init];
        vc.url = [NSURL URLWithString:weaktr.link2url];
        [weakNbaVc.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

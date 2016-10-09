//
//  TRViewCell.h
//  Day1UP
//
//  Created by ramborange on 16/10/8.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TR.h"
@interface TRViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *player1Name;
@property (nonatomic, strong) UILabel *player2Name;

@property (nonatomic, strong) UIButton *player1Logo;
@property (nonatomic, strong) UIButton *player2Logo;

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *link1Btn;
@property (nonatomic, strong) UIButton *link2Btn;

@property (nonatomic, strong) TR *tr;

@end





//
//  WeixinJXCell.h
//  Day1UP
//
//  Created by ramborange on 16/10/8.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeixinJX.h"

@interface WeixinJXCell : UITableViewCell

@property (nonatomic, strong) UIImageView *firstImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;

@property (nonatomic, strong) WeixinJX *jx;

@end

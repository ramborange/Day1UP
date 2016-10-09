//
//  JokeImgeViewCell.h
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImgModel.h"
@interface JokeImgeViewCell : UITableViewCell
@property (nonatomic, strong) UIView *bgview;

@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) ImgModel *imgModel;
@end

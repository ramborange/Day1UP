//
//  BookDetailCell.h
//  Day1UP
//
//  Created by ramborange on 16/9/27.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"
@interface BookDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *catalogLabel;
//@property (nonatomic, strong) UILabel *tagsLabel;

@property (nonatomic, strong) UILabel *sub1Label;
//@property (nonatomic, strong) UILabel *sub2Label;

@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UILabel *readingLabel;
//@property (nonatomic, strong) UILabel *onlineLabel;
//@property (nonatomic, strong) UILabel *bytimeLabel;

- (void)configCellWith:(BookInfo *)bookInfo;
@end

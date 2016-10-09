//
//  ImageViewCell.h
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
@interface ImageViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *img;
//@property (nonatomic, strong) UILabel *desc;

@property (nonatomic, strong) Photo *photo;

@end

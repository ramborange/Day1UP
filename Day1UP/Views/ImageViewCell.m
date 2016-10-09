//
//  ImageViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "ImageViewCell.h"

@implementation ImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.img = [[UIImageView alloc] init];
        [self.img setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.img];
        
//        self.desc = [[UILabel alloc] init];
//        self.desc.textColor = [UIColor blackColor];
//        self.desc.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
//        [self.contentView addSubview:self.desc];
        
        UIView *view = self.contentView;
        _img.sd_layout
        .topSpaceToView(view,0)
        .leftSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .heightIs(240.0);
        
//        _desc.sd_layout
//        .leftSpaceToView(view,10)
//        .rightSpaceToView(view,10)
//        .topSpaceToView(_img,10)
//        .heightIs(20);
        
    }
    return self;
}

- (void)setPhoto:(Photo *)photo {
    [self.img sd_setImageWithURL:[NSURL URLWithString:photo.url]];
//    self.desc.text = photo.pic_title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

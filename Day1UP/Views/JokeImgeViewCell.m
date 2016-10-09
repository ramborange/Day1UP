//
//  JokeImgeViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JokeImgeViewCell.h"
@implementation JokeImgeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bgview = [[UIView alloc] init];
        self.bgview.backgroundColor = [UIColor whiteColor];
        [self.bgview.layer setBorderColor:RGBA(0.86, 0.86, 0.86, 1).CGColor];
        [self.bgview.layer setBorderWidth:1.0];
        self.bgview.sd_cornerRadius = @5;
        [self.contentView addSubview:self.bgview];
        
        self.titlelabel = [[UILabel alloc] init];
        self.titlelabel.textColor = [UIColor darkGrayColor];
        self.titlelabel.font = [UIFont fontWithName:@"Gillsans-Light" size:17];
        [self.contentView addSubview:self.titlelabel];
        
        self.img = [[UIImageView alloc] init];
        [self.img setContentMode:UIViewContentModeScaleAspectFit];
//        self.img.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.img];
        
        UIView *view = self.contentView;
        _titlelabel.sd_layout
        .topSpaceToView(view,20)
        .leftSpaceToView(view,20)
        .rightSpaceToView(view,20)
        .heightIs(20);
        
        _img.sd_layout
        .topSpaceToView(_titlelabel,10)
        .leftSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .maxHeightIs(MAXFLOAT);
        
        _bgview.sd_layout
        .leftSpaceToView(view,10)
        .topSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .maxHeightIs(MAXFLOAT);
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setImgModel:(ImgModel *)imgModel {
    _titlelabel.text =  imgModel.content;
    __weak __typeof(self)weakself = self;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:imgModel.url] placeholderImage:[UIImage imageNamed:@"default_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        float height = (image.size.height*(weakself.bounds.size.width-20))/image.size.width;
        weakself.img.sd_layout.heightIs(height);
        weakself.bgview.sd_layout.heightIs(height+50);
        [weakself setupAutoHeightWithBottomView:_img bottomMargin:10.0];
    }];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

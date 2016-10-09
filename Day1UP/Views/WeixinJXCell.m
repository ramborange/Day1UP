//
//  WeixinJXCell.m
//  Day1UP
//
//  Created by ramborange on 16/10/8.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "WeixinJXCell.h"

@implementation WeixinJXCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.firstImg = [[UIImageView alloc] init];
//        [self.firstImg setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.firstImg];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        self.sourceLabel = [[UILabel alloc] init];
        self.sourceLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:13];
        self.sourceLabel.textColor = [UIColor brownColor];
        self.sourceLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.sourceLabel];
        
        UIView *view = self.contentView;
        self.firstImg.sd_layout
        .topSpaceToView(view,5)
        .leftSpaceToView(view,10)
        .widthIs(80)
        .heightIs(60);
        
        self.titleLabel.sd_layout
        .leftSpaceToView(_firstImg,10)
        .topSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .autoHeightRatio(0);
        
        self.sourceLabel.sd_layout
        .topSpaceToView(_titleLabel,0)
        .leftSpaceToView(_firstImg  ,10)
        .widthIs(200)
        .heightIs(20);

    }
    return self;
}

- (CGFloat)getHeightWithStr:(NSString *)string {
    CGRect rect = [string boundingRectWithSize:CGSizeMake(screen_width-95, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:15]} context:nil];
    return rect.size.height;
}

- (void)setJx:(WeixinJX *)jx {
    [_firstImg sd_setImageWithURL:[NSURL URLWithString:jx.firstImg] placeholderImage:[UIImage imageNamed:@"default_placeholder"]];
    _titleLabel.text = jx.title;
    _sourceLabel.text = jx.source;
    
    CGFloat height = [self getHeightWithStr:jx.title];
    
    _titleLabel.sd_layout
    .heightIs(height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

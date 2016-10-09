//
//  ContentViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "ContentViewCell.h"

@implementation ContentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        UIView *view = self.contentView;
        _contentLabel.sd_layout
        .topSpaceToView(view,10)
        .leftSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .maxHeightIs(MAXFLOAT);
    }
    return self;
}

- (void)setContentString:(NSString *)contentString {
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 5.0;
    para.paragraphSpacing = 5.0;
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:contentString];
    [as addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, [contentString length])];
    [as addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:17]} range:NSMakeRange(0, [contentString length])];
    [_contentLabel setAttributedText:as];
    
    CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:as withConstraints:CGSizeMake(self.bounds.size.width-20, MAXFLOAT) limitedToNumberOfLines:0];
    _contentLabel.sd_layout
    .heightIs(size.height);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:10];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

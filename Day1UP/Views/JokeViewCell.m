//
//  JokeViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JokeViewCell.h"

@implementation JokeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bgview = [[UIView alloc] init];
        bgview.backgroundColor = [UIColor whiteColor];
        [bgview.layer setBorderColor:RGBA(0.86, 0.86, 0.86, 1).CGColor];
        [bgview.layer setBorderWidth:1.0];
        bgview.sd_cornerRadius = @5;
        
        [self.contentView addSubview:bgview];
        
        self.contentLabel = [[TTTAttributedLabel alloc] initWithFrame:self.bounds];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        UIView *view = self.contentView;
        self.contentLabel.sd_layout
        .leftSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .topSpaceToView(view,10)
        .maxHeightIs(MAXFLOAT);
        
        bgview.sd_layout
        .leftSpaceToView(view,5)
        .topSpaceToView(view,5)
        .rightSpaceToView(view,5)
        .bottomSpaceToView(view,5);
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setJkModel:(JokeModel *)jkModel {
    NSMutableParagraphStyle *p = [[NSMutableParagraphStyle alloc] init];
    p.lineSpacing = 5;
    p.paragraphSpacing = 5;
    NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:jkModel.content];
    [as addAttribute:NSParagraphStyleAttributeName value:p range:NSMakeRange(0, [jkModel.content length])];
    [as addAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont fontWithName:@"Gillsans-Light" size:17]} range:NSMakeRange(0, [jkModel.content length])];
    [self.contentLabel setAttributedText:as];
    
    CGSize size = [TTTAttributedLabel sizeThatFitsAttributedString:as withConstraints:CGSizeMake(self.bounds.size.width-20, MAXFLOAT) limitedToNumberOfLines:0];
    _contentLabel.sd_layout.heightIs(size.height);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:10.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

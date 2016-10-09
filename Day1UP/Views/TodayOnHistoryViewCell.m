//
//  TodayOnHistoryViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "TodayOnHistoryViewCell.h"

@implementation TodayOnHistoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.textColor = [UIColor blackColor];
        self.dateLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        [self.contentView addSubview:self.dateLabel];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        self.titleLabel.font = [UIFont fontWithName:@"Gillsans" size:15];
        [self.contentView addSubview:self.titleLabel];
     
        self.img = [[UIImageView alloc] init];
        [self.contentView addSubview:self.img];
        
        UIView *view = self.contentView;
        _dateLabel.sd_layout
        .topSpaceToView(view,8)
        .leftSpaceToView(view,60)
        .rightSpaceToView(view,15)
        .heightIs(20.0);
        
        _titleLabel.sd_layout
        .topSpaceToView(_dateLabel,4)
        .leftSpaceToView(view,60)
        .rightSpaceToView(view,15)
        .heightIs(20.0);
        
        _img.sd_layout
        .leftSpaceToView(view,12)
        .topSpaceToView(view,12)
        .widthIs(36)
        .heightIs(36);
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

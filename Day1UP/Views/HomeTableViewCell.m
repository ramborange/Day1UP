//
//  HomeTableViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/28.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "HomeTableViewCell.h"
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 36, 36)];
        [self.contentView addSubview:self.img];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, self.bounds.size.width-100, 40)];
        self.titleLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:17];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

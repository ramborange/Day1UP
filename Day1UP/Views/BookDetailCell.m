//
//  BookDetailCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/27.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "BookDetailCell.h"

@implementation BookDetailCell

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
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"Gillsans" size:15];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.sub1Label = [[UILabel alloc] init];
        self.sub1Label.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        self.sub1Label.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.sub1Label];
        
        self.catalogLabel = [[UILabel alloc] init];
        self.catalogLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:13];
        self.catalogLabel.textColor = [UIColor brownColor];
        [self.contentView addSubview:self.catalogLabel];
        
        self.readingLabel = [[UILabel alloc] init];
        self.readingLabel.textAlignment = NSTextAlignmentRight;
        self.readingLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:13];
        self.readingLabel.textColor = [UIColor brownColor];
        [self.contentView addSubview:self.readingLabel];
        
//        self.catalogLabel.backgroundColor = [UIColor lightGrayColor];
//        self.readingLabel.backgroundColor = [UIColor redColor];
        
        UIView *contentview = self.contentView;
        _img.sd_layout
        .leftSpaceToView(contentview,10)
        .topSpaceToView(contentview,10)
        .widthIs(60.0)
        .heightIs(60.0);
        
        _titleLabel.sd_layout
        .leftSpaceToView(_img,10)
        .topSpaceToView(contentview,10)
        .rightSpaceToView(contentview,20)
        .heightIs(20.0);
        
        _sub1Label.sd_layout
        .leftSpaceToView(_img,10)
        .topSpaceToView(_titleLabel,0)
        .rightSpaceToView(contentview,10)
        .heightIs(20);
        
        _catalogLabel.sd_layout
        .leftSpaceToView(_img,10)
        .topSpaceToView(_sub1Label,0)
        .rightSpaceToView(contentview,120)
        .heightIs(20.0);
        
        _readingLabel.sd_layout
        .rightSpaceToView(contentview,20)
        .topSpaceToView(_sub1Label,0)
        .heightIs(20.0)
        .widthIs(100);
    }
//    NSLog(@"%@",[NSValue valueWithCGRect:self.contentView.bounds]);
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)configCellWith:(BookInfo *)bookInfo {
    [self.img sd_setImageWithURL:[NSURL URLWithString:bookInfo.img] placeholderImage:[UIImage imageNamed:@"book_default"]];
    self.titleLabel.text = bookInfo.title;
    self.sub1Label.text = bookInfo.sub1;
    self.catalogLabel.text = bookInfo.catalog;
    self.readingLabel.text = bookInfo.reading;
    

}

@end

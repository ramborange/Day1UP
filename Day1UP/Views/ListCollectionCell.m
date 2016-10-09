//
//  ListCollectionCell.m
//  Day1UP
//
//  Created by ramborange on 16/9/27.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "ListCollectionCell.h"

@implementation ListCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[YYLabel alloc] initWithFrame:self.bounds];
        self.titleLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:17];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1];
    return self;
}

@end

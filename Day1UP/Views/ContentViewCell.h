//
//  ContentViewCell.h
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewCell : UITableViewCell
@property (nonatomic, strong) TTTAttributedLabel *contentLabel;

@property (nonatomic, copy) NSString *contentString;

@end

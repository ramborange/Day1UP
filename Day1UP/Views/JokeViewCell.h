//
//  JokeViewCell.h
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JokeModel.h"
@interface JokeViewCell : UITableViewCell

@property (nonatomic, strong) TTTAttributedLabel *contentLabel;

@property (nonatomic, strong) JokeModel *jkModel;

@end

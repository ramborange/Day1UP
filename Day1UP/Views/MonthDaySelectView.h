//
//  MonthDaySelectView.h
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^commitSelectedDateBlock)(NSString *dateString);

@interface MonthDaySelectView : UIView

@property (nonatomic, strong) commitSelectedDateBlock dateSelectBlock;

- (void)hideSelf;
- (void)showSelf;

@end

//
//  MonthDaySelectView.m
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "MonthDaySelectView.h"

@interface MonthDaySelectView()

@property (nonatomic, strong) UIDatePicker *picker;
@end

@implementation MonthDaySelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.picker = [[UIDatePicker alloc] init];
        [self.picker setDatePickerMode:UIDatePickerModeDate];
        [self.picker setDate:[NSDate date] animated:YES];
        self.picker.tintColor = [UIColor whiteColor];
        [self addSubview:_picker];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"querry in history" forState:UIControlStateNormal];
        btn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        [btn setTitleColor:[[UIColor blueColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Gillsans" size:20];
        [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn setTitle:@"cancel" forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        cancelBtn.titleLabel.font = [UIFont fontWithName:@"Gillsans" size:20];
        [cancelBtn setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        [cancelBtn jk_addActionHandler:^(NSInteger tag) {
            [self hideSelf];
        }];
        [self addSubview:cancelBtn];
        
        UIView *view = self;
        _picker.sd_layout
        .topSpaceToView(view,0)
        .leftSpaceToView(view,10)
        .rightSpaceToView(view,10)
        .bottomSpaceToView(view,60);
        
        btn.sd_layout
        .topSpaceToView(_picker,10)
        .leftSpaceToView(view,120)
        .rightSpaceToView(view,20)
        .heightIs(40);
        
        cancelBtn.sd_layout
        .topSpaceToView(_picker,10)
        .leftSpaceToView(view,20)
        .rightSpaceToView(btn,10)
        .heightIs(40);
        
    }
    [self.layer setBorderWidth:1.0];
    [self.layer setBorderColor:[[UIColor redColor] colorWithAlphaComponent:0.1].CGColor];
    self.backgroundColor = RGBA(0.96, 0.96, 0.96, 1);
    return self;
}

- (void)btnClicked {
    [self hideSelf];
    if (self.picker.date!=nil) {
        NSDate *date = self.picker.date;
        NSDateFormatter *forma = [[NSDateFormatter alloc] init];
        [forma setDateFormat:@"MM/dd"];
        NSString *retString = [forma stringFromDate:date];
        NSArray *strArray = [retString componentsSeparatedByString:@"/"];

        NSString *checkString;
        if ([strArray[0] hasPrefix:@"0"]) {
            if ([strArray[1] hasPrefix:@"0"]) {
                checkString = [NSString stringWithFormat:@"%@/%@",[strArray[0] substringFromIndex:1],[strArray[1] substringFromIndex:1]];
            }else {
                checkString = [NSString stringWithFormat:@"%@/%@",[strArray[0] substringFromIndex:1],strArray[1]];

            }
        }else {
            if ([strArray[1] hasPrefix:@"0"]) {
                checkString = [NSString stringWithFormat:@"%@/%@",strArray[0],[strArray[1] substringFromIndex:1]];
            }else {
                checkString = [NSString stringWithFormat:@"%@/%@",strArray[0],strArray[1]];
                
            }
        }
        
        self.dateSelectBlock(checkString);
    }
    
}

- (void)hideSelf {
    __weak __typeof(self)weakself = self;
    [UIView animateWithDuration:0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakself.frame = CGRectMake(0, 64-240, screen_width, 240);
    } completion:nil];
}

- (void)showSelf {
    __weak __typeof(self)weakself = self;
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakself.frame = CGRectMake(0, 64, screen_width, 240);
    } completion:nil];
}

@end

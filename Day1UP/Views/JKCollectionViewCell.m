//
//  JKCollectionViewCell.m
//  Day1UP
//
//  Created by ramborange on 16/10/9.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JKCollectionViewCell.h"

@implementation JKCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.questionLabel = [[UILabel alloc] init];
        self.questionLabel.font = [UIFont fontWithName:@"Gillsans" size:17];
        self.questionLabel.textColor = [UIColor darkGrayColor];
        self.questionLabel.numberOfLines = 0;
        [self.contentView addSubview:self.questionLabel];
        
        self.item1Btn = [[UILabel alloc] init];
        self.item1Btn.textColor = [UIColor darkGrayColor];
        self.item1Btn.numberOfLines = 0;
        self.item1Btn.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        [self.contentView addSubview:self.item1Btn];
        
        self.item2Btn = [[UILabel alloc] init];
        self.item2Btn.textColor = [UIColor darkGrayColor];
        self.item2Btn.numberOfLines = 0;
        self.item2Btn.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        [self.contentView addSubview:self.item2Btn];
        
        self.item3Btn = [[UILabel alloc] init];
        self.item3Btn.textColor = [UIColor darkGrayColor];
        self.item3Btn.numberOfLines = 0;
        self.item3Btn.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        [self.contentView addSubview:self.item3Btn];
        
        self.item4Btn = [[UILabel alloc] init];
        self.item4Btn.textColor = [UIColor darkGrayColor];
        self.item4Btn.numberOfLines = 0;
        self.item4Btn.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        [self.contentView addSubview:self.item4Btn];
        
        self.imgView = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.imgView];
        
        self.explainLabel = [[UILabel alloc] init];
        self.explainLabel.font = [UIFont fontWithName:@"Gillsans-Light" size:15];
        self.explainLabel.textColor = [UIColor brownColor];
        self.explainLabel.numberOfLines = 0;
        [self.contentView addSubview:self.explainLabel];
        
        UIView *view = self.contentView;
        self.questionLabel.sd_layout
        .topSpaceToView(view,20)
        .leftSpaceToView(view,20)
        .rightSpaceToView(view,20)
        .autoHeightRatio(0);
        
        self.item1Btn.sd_layout
        .topSpaceToView(_questionLabel,20)
        .leftSpaceToView(view,20)
        .rightSpaceToView(view,20)
        .heightIs(20);
        
        self.item2Btn.sd_layout
        .topSpaceToView(_item1Btn,5)
        .leftSpaceToView(view,20)
        .rightSpaceToView(view,20)
        .heightIs(20);
        
        self.item3Btn.sd_layout
        .topSpaceToView(_item2Btn,5)
        .leftSpaceToView(view,20)
        .rightSpaceToView(view,20)
        .heightIs(20);
        
        self.item4Btn.sd_layout
        .topSpaceToView(_item3Btn,5)
        .leftSpaceToView(view,20)
        .rightSpaceToView(view,20)
        .heightIs(20);
        
        self.imgView.sd_layout
        .topSpaceToView(_item4Btn,20)
        .leftSpaceToView(view,20)
        .widthIs(100)
        .heightIs(100);
        
        self.explainLabel.sd_layout
        .topSpaceToView(_imgView,50)
        .leftSpaceToView(view,20)
        .rightSpaceToView(view,20)
        .heightIs(40);
        self.explainLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        
    }
//    self.backgroundColor = [UIColor jk_randomColor];
    return self;
}


/**
 根据字符串的固定宽度返回自动的高度

 @param w   字符串的固定的宽度
 @param str 字符串
 @return 字符串的高度
 */
- (CGFloat)getHeightWithSizeWidth:(CGFloat)w font:(UIFont *)f string:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:f} context:nil];
    return rect.size.height;
}

- (void)setJkModel:(JKModel *)jkModel {
    CGFloat questionH = [self getHeightWithSizeWidth:screen_width-40 font:[UIFont fontWithName:@"Gillsans" size:17] string:jkModel.question];
    CGFloat item1H = [self getHeightWithSizeWidth:screen_width-40 font:[UIFont fontWithName:@"Gillsans-Light" size:15] string:[NSString stringWithFormat:@"A、%@",jkModel.item1]];
    CGFloat item2H = [self getHeightWithSizeWidth:screen_width-40 font:[UIFont fontWithName:@"Gillsans-Light" size:15] string:[NSString stringWithFormat:@"B、%@",jkModel.item1]];
    CGFloat item3H = [self getHeightWithSizeWidth:screen_width-40 font:[UIFont fontWithName:@"Gillsans-Light" size:15] string:[NSString stringWithFormat:@"C、%@",jkModel.item1]];
    CGFloat item4H = [self getHeightWithSizeWidth:screen_width-40 font:[UIFont fontWithName:@"Gillsans-Light" size:15] string:[NSString stringWithFormat:@"D、%@",jkModel.item1]];
    CGFloat explainH = [self getHeightWithSizeWidth:screen_width-40 font:[UIFont fontWithName:@"Gillsans-Light" size:15] string:jkModel.explains];
    
    _questionLabel.text = [NSString stringWithFormat:@"%@、%@",jkModel.jid,jkModel.question];
    [_item1Btn setText:[NSString stringWithFormat:@"A、%@",jkModel.item1]];
    [_item2Btn setText:[NSString stringWithFormat:@"B、%@",jkModel.item2]];
    if ([jkModel.item1 isEqualToString:@""]) {
        [_item1Btn setText:@"A、正确"];
    }
    if ([jkModel.item2 isEqualToString:@""]) {
        [_item2Btn setText:@"B、错误"];
    }
    
    if (![jkModel.item3 isEqualToString:@""]) {
        [_item3Btn setText:[NSString stringWithFormat:@"C、%@",jkModel.item3]];
    }else {
        [_item3Btn setText:@""];
        item3H = 0.0;
    }
    if (![jkModel.item4 isEqualToString:@""]) {
        [_item4Btn setText:[NSString stringWithFormat:@"D、%@",jkModel.item4]];
    }else {
        [_item4Btn setText:@""];
        item4H = 0.0;
    }
    
    HomeViewController *vc = [(AppDelegate *)[UIApplication sharedApplication].delegate rootViewcontroller];
    UIViewController *jkVc = [vc.navigationController.viewControllers lastObject];
    __weak __typeof(jkVc)weakJkVc = jkVc;
    if (![jkModel.url isEqualToString:@""]) {
        [_imgView sd_setImageWithURL:[NSURL URLWithString:jkModel.url] forState:UIControlStateNormal];
        [_imgView jk_addActionHandler:^(NSInteger tag) {
            MWPhoto *photo = [[MWPhoto alloc] initWithURL:[NSURL URLWithString:jkModel.url]];
            MWPhotoBrowser *pb = [[MWPhotoBrowser alloc] initWithPhotos:@[photo]];
            [weakJkVc.navigationController pushViewController:pb animated:YES];
        }];
    }else {
        [_imgView setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    switch ([jkModel.answer integerValue]) {
        case 1:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_1,jkModel.explains];
            break;
        case 2:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_2,jkModel.explains];
            break;
        case 3:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_3,jkModel.explains];
            break;
        case 4:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_4,jkModel.explains];
            break;
        case 7:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_7,jkModel.explains];
            break;
        case 8:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_8,jkModel.explains];
            break;
        case 9:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_9,jkModel.explains];
            break;
        case 10:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_10,jkModel.explains];
            break;
        case 11:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_11,jkModel.explains];
            break;
        case 12:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_12,jkModel.explains];
            break;
        case 13:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_13,jkModel.explains];
            break;
        case 14:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_14,jkModel.explains];
            break;
        case 15:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_15,jkModel.explains];
            break;
        case 16:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_16,jkModel.explains];
            break;
        case 17:
            _explainLabel.text = [NSString stringWithFormat:@"答案：%@\n%@",jk_answer_17,jkModel.explains];
            break;
        default:
            break;
    }

    _questionLabel.sd_layout
    .heightIs(questionH);
    
    _item1Btn.sd_layout
    .heightIs(item1H+10);
    
    _item2Btn.sd_layout
    .heightIs(item2H+10);
    
    _item3Btn.sd_layout
    .heightIs(item3H+10);
    
    _item4Btn.sd_layout
    .heightIs(item4H+10);
    
    _explainLabel.sd_layout
    .heightIs(explainH+20);
    
}

@end

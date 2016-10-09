//
//  JKCollectionViewCell.h
//  Day1UP
//
//  Created by ramborange on 16/10/9.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKModel.h"
@interface JKCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *questionLabel;

@property (nonatomic, strong) UILabel *item1Btn;
@property (nonatomic, strong) UILabel *item2Btn;
@property (nonatomic, strong) UILabel *item3Btn;
@property (nonatomic, strong) UILabel *item4Btn;

@property (nonatomic, strong) UIButton *imgView;
@property (nonatomic, strong) UILabel *explainLabel;

@property (nonatomic, strong) JKModel *jkModel;

@end

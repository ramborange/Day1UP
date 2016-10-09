//
//  ImgModel.m
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "ImgModel.h"

@implementation ImgModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"UndefinedKey:___%@__",key);
}

@end


//
//  WeixinJX.m
//  Day1UP
//
//  Created by ramborange on 16/10/8.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "WeixinJX.h"

@implementation WeixinJX

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.jid = value;
    }
}

@end

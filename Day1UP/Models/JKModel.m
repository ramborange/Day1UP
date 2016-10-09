//
//  JKModel.m
//  Day1UP
//
//  Created by ramborange on 16/10/9.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "JKModel.h"

@implementation JKModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.jid = value;
    }
}

@end

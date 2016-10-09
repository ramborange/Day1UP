//
//  Photo.m
//  Day1UP
//
//  Created by ramborange on 16/9/29.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.pid = value;
    }
}

@end

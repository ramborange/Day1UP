//
//  BookCatalog.m
//  Day1UP
//
//  Created by ramborange on 16/9/26.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "BookCatalog.h"

@implementation BookCatalog

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    NSLog(@"forUndefinedKey:%@",key);
    if ([key isEqualToString:@"id"]) {
        self.catalogId = value;
    }
}

@end

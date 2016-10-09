//
//  JokeModel.h
//  Day1UP
//
//  Created by ramborange on 16/9/30.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *hashId;
@property (nonatomic, copy) NSString *unixtime;
@property (nonatomic, copy) NSString *updatetime;

@end

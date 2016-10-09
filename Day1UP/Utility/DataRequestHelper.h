//
//  DataRequestHelper.h
//  Day1UP
//
//  Created by ramborange on 16/9/26.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataRequestHelper : NSObject


/**
 request data based on AFN,request type is 'get' and 'post'

 @param requestType     :request type,eg POST or GET
 @param urlString       :requet url
 @param paramDic        :request param needed
 @param successHandler  :succesd
 @param failHandler     :failed
 */
- (void)RequestDataWithMethod:(NSString *)requestType Url:(NSString *)urlString param:(NSDictionary *)paramDic successed:(void(^)(NSDictionary *responseDic))successHandler failed:(void(^)(NSError *error))failHandler;

@end

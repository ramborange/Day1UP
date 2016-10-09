//
//  DataRequestHelper.m
//  Day1UP
//
//  Created by ramborange on 16/9/26.
//  Copyright © 2016年 Rambos. All rights reserved.
//

#import "DataRequestHelper.h"

@implementation DataRequestHelper
- (void)RequestDataWithMethod:(NSString *)requestType Url:(NSString *)urlString param:(NSDictionary *)paramDic successed:(void(^)(NSDictionary *responseDic))successHandler failed:(void(^)(NSError *error))failHandler {
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    if ([requestType isEqualToString:@"GET"]) {
        [manager GET:urlString parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            successHandler(responseDic);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failHandler(error);
        }];
    }else {
        [manager POST:urlString parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            successHandler(responseDic);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failHandler(error);
        }];
    }
}
@end

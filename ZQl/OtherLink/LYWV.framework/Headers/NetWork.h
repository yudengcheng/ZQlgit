//
//  NetWork.h
//  Login
//
//  Created by yudc on 2018/4/10.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWork : NSObject

+ (void)POST:(NSString *)URLString parameters:(NSMutableDictionary *)parameters success:(nullable void (^)(NSURLResponse *respose, id _Nullable responseObject))success failure:(nullable void (^)(NSURLResponse * _Nullable respose , NSError *error))failure;

+ (void)GET:(NSString *)URLString parameters:(NSMutableDictionary *)parameters success:(void (^)(NSURLResponse * _Nonnull, id _Nullable))success failure:(void (^)(NSURLResponse * _Nullable, NSError * _Nonnull))failure;
@end



//
//  LYPlatform.h
//  LYWV
//
//  Created by yudc on 2018/7/18.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYPlatform : NSObject

@property (nonatomic, strong) NSString *Url;

+ (LYPlatform *)defaultPlatform;

- (void) initLYPlatformWith:(NSString *)appid;

@end

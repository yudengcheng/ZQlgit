//
//  LocalData.h
//  ZQl
//
//  Created by yudc on 2018/7/23.
//  Copyright © 2018年 yudc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalData : NSObject

@property (nonatomic, strong) NSMutableArray *Homelist;

@property (nonatomic, strong) NSArray *typelist;

@property (nonatomic, strong) NSMutableArray *userblacklist;

@property (nonatomic, strong) NSArray *userlist;

@property (nonatomic, strong) NSArray *osslist;

+ (LocalData *)defaultPlatform;

- (void)initData;

- (void)saveList;
@end

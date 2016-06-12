//
//  SYServer.h
//  ShowYu
//
//  Created by admin on 16/3/15.
//  Copyright © 2016年 Tangdada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMUser.h"
#import "YYKit.h"
#import "Lockbox.h"

@class RMUpLoadItem;

#define BASE_URL  @"http://graph.cuctv.com/"
/**
 *  用户注册
 */
#define  URL_CREATE_USER  @"http://graph.cuctv.com/oauth2/user_create.json"
/**
 *  用户手机号码快捷注册
 */
#define URL_QUICK_CREATE_USER @"http://graph.cuctv.com/oauth2/user_quick_create.json"



@interface RMServer : NSObject

+(RMServer *)shareInstance;

- (void)setCurrentUser : (NSDictionary *)userDic;
@property (nonatomic, strong) RMUser *user;

/**
 *  新用户普通注册
 */
- (void)createUser:(NSDictionary *)userInfo success:(void (^)(id JSON))success error:(void (^)(NSError *error))error;
/**
 *  新用户快捷注册
 */
- (void)quickCreateUser:(NSDictionary *)userInfo success:(void (^)(id JSON))success error:(void (^)(NSError *error))error;

//
//- (void)uploadImages:(XYUpLoadItem *)item success:(void (^)(id JSON))upLoadSuccess;

@end

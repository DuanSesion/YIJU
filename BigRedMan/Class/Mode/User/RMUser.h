//
//  RMUser.h
//  BigRedMan
//
//  Created by xiong on 16/6/11.
//  Copyright © 2016年 Duanshaoxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMUser : NSObject

@property (nonatomic) NSString *id;

@property (nonatomic) NSString *name;
/**
 * 头像
 */
@property (nonatomic) NSString *imageurl;

@property (nonatomic) NSString *email;

@property (nonatomic) NSString *province;

@property (nonatomic) NSString *city;

@property (nonatomic) NSString *school;

@property (nonatomic) NSString *source;
//点赞
@property (nonatomic) NSString *followCount;
//粉丝
@property (nonatomic) NSString *fansCount;
//直播状态次数
@property (nonatomic) NSString *statusCount;

@property (nonatomic) NSString *favCount;

@property (nonatomic) NSString *videoCount;

@property (nonatomic) NSString *liveCount;

@property (nonatomic) NSString *usercert;

@property (nonatomic) NSString *userCertType;

@property (nonatomic) NSString *introduction;

@property (nonatomic) NSString *gender;

@property (nonatomic) NSString *mobileIsValidate;

@property (nonatomic) NSString *mobile;

@property (nonatomic) NSString *lastSysMessage;

@property (nonatomic) NSString *scrawlCount;

@property (nonatomic) NSString *picCount;

@property (nonatomic) NSString *recType;

@property (nonatomic) NSString *relateUser;

@property (nonatomic) NSString *tags;

@property (nonatomic) NSString *work;

@property (nonatomic) NSString *birthday;

@property (nonatomic) NSString *edu_special;

@property (nonatomic) NSString *paiCount;

@property (nonatomic) NSString *topicCount;

@property (nonatomic) NSString *collegeYear;
//直播状态
@property (nonatomic) NSString *status;

@property (nonatomic) NSString *lastStatus;

@property (nonatomic) NSString *expires_in;

@property (nonatomic) NSString *refresh_token;

@property (nonatomic) NSString *access_token;

@end

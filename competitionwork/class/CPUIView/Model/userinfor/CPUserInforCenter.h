//
//  CPUserInforCenter.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPBaseModeObject.h"

#define KISLOGIN_SUCCESS @"LoginSuccess"

@class CPPeopleInforCenterModel;
@class CPUserInforModel;

@interface CPUserInforCenter : NSObject

@property (nonatomic) BOOL isLoginSuccess;

+(instancetype)sharedInstance;

-(void)loadUserInforData;

-(CPPeopleInforCenterModel*)getPeopleData;

-(CPUserInforModel*)getUsetData;

-(void)setUserData:(CPUserInforModel*)data;

@end


@interface CPPeopleInforCenterModel : CPBaseModeObject<NSCopying,NSCoding>

@property (nonatomic,strong) NSString *is_follow;

@property (nonatomic,strong) NSString *begin_date;
@property (nonatomic,strong) NSString *college_id;
@property (nonatomic,strong) NSString *college_name;
@property (nonatomic,strong) NSString *degree;
@property (nonatomic,strong) NSString *school_id;
@property (nonatomic,strong) NSString *school_name;
@property (nonatomic,strong) NSString *school_type;
@property (nonatomic,strong) NSString *address_city;
@property (nonatomic,strong) NSString *address_province;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *birthday_name;
@property (nonatomic,strong) NSString *fans;
@property (nonatomic,strong) NSString *feeds;
@property (nonatomic,strong) NSString *follow_contests;
@property (nonatomic,strong) NSString *follows;
@property (nonatomic,strong) NSString *gid;
@property (nonatomic,strong) NSString *group_type;
@property (nonatomic,strong) NSString *hometown_city;
@property (nonatomic,strong) NSString *hometown_province;
@property (nonatomic,strong) NSString *journals;
@property (nonatomic,strong) NSString *looks;
@property (nonatomic,strong) NSString *real_name;
@property (nonatomic,strong) NSString *role_id;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *signature;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *username;

@end

@interface CPUserInforModel : CPBaseModeObject<NSCopying,NSCoding>

@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *utoken;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *real_name;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *univs_id;
@property (nonatomic,strong) NSString *univs_name;
@property (nonatomic,strong) NSString *group_type;
@property (nonatomic,strong) NSString *gid;








@end










//
//  CPUserInforCenter.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-4.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPUserInforCenter.h"
#import "CPAPIHelper_userURL.h"
#import "AutoCoding.h"
#import "CPUtil.h"

#define KUSER_DATA @"userInfor"

#define Kis_follow @"is_follow"
#define Kbegin_date @"begin_date"
#define Kcollege_id @"college_id"
#define Kcollege_name @"college_name"
#define Kdegree @"degree"
#define Kschool_id @"school_id"
#define Kschool_name @"school_name"
#define Kschool_type @"school_type"
#define Kaddress_city @"address_city"
#define Kaddress_province @"address_province"
#define Kavatar @"avatar"
#define Kbirthday @"birthday"
#define Kbirthday_name @"birthday_name"
#define Kfans @"fans"
#define Kfeeds @"feeds"
#define Kfollow_contests @"follow_contests"
#define Kfollows @"follows"
#define Kgid @"gid"
#define Kgroup_type @"group_type"
#define Khometown_city @"hometown_city"
#define Khometown_province @"hometown_province"
#define Kjournals @"journals"
#define Klooks @"looks"
#define Kreal_name @"real_name"
#define Krole_id @"role_id"
#define Ksex @"sex"
#define Ksignature @"signature"
#define Kuid @"uid"
#define Kusername @"username"

@interface CPUserInforCenter ()

@property (nonatomic,strong) CPUserInforCenterModel *userCenterModel;

@end

@implementation CPUserInforCenter

+(instancetype)sharedInstance{
    
    static CPUserInforCenter * Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[CPUserInforCenter alloc]init];
    });
    
    return Instance;
}

-(instancetype)init{
    if (self = [super init]) {
        NSString *userPath = [CPUtil pathForDocumentWithFilename:KUSER_DATA];
        self.userCenterModel = (CPUserInforCenterModel*)[NSObject objectWithContentsOfFile:userPath];

    }
    return self;
}

-(void)loadUserInforData{
    
    NSDictionary * params = @{@"user_id":@"400001",
                              @"u_id":@"400001",
                              };
    
    __weak typeof(*&self) weakSelf = self;
    
    [[CPAPIHelper_userURL sharedInstance]api_info_withParams:params whenSuccess:^(id result) {
        DLog(@"userInforResult = %@",result);
        
        [weakSelf.userCenterModel reflectDataFromOtherObject:result];
        [weakSelf.userCenterModel reflectDataFromOtherObject:result[@"univsinfo"]];
        [weakSelf.userCenterModel reflectDataFromOtherObject:result[@"userinfo"]];

        [weakSelf saveTheUserData];
        
    } andFailed:^(id err) {
        
    }];
    
}

-(void)saveTheUserData{
    
    @synchronized(self){
    [self.userCenterModel writeToFile:[CPUtil pathForDocumentWithFilename:KUSER_DATA] atomically:YES];
    }
    
}

-(CPUserInforCenterModel *)userCenterModel{
    
    @synchronized(self){
    if (!_userCenterModel) {
        _userCenterModel = [[CPUserInforCenterModel alloc]init];
    }
    return _userCenterModel;
    }
}



+(void)load{
    
    [[NSUserDefaults standardUserDefaults]objectForKey:KISLOGIN_SUCCESS];
    
}

-(CPUserInforCenterModel *)getUserData{
    
    return self.userCenterModel;
}

@end


@implementation CPUserInforCenterModel
/*
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
*/
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.is_follow forKey:Kis_follow];
    [aCoder encodeObject:self.begin_date forKey:Kbegin_date];
    [aCoder encodeObject:self.college_id forKey:Kcollege_id];
    [aCoder encodeObject:self.college_name forKey:Kcollege_name];
    [aCoder encodeObject:self.degree forKey:Kdegree];
    [aCoder encodeObject:self.school_id forKey:Kschool_id];
    [aCoder encodeObject:self.school_name forKey:Kschool_name];
    [aCoder encodeObject:self.school_type forKey:Kschool_type];
    [aCoder encodeObject:self.address_city forKey:Kaddress_city];
    [aCoder encodeObject:self.address_province forKey:Kaddress_province];
    [aCoder encodeObject:self.avatar forKey:Kavatar];
    [aCoder encodeObject:self.birthday forKey:Kbirthday];
    [aCoder encodeObject:self.birthday_name forKey:Kbirthday_name];
    [aCoder encodeObject:self.fans forKey:Kfans];
    [aCoder encodeObject:self.feeds forKey:Kfeeds];
    [aCoder encodeObject:self.follow_contests forKey:Kfollow_contests];
    [aCoder encodeObject:self.follows forKey:Kfollows];
    [aCoder encodeObject:self.gid forKey:Kgid];
    [aCoder encodeObject:self.group_type forKey:Kgroup_type];
    [aCoder encodeObject:self.hometown_city forKey:Khometown_city];
    [aCoder encodeObject:self.hometown_province forKey:Khometown_province];
    [aCoder encodeObject:self.journals forKey:Kjournals];
    [aCoder encodeObject:self.looks forKey:Klooks];
    [aCoder encodeObject:self.real_name forKey:Kreal_name];
    [aCoder encodeObject:self.role_id forKey:Krole_id];
    [aCoder encodeObject:self.sex forKey:Ksex];
    [aCoder encodeObject:self.signature forKey:Ksignature];
    [aCoder encodeObject:self.uid forKey:Kuid];
    [aCoder encodeObject:self.username forKey:Kusername];

}


-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.is_follow =[aDecoder decodeObjectForKey:Kis_follow];
        self.begin_date = [aDecoder decodeObjectForKey:Kbegin_date];
        self.college_id = [aDecoder decodeObjectForKey:Kcollege_id];
        self.college_name = [aDecoder decodeObjectForKey:Kcollege_name];
        self.degree = [aDecoder decodeObjectForKey:Kdegree];
        self.school_id = [aDecoder decodeObjectForKey:Kschool_id];
        self.school_name = [aDecoder decodeObjectForKey:Kschool_name];
        self.school_type = [aDecoder decodeObjectForKey:Kschool_type];
        self.address_city = [aDecoder decodeObjectForKey:Kaddress_city];
        self.address_province = [aDecoder decodeObjectForKey:Kaddress_province];
        self.avatar = [aDecoder decodeObjectForKey:Kavatar];
        self.birthday = [aDecoder decodeObjectForKey:Kbirthday];
        self.birthday_name = [aDecoder decodeObjectForKey:Kbirthday_name];
        self.fans = [aDecoder decodeObjectForKey:Kfans];
        self.feeds = [aDecoder decodeObjectForKey:Kfeeds];
        self.follow_contests = [aDecoder decodeObjectForKey:Kfollow_contests];
        self.follows = [aDecoder decodeObjectForKey:Kfollows];
        self.gid = [aDecoder decodeObjectForKey:Kgid];
        self.group_type = [aDecoder decodeObjectForKey:Kgroup_type];
        self.hometown_city = [aDecoder decodeObjectForKey:Khometown_city];
        self.hometown_province = [aDecoder decodeObjectForKey:Khometown_province];
        self.journals = [aDecoder decodeObjectForKey:Kjournals];
        self.looks = [aDecoder decodeObjectForKey:Klooks];
        self.real_name = [aDecoder decodeObjectForKey:Kreal_name];
        self.role_id = [aDecoder decodeObjectForKey:Krole_id];
        self.sex = [aDecoder decodeObjectForKey:Ksex];
        self.signature = [aDecoder decodeObjectForKey:Ksignature];
        self.uid = [aDecoder decodeObjectForKey:Kuid];
        self.username = [aDecoder decodeObjectForKey:Kusername];

    }
    return self;
}

@end

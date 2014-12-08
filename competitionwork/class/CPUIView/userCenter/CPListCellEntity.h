//
//  CPListCellEntity.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPListCellEntity : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subTitle;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString   *imageURL;
@property (nonatomic,strong) NSString *age;
@property(nonatomic,strong) NSDictionary *userInfo;
@property(nonatomic,strong) NSString * time;
@property(nonatomic,strong) id dataEntity;
@property(nonatomic,weak) id target;
@property(nonatomic,assign) SEL callBack;


+(instancetype)listCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imgName imageURL:(NSString *)imgurl andTime:(NSString*)time target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo;

+(instancetype)listCellWithTitle:(NSString *)title imageName:(NSString *)imgName target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo;

+(instancetype)listCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imgName target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo;
+(instancetype)listCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imgName imageURL:(NSString *)imgurl target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo;

@end

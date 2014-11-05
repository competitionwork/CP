//
//  CPListCellCommonEntiy.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-2.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPListCellCommonEntiy.h"

@implementation CPListCellCommonEntiy

+(instancetype)listCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imgName imageURL:(NSString *)imgurl andTime:(NSString*)time target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo
{
    CPListCellCommonEntiy *cellEntity = [[CPListCellCommonEntiy alloc] init];
    cellEntity.title = title;
    cellEntity.subTitle = subTitle;
    cellEntity.image = [UIImage imageNamed:imgName];
    cellEntity.imageURL = imgurl;
    cellEntity.time = time;
    cellEntity.target = target;
    cellEntity.callBack = callback;
    cellEntity.userInfo = uinfo;
    return cellEntity;
    
}

+(instancetype)listCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imgName imageURL:(NSString *)imgurl target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo
{
    CPListCellCommonEntiy *cellEntity = [[CPListCellCommonEntiy alloc] init];
    cellEntity.title = title;
    cellEntity.subTitle = subTitle;
    cellEntity.image = [UIImage imageNamed:imgName];
    cellEntity.imageURL = imgurl;
    cellEntity.target = target;
    cellEntity.callBack = callback;
    cellEntity.userInfo = uinfo;
    return cellEntity;
    
}

+(instancetype)listCellWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imgName target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo{
    CPListCellCommonEntiy *cellEntity = [[CPListCellCommonEntiy alloc] init];
    cellEntity.title = title;
    cellEntity.subTitle = subTitle;
    cellEntity.image = [UIImage imageNamed:imgName];
    cellEntity.target = target;
    cellEntity.callBack = callback;
    cellEntity.userInfo = uinfo;
    return cellEntity;
}
+(instancetype)listCellWithTitle:(NSString *)title imageName:(NSString *)imgName target:(id)target callback:(SEL)callback userinfo:(NSDictionary *)uinfo
{
    return [self listCellWithTitle:title subTitle:@"" imageName: imgName target:target callback:callback userinfo:uinfo];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"cell - %@",self.title];
}

@end

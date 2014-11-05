//
//  Global.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-1.
//  Copyright (c) 2014年 hjj. All rights reserved.
//


#define NSStringGetValueSafty(x,y)     x?:y
#define NSStringFromInt(x)      [NSString stringWithFormat:@"%d",x]
#define NSStringFromBool(x)     [NSString stringWithFormat:@"%d",x]
#define NSStringFromFormat(format,str)      [NSString stringWithFormat:format,str]

#define NSDictionaryContainKey(dict,key) [dict.allKeys containsObject:key]


#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width



#define CPHighLightedColor GJColor(229,229,229,1) // 点击态


#define TitleColor [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0]
#define GrayColor [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1.0]
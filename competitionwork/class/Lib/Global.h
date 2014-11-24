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
#define screenHeight [UIScreen mainScreen].bounds.size.height



//颜色

#define CPHighLightedColor GJColor(229,229,229,1) // 点击态


#define TitleColor [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0]
#define GrayColor [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1.0]
#define MainBackColor [UIColor colorWithRed:0xf5/255.0 green:0xf5/255.0 blue:0xf5/255.0 alpha:1.0f]

#define GJColor(r, g, b, al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]






#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"%s %s Line: %d " fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS7 [GJSystemUtil DeviceSystemVersionIsiOS7]






#define privatePhoneKey @"JRDS43!@87wej*&m(98"



//API
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

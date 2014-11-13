//
//  GJCoreTextLabel.h
//  coreText
//
//  赶集图文混排Label
//
//  Created by liyi on 14-4-9.
//  Copyright (c) 2014年 ganji.com. All rights reserved.
//

/*

 调用实例如下：
 
    NSMutableArray *arrayAttr = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:1] forKey:GJCoreTextType];
    [dict setObject:@"fds222222222222fs" forKey:GJCoreTextStr];
    [dict setObject:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] forKey:GJCoreTextFont];
    [dict setObject:[UIColor redColor] forKey:GJCoreTextColor];
    [arrayAttr addObject:dict];

    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:[NSNumber numberWithInt:1] forKey:GJCoreTextType];
    [dict1 setObject:@"你好" forKey:GJCoreTextStr];
    [dict1 setObject:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] forKey:GJCoreTextFont];
    [dict1 setObject:[UIColor redColor] forKey:GJCoreTextColor];

    NSMutableDictionary *dictimage = [NSMutableDictionary dictionary];
    [dictimage setObject:[NSNumber numberWithInt:2] forKey:GJCoreTextType];
    [dictimage setObject:@"taobao.png" forKey:GJCoreTextStr];

    [arrayAttr addObject:dict];
    [arrayAttr addObject:dict1];
    [arrayAttr addObject:dictimage];

    GJCoreTextLabel *la = [[GJCoreTextLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [la setArrayAttr:arrayAttr];
    //  如果需要得到高度和行数，必须执行sizeToFit
    //    [la sizeToFit];
    [self.view addSubview:la];

 */
#import <UIKit/UIKit.h>

#define GJCoreTextColor @"GJCoreTextColor"
#define GJCoreTextFont @"GJCoreTextFont"
// 1 为普通字符串 2 为 图片 3 为网络图片需要下载
#define GJCoreTextType @"GJCoreTextType"
#define GJCoreTextStr @"GJCoreTextStr"
#define GJCoreImageSize @"GJCoreTextImageSize"
@interface GJCoreTextLabel : UILabel

@property (nonatomic,retain) NSMutableArray *arrayAttr;

@property (nonatomic,retain) UIFont *commonFont;

@property (nonatomic,assign) float realHeight;

@property (nonatomic,assign) int lineNum;

@end

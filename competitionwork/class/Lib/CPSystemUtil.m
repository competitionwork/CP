//
//  CPSystemUtil.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-8.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPSystemUtil.h"

@implementation CPSystemUtil


+(void)showAlertViewWithAlertString:(NSString*)content{
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end

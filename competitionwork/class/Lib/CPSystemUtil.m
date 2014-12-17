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


+ (void)showAlertViewWithAlertTitle:(NSString *)title
                            message:(NSString*)message
                           delegate:(id)delegate
                  cancelButtonTitle:(NSString*)cancelButtonTitile
                   otherButtonTitle:(NSString*)otherButtonTitle
                                tag:(NSInteger)tag
{


    NSString *showTitle = title ? : @""; //iOS8适配
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:showTitle message:message delegate:delegate cancelButtonTitle:cancelButtonTitile otherButtonTitles:otherButtonTitle  , nil];
    alertView.tag = tag;
    alertView.delegate = delegate;
    [alertView show];

}

@end

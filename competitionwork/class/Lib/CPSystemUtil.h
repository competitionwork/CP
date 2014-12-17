//
//  CPSystemUtil.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-12-8.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSystemUtil : NSObject

+(void)showAlertViewWithAlertString:(NSString*)content;
+ (void)showAlertViewWithAlertTitle:(NSString *)title
                            message:(NSString*)message
                           delegate:(id)delegate
                  cancelButtonTitle:(NSString*)cancelButtonTitile
                   otherButtonTitle:(NSString*)otherButtonTitle
                                tag:(NSInteger)tag;
@end

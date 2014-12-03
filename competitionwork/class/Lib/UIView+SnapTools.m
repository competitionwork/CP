//
//  UIView+SnapTools.m
//  HouseRent
//
//  Created by Tracy on 13-11-22.
//  Copyright (c) 2013年 ganji.com. All rights reserved.
//

#import "UIView+SnapTools.h"

@implementation UIView (SnapTools)


- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end

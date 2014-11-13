//
//  CPDetailViewItem.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-12.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPDetailViewItem.h"
#import "CPImageScrollView.h"
#import "GJCoreTextLabel.h"
#import "GJListTagView.h"
#import "UIView+Addition.h"

#define GJCoreTextColor @"GJCoreTextColor"
#define GJCoreTextFont @"GJCoreTextFont"
// 1 为普通字符串 2 为 图片 3 为网络图片需要下载
#define GJCoreTextType @"GJCoreTextType"
#define GJCoreTextStr @"GJCoreTextStr"
#define GJCoreImageSize @"GJCoreTextImageSize"

#define InfoColor [UIColor colorWithRed:0x33/255.0 green:0x33/255.0 blue:0x33/255.0 alpha:1.0f]
#define GrayColor [UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1.0f]
#define OrangeColor [UIColor colorWithRed:0xf7/255.0 green:0x7f/255.0 blue:0x00/255.0 alpha:1.0f]
#define GreenColor [UIColor colorWithRed:85/255.0 green:187/255.0 blue:34/255.0 alpha:1.0f]
#define BlackColor [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0f]
#define BIG_IMAGE_HEIGHT  180


@implementation CPDetailViewItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation GJPostDetailHeader1View

- (instancetype)initWithData:(NSDictionary *)dataDict VC:(UIViewController *)vc userWifi:(BOOL)useWifi
{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, 320, 0)]) {
        
        self.backgroundColor = GJColor(255, 255, 255, 1);
        
        float height = 20/2;
        
        if (useWifi) {
            NSArray *imageArray = [((NSString *)[dataDict objectForKey:@"images"]) componentsSeparatedByString:@","];
            int imageCount = [[dataDict objectForKey:@"imagecount"] intValue];
            if ((imageArray && [[imageArray class] isSubclassOfClass:[NSArray class]] && [imageArray count] > 0) || imageCount > 0) {
                
                CPImageScrollView *imagePicker = [[CPImageScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 195) withArray:imageArray];
                imagePicker.target = vc;
                [self addSubview:imagePicker];
                
                height += (0 + 390)/2;
            }
        }
        
        NSString *str = [dataDict objectForKey:@"title"];
        
        
        
        NSMutableArray *arrayAttr = [NSMutableArray array];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:1] forKey:GJCoreTextType];
        [dict setObject:str forKey:GJCoreTextStr];
        [dict setObject:[UIFont boldSystemFontOfSize:16] forKey:GJCoreTextFont];
        [dict setObject:BlackColor forKey:GJCoreTextColor];
        [arrayAttr addObject:dict];
        
        
        
        
        NSDictionary *titleIconDict = [dataDict objectForKey:@"normalIcons"];
        int isShow = [[titleIconDict objectForKey:@"showPage"] intValue];
        NSString *imgUrl = [titleIconDict objectForKey:@"url"];
        if (isShow != 1 && imgUrl.length > 0) {
            NSMutableDictionary *dictimage = [NSMutableDictionary dictionary];
            [dictimage setObject:[NSNumber numberWithInt:3] forKey:GJCoreTextType];
            [dictimage setObject:imgUrl forKey:GJCoreTextStr];
            NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake([[titleIconDict objectForKey:@"width"] floatValue], [[titleIconDict objectForKey:@"height"] floatValue])];
            
            [dictimage setObject:sizeValue forKey:GJCoreImageSize];
            [arrayAttr addObject:dictimage];
        }
        
        GJCoreTextLabel *titleLbl = [[GJCoreTextLabel alloc] initWithFrame:CGRectMake(13, height, 320 - 2*13, 100)];
        [titleLbl setBackgroundColor:[UIColor clearColor]];
        [titleLbl setArrayAttr:arrayAttr];
        //  如果需要得到高度和行数，必须执行sizeToFit
        [titleLbl sizeToFit];
        [self addSubview:titleLbl];
        
        titleLbl.height = titleLbl.realHeight;
        height += titleLbl.height;
        
        
        
        NSArray *labels = [dataDict objectForKey:@"labels"];
        if (labels && [labels count] > 0) {
            
            height += 7;
            
            GJListTagView *labelsView = [[GJListTagView alloc] initWithFrame:CGRectZero];
            
            NSLog(@"%f,%f",self.layer.anchorPoint.x,self.layer.anchorPoint.y);
            
            labelsView.labelsData = labels;
            labelsView.pageType = GJData_Detail;
            labelsView.isFromDetail = YES;
            //            labelsView.top = height + 7; // http://project.apollo.corp.ganji.com/browse/WUXIAN-27796
            labelsView.top = height;
            labelsView.left = 13;
            [self addSubview:labelsView];
            
            
            
            for (NSDictionary *dictlabel in labels) {
                if ([[dictlabel objectForKey:@"showPage"] intValue] != 1 ) {
                    height += 20;
                    break;
                }
            }
            
            
        }
        
        int linenum = titleLbl.lineNum;
        
        if (linenum == 1) {
            height = height -titleLbl.height - 20/2 + 130/2;
        }
        else if(linenum == 2)
        {
            height = height -titleLbl.height  - 20/2 + 170/2;
        }
        else if(linenum == 3)
        {
            height = height -titleLbl.height - 20/2 + 200/2;
        }
        
        
        
        self.frame = CGRectMake(0, 0, 320, height);
        
        
        NSString *timeTitle = [dataDict objectForKey:@"timeTitle"];
        int timeTitleLength = 0;
        if (!timeTitle) {
            timeTitle = @"发布时间";
        }
        if (timeTitle && timeTitle.length > 0) {
            
            UILabel* timeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, height + 13, 200, 12)] ;
            timeTitleLabel.font = [UIFont systemFontOfSize:12];
            timeTitleLabel.textColor = GrayColor;
            timeTitleLabel.text = timeTitle;
            timeTitleLabel.backgroundColor = [UIColor clearColor];
            [timeTitleLabel sizeToFit];
            [self addSubview:timeTitleLabel];
            timeTitleLabel.bottomToSuper = 12;
            
            timeTitleLength = timeTitleLabel.width;
        }
        else
        {
            
            
            // icon发布时间 13*14
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(13, height + 13, 13, 14)];
            icon.image = [UIImage imageNamed:@"icon发布时间.png"];
            [self addSubview:icon];
            icon.bottomToSuper = 12;
            timeTitleLength = icon.width;
        }
        
        
        
        UILabel* postTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(13 + timeTitleLength +7, height + 2 + 13, 200, 12)] ;
        postTimeLbl.font = [UIFont systemFontOfSize:12];
        postTimeLbl.textColor = GrayColor;
        
        
        postTimeLbl.text = [dataDict objectForKey:@"time"];
        
        postTimeLbl.backgroundColor = [UIColor clearColor];
        [postTimeLbl sizeToFit];
        [self addSubview:postTimeLbl];
        postTimeLbl.bottomToSuper = 12;
        
        
        
        UILabel* viewLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, height + 2 + 13, 120, 12)];
        viewLbl.font = [UIFont systemFontOfSize:12];
        viewLbl.textAlignment = UITextAlignmentRight;
        viewLbl.textColor = GrayColor;
        viewLbl.text = [dataDict objectForKey:@"pageviewnum"];
        viewLbl.backgroundColor = [UIColor clearColor];
        [self addSubview:viewLbl];
        [viewLbl sizeToFit];
        viewLbl.rightToSuper =  13;
        viewLbl.bottomToSuper = 12;
        
        
    }
    
    return self;
    
    
    
    
}

@end
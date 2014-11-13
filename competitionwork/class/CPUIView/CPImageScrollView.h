//
//  CPImageScrollView.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-12.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageView : UIView<NSURLConnectionDataDelegate> {
    NSURLConnection *connection;
    NSMutableData *imageData;
    NSURL *imageUrl;
    BOOL isLoading;
    UIImageView *mainImageView;
    BOOL isDefaultImage;
    
    UIView * selectedView;
    
}


@property (nonatomic, readonly) UIImageView *bImageView;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *imageData;
@property (nonatomic, retain) NSURL *imageUrl;
@property (nonatomic, retain) UIImageView *mainImageView;
@property (nonatomic, retain) UIView * selectedView;

- (void)setImageFromImageUrl;
- (void)cancelDownload;

@end


@interface CPImageScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    NSMutableArray *imageViewArray;
    NSArray *theImageArray;
    BOOL isScrollDidS;
    int ContentX;
    int selectIndex;
    UIViewController *target3;
    UIPageControl *pageControl;
    int lastContentX;
    UIImageView *mainImageView;
}
@property (nonatomic, retain) UIScrollView * scrollView;
@property (nonatomic, retain) NSMutableArray * imageViewArray;
@property (nonatomic, retain) NSArray * theImageArray;
@property (nonatomic, assign) UIViewController * target;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UIImageView *mainImageView;

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)imageArray;
@end


@interface GJImageViewFullFrame : UIView<NSURLConnectionDataDelegate>  {
    NSURLConnection *connection;
    NSMutableData *imageData;
    NSURL *imageUrl;
    BOOL isLoading;
    BOOL isDefaultImage;
    UIImageView *mainImageView;
}


@property (nonatomic, readonly) UIImageView *bImageView;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *imageData;
@property (nonatomic, retain) NSURL *imageUrl;
@property (nonatomic, retain) UIImageView *mainImageView;

- (void)setImageFromImageUrl;
- (void)cancelDownload;

@end


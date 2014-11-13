//
//  CPImageScrollView.m
//  competitionwork
//
//  Created by 黄俊杰 on 14-11-12.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import "CPImageScrollView.h"

@implementation ImageView

@synthesize connection;
@synthesize imageData;
@synthesize imageUrl;
@synthesize mainImageView;
@synthesize selectedView;
#define imageWith   126
#define imageHeight 95
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithRed:0xe5/255.0 green:0xe5/255.0 blue:0xe5/255.0 alpha:1.0];
        
        
        
        _bImageView = [[UIImageView alloc]init];
        _bImageView.backgroundColor = [UIColor whiteColor];
        _bImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self addSubview: _bImageView];
        
        
        selectedView = [[UIView alloc] initWithFrame:CGRectMake(1.5, 1.5, self.frame.size.width - 3, self.frame.size.height - 3)];
        
        selectedView.backgroundColor = [UIColor colorWithRed:0xe5/255.0 green:0xe5/255.0 blue:0xe5/255.0 alpha:1.0];
        
        [self addSubview:selectedView];
        
        
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, self.bounds.size.width - 4, self.bounds.size.height - 4)] ;
        self.mainImageView.backgroundColor = [UIColor whiteColor];
        
        isDefaultImage = YES;
        [self setSizeWithImage:[UIImage imageNamed:@"加载占位.png"]];
        [self addSubview:mainImageView];
        
        
    }
    return self;
}
- (void)setImageFromImageUrl {
    // 下载图片
    if (!isLoading && isDefaultImage) {
        isLoading = YES;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:imageUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        self.connection = urlConnection;
    }
}

- (void)cancelDownload
{
    [self.connection cancel];
    self.connection = nil;
    self.imageData = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.imageData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.imageData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    isLoading = NO;
    self.connection = nil;
    self.imageData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    if (!image) {
        image = [[UIImage imageNamed:@"加载失败.png"] copy];
        [self setSizeWithImage:image];
    }
    else {
        isDefaultImage = NO;
        [self setSizeWithImage:image];
    }
    
    // 清理内存
    self.imageData = nil;
    self.connection = nil;
    isLoading = NO;
}

- (void)setSizeWithImage:(UIImage *)image {
    
    mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    mainImageView.frame = CGRectMake(2, 2, self.bounds.size.width - 4, self.bounds.size.height - 4);
    mainImageView.image = image;

}

- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)dealloc {
}

@end

@implementation CPImageScrollView

@synthesize scrollView;
@synthesize theImageArray;
@synthesize target;

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)imageArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.theImageArray = imageArray;
        imageViewArray = [[NSMutableArray alloc] initWithCapacity:17];
        lastContentX=0;
        
        _mainImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        _mainImageView.image=[UIImage imageNamed:@"详情页大图站位.png"];
        [self addSubview:_mainImageView];
        CGFloat y = 0;
        {
            self.backgroundColor = GJColor(237, 237, 237, 1);
        }
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, self.frame.size.height)] ;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        CGFloat width = scrollView.frame.size.width;//scrollView.frame.size.width;
        for (int i = 0; i < [imageArray count]; i ++) {
            GJImageViewFullFrame *imageView=[[GJImageViewFullFrame alloc]initWithFrame:CGRectMake(width*i, 0, width, self.scrollView.frame.size.height)];
            imageView.imageUrl = [NSURL URLWithString:[imageArray objectAtIndex:i]];
            
            [imageView setImageFromImageUrl];
            [scrollView addSubview:imageView];
            //            _mainImageView.hidden=YES;
            [imageViewArray addObject:imageView];
        }
        [scrollView setPagingEnabled:YES];
        scrollView.showsVerticalScrollIndicator = scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(width*[imageArray count], scrollView.frame.size.height);
        scrollView.userInteractionEnabled = YES;
        
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-22, 51, 22)];
        image.image=[UIImage imageNamed:@"页码底色.png"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 51, 22)];
        if ([imageArray count]) {
            label.text = [NSString stringWithFormat:@"%d/%lu",1,(unsigned long)[imageArray count]];
        }
        label.tag=2013;
        label.textColor = [UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        [image addSubview:label];
        [self addSubview:image];

        
    }
    
    return self;
}
- (void)setTarget3:(UIViewController *)target_ {
    if (target3 != target_) {
        target3 = target_;
        // 添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
    }
}

-(void)handleTap:(UITapGestureRecognizer *)sender{
    if ([theImageArray count] == 0)
        return;
    
    CGPoint point = [sender locationInView:self];
    int x = point.x + ContentX;
    for (int i = 0; i < [theImageArray count]; i++) {
        if (x > self.scrollView.frame.size.width  * i && x < self.scrollView.frame.size.width  * (i+1) ) {
            selectIndex = i;
            break;
        }
    }
    ImageView *imv = nil;
    if (selectIndex < [imageViewArray count]) {
        imv = [imageViewArray objectAtIndex:selectIndex];
    }
    if ([imv isKindOfClass:[ImageView class]]) {
        imv.backgroundColor = [UIColor colorWithRed:0x55/255.0 green:0xbb/255.0 blue:0x22/255.0 alpha:1.0f];
        imv.bImageView.frame = CGRectMake(2, 2, self.scrollView.frame.size.width-4, self.scrollView.frame.size.height-4);
        [UIView animateWithDuration:0.75 animations:^{
            imv.backgroundColor = [UIColor colorWithRed:0xe5/255.0 green:0xe5/255.0 blue:0xe5/255.0 alpha:1.0];
        } completion:^(BOOL finished) {
            imv.backgroundColor = [UIColor colorWithRed:0xe5/255.0 green:0xe5/255.0 blue:0xe5/255.0 alpha:1.0];
            imv.bImageView.frame = CGRectMake(1, 1, self.scrollView.frame.size.width-2, self.scrollView.frame.size.height-2);
        }];
    }
    NSMutableArray* imageUrlArray = [[NSMutableArray alloc] initWithArray:theImageArray];
//    ImageScrollPageController *scrollController = [[ImageScrollPageController alloc] initWithImageNames:imageUrlArray page:selectIndex];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:scrollController];
//    nav.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    UILabel *pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
//    pageLabel.tag = 8430;
//    pageLabel.textColor = [UIColor whiteColor];
//    pageLabel.textAlignment = UITextAlignmentCenter;
//    nav.navigationBar.topItem.titleView = pageLabel;
//    nav.navigationBar.topItem.titleView.backgroundColor = [UIColor clearColor];
    

//    nav.navigationBar.topItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"详情" style:0 target:self action:@selector(removeDetailImage)] ;
//    
//    [target presentModalViewController:nav animated:YES];
//    if ([target respondsToSelector:@selector(imagePickerViewDidSelect)]) {
//        [target performSelector:@selector(imagePickerViewDidSelect) withObject:nil];
//    }
    
}
- (void)removeDetailImage {
    if ([target respondsToSelector:@selector(dismissModalViewControllerAnimated:)]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GJHideTableBar" object:nil];
        
        
        [target dismissModalViewControllerAnimated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView_ {
    int _contentX = scrollView_.contentOffset.x;
    if (_contentX >= 0) {
        ContentX = _contentX;
    }
    UILabel *lab=(UILabel*)[self viewWithTag:2013];
    int width = self.frame.size.width;
    if (_contentX%width==0) {
        lab.text=[NSString stringWithFormat:@"%d/%lu",(_contentX / width)+1,(unsigned long)[theImageArray count]];
    }
}
- (void)cancelDownImage {
    for (id item in imageViewArray) {
        if ([item isKindOfClass:[ImageView class]]) {
            [(ImageView *)item cancelDownload];
        }
    }
    [imageViewArray removeAllObjects];
}

- (void)dealloc {
    [self cancelDownImage];
    
}



@end

@implementation GJImageViewFullFrame
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mainImageView = [[UIImageView alloc] initWithFrame:self.bounds] ;
        isDefaultImage = YES;
        //        [self setSizeWithImage:[UIImage imageNamed:@"大图站位.png"]];
        [self addSubview:_mainImageView];
    }
    return self;
}

- (void)setImageFromImageUrl {
    // 下载图片
    if (!isLoading && isDefaultImage) {
        isLoading = YES;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_imageUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        self.connection = urlConnection;
    }
}

- (void)cancelDownload
{
    [self.connection cancel];
    self.connection = nil;
    self.imageData = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.imageData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.imageData = [[NSMutableData alloc] init] ;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    isLoading = NO;
    self.connection = nil;
    self.imageData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [[UIImage alloc] initWithData:_imageData];
    if (!image) {
        image = [[UIImage imageNamed:@"加载失败.png"] copy];
        [self setSizeWithImage:image];
    }
    else {
        isDefaultImage = NO;
        [self setSizeWithImage:image];
    }
    
    // 清理内存
    self.imageData = nil;
    self.connection = nil;
    isLoading = NO;
}

- (void)setSizeWithImage:(UIImage *)image {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    {
        image = [self scale:image toSize:CGSizeMake(width, height)];
    }
    _mainImageView.frame = CGRectMake(0, 0, width, height);
    _mainImageView.center = CGPointMake((self.bounds.size.width )/2, (self.bounds.size.height)/2);
    _mainImageView.image = image;
}
- (UIImage *)scale:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)dealloc {
}
@end

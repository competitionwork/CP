//
//  GJCoreTextLabel.m
//  coreText
//
//  Created by liyi on 14-4-9.
//  Copyright (c) 2014年 Lu Ke. All rights reserved.
//

#import "GJCoreTextLabel.h"
#import <CoreText/CoreText.h>

@interface GJCoreTextLabel()


@property (nonatomic,strong) NSMutableDictionary *imageDict;

/**
 *  记录真实宽度，主要用于一行图文混排
 */
@property (nonatomic,assign) CGFloat realWidth;
@end


static NSString *spaceImageName = @"icon_space.png";
static const NSInteger icon_spaceValue = 8.0;// must equal to the width of image above

@implementation GJCoreTextLabel

@synthesize arrayAttr;
@synthesize commonFont;
@synthesize imageDict;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrayAttr = [NSMutableArray array];
        self.imageDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    [arrayAttr removeAllObjects];
//#if __has_feature(objc_arc)
//    #error GJCoreTextLabel does not support Objective-C Automatic Reference Counting (ARC)
//#endif
}

- (void)setViews {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(context, flipVertical);//将当前context的坐标系进行flip
    NSLog(@"bh=%f",self.bounds.size.height);
    
    
    NSMutableAttributedString *attributedString = [self getAttributeString];
    /*
    UIFont *strFont = [UIFont boldSystemFontOfSize:16.0];
    CTFontRef ctFont =CTFontCreateWithName((CFStringRef)strFont.fontName,
                                           strFont.pointSize,
                                           NULL);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请在这里插入一张图片位置图片位置dasfasfdsafs"];
    [attributedString addAttribute:(__bridge id)kCTFontAttributeName value:(__bridge id)ctFont range:NSMakeRange(0, attributedString.length)];
    
    
    //----
    //为图片设置CTRunDelegate,delegate决定留给图片的空间大小
    NSString *imgName1 = spaceImageName;
    CTRunDelegateCallbacks imageCallbacks1;
    imageCallbacks1.version = kCTRunDelegateVersion1;
    imageCallbacks1.dealloc = GJDelegateDeallocCallback;
    imageCallbacks1.getAscent = GJDelegateGetAscentCallback;
    imageCallbacks1.getDescent = GJDelegateGetDescentCallback;
    imageCallbacks1.getWidth = GJDelegateGetWidthCallback;
    CTRunDelegateRef runDelegate1 = CTRunDelegateCreate(&imageCallbacks1, (__bridge void *)(imgName1));
    NSMutableAttributedString *imageAttributedString1 = [[NSMutableAttributedString alloc] initWithString:@" "];//空格用于给图片留位置
    [imageAttributedString1 addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate1 range:NSMakeRange(0, 1)];
    CFRelease(runDelegate1);
    
    
    [imageAttributedString1 addAttribute:@"imageName" value:imgName1 range:NSMakeRange(0, 1)];
    
    [attributedString insertAttributedString:imageAttributedString1 atIndex:attributedString.length];
    
    //为图片设置CTRunDelegate,delegate决定留给图片的空间大小
    NSString *imgName = @"img.jpg";
    CTRunDelegateCallbacks imageCallbacks;
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.dealloc = GJDelegateDeallocCallback;
    imageCallbacks.getAscent = GJDelegateGetAscentCallback;
    imageCallbacks.getDescent = GJDelegateGetDescentCallback;
    imageCallbacks.getWidth = GJDelegateGetWidthCallback;
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(imgName));
    NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];//空格用于给图片留位置
    [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
    CFRelease(runDelegate);
    
    
    [imageAttributedString addAttribute:@"imageName" value:imgName range:NSMakeRange(0, 1)];
    
    [attributedString insertAttributedString:imageAttributedString atIndex:attributedString.length];
    
    */
    
    
    //换行模式
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    CTParagraphStyleSetting settings[] = {
        lineBreakMode
    };
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    
    
    // build attributes
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(__bridge id)style forKey:(id)kCTParagraphStyleAttributeName ];
    
    // set attributes to attributed string
    [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
    
    
    
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(ctFramesetter, CFRangeMake(0, 0), NULL, CGSizeMake(294, CGFLOAT_MAX), NULL);
    self.realHeight = size.height;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(ctFrame, context);

    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    NSLog(@"line count = %ld",CFArrayGetCount(lines));
    self.lineNum = CFArrayGetCount(lines);
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        NSLog(@"ascent = %f,descent = %f,leading = %f",lineAscent,lineDescent,lineLeading);
        
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        NSLog(@"run count = %ld",CFArrayGetCount(runs));
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            NSLog(@"width = %f",runRect.size.width);
            
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            
            NSString *imageName = [attributes objectForKey:@"imageName"];
            //图片渲染逻辑
            if (imageName) {
                
                NSValue *sizeValue = [attributes objectForKey:@"imgSize"];
                
                if (sizeValue) {
                    
                    UIImage *image = [imageDict objectForKey:imageName];

                    if (image) {
                        CGSize size;
                        [((NSValue *)sizeValue) getValue:&size];
                        CGRect imageDrawRect;
                        imageDrawRect.size = size;
                        imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                        imageDrawRect.origin.y = lineOrigin.y-3;
                        CGContextDrawImage(context, imageDrawRect, image.CGImage);
                    }
                }
                else
                {
                    UIImage *image = [UIImage imageNamed:imageName];
                    if (image) {
                        CGRect imageDrawRect;
                        imageDrawRect.size = image.size;
                        imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                        imageDrawRect.origin.y = lineOrigin.y-3;
                        CGContextDrawImage(context, imageDrawRect, image.CGImage);
                    }
                }
                
            }
        }
    }
    
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFramesetter);
    CFRelease(style);
}

- (CGFloat)getHeightForLabel {
    NSMutableAttributedString *attributedString = [self getAttributeString];
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(ctFramesetter, CFRangeMake(0, 0), NULL, CGSizeMake(294, CGFLOAT_MAX), NULL);
    return size.height;
}

//
+ (CGFloat)heightForLabelWithInfo:(NSArray *)array {
    CGFloat height = 0;
    CGFloat totalWidth = 0;
    for (int i = 0; i < array.count; i ++) {
        NSDictionary *dict = array[i];
        NSInteger type = [dict[GJCoreTextType] integerValue];
        if (1 == type) {
            NSString *title = dict[GJCoreTextStr];
            UIFont *strFont = dict[GJCoreTextFont];
            // TODO  change 294
            CGSize strSize = [title sizeWithFont:strFont constrainedToSize:(CGSize){CGFLOAT_MAX,CGFLOAT_MAX}];
            totalWidth += strSize.width;
        } else if (2 == type || 3 == type) {
            totalWidth += icon_spaceValue;
            NSValue *sizeValue = dict[GJCoreImageSize];
            CGSize imageSize;
            [sizeValue getValue:&imageSize];
            totalWidth += imageSize.width;
        }
    }
    return height;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (IOS7) {
        [self setViews];
        return;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    

    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(context, flipVertical);
    
    NSMutableAttributedString *attributedString = [self getAttributeString];
    
    //换行模式
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByWordWrapping;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    CTParagraphStyleSetting settings[] = {
        lineBreakMode
    };
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    
    
    // build attributes
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(__bridge id)style forKey:(id)kCTParagraphStyleAttributeName ];
    
    // set attributes to attributed string
    [attributedString addAttributes:attributes range:NSMakeRange(0, [attributedString length])];
    
    
    
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    NSLog(@"%f,%f",self.frame.size.width,self.frame.size.height);
    CGRect bounds = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    
    // 如果真实宽度大于frame的宽度，一定是由于一行的文本+图片的宽度大于了frame的宽度，所以，减少frame的宽度，以此让一行变两行
    if (self.realWidth > self.frame.size.width) {
        bounds = CGRectMake(0.0, 0.0, self.frame.size.width - 7, self.frame.size.height);
    }
    
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
    
    CGSize finalSize = [self measureFrame:ctFrame forContext:&context];
    self.realHeight = finalSize.height;
    self.realWidth = finalSize.width;
    
    // 将会把一行的文本+图片变成两行，所以高度，也需要增加成两行的高度
    if (self.realWidth-3 > self.frame.size.width) {
        self.realHeight = self.realHeight * 2;
    }
    
    
    CTFrameDraw(ctFrame, context);
    
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    NSLog(@"line count = %ld",CFArrayGetCount(lines));
    self.lineNum = CFArrayGetCount(lines);
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
//        NSLog(@"ascent = %f,descent = %f,leading = %f",lineAscent,lineDescent,lineLeading);
        
        CFArrayRef runs = CTLineGetGlyphRuns(line);
//        NSLog(@"run count = %ld",CFArrayGetCount(runs));
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
//            NSLog(@"width = %f",runRect.size.width);
            
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            
//            NSLog(@"runrect h :%f w : %f x : %f y : %f",runRect.size.height,runRect.size.width,runRect.origin.x,runRect.origin.y);
            
            NSString *imageName = [attributes objectForKey:@"imageName"];
            //图片渲染逻辑
            if (imageName) {
                
                NSValue *sizeValue = [attributes objectForKey:@"imgSize"];
                
                if (sizeValue) {
                    
                    UIImage *image = [imageDict objectForKey:imageName];
//                    UIImage *image = [UIImage imageNamed:@"新"];
                    if (image) {
                        CGSize size;
                        [((NSValue *)sizeValue) getValue:&size];
                        CGRect imageDrawRect;
                        imageDrawRect.size = size;
                        imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                        imageDrawRect.origin.y = lineOrigin.y-3;
                        CGContextDrawImage(context, imageDrawRect, image.CGImage);
                    }
                }
                else
                {
                    UIImage *image = [UIImage imageNamed:imageName];
                    if (image) {
                        CGRect imageDrawRect;
                        imageDrawRect.size = image.size;
                        imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                        imageDrawRect.origin.y = lineOrigin.y-3;
                        CGContextDrawImage(context, imageDrawRect, image.CGImage);
                    }
                }
                
            }
        }
    }
    
    
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFramesetter);
    CFRelease(style);
    
    
    
     NSLog(@"gjcoretext end drawrect");
    
    [super drawRect:rect];

}

- (NSMutableAttributedString *)getAttributeString
{
    
    
    NSMutableAttributedString *attributedSting = [[NSMutableAttributedString alloc] initWithString:@""];
    
    
    
    for (NSDictionary *dictAttr in self.arrayAttr) {
        
       
        
        int start = attributedSting.mutableString.length;
        
        NSNumber *typeNum =  [dictAttr objectForKey:GJCoreTextType];
        if ([typeNum intValue] == 1) {
            
            NSString *title = [dictAttr objectForKey:GJCoreTextStr];
            UIColor *strColor = [dictAttr objectForKey:GJCoreTextColor];
            UIFont *strFont = [dictAttr objectForKey:GJCoreTextFont];
            
            [attributedSting.mutableString appendString:title];
            
            CTFontRef ctFont =CTFontCreateWithName((CFStringRef)strFont.fontName,
                                                   strFont.pointSize,
                                                   NULL);
            
            [attributedSting addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)strColor.CGColor range:NSMakeRange(start, title.length)];
            // 这里的value中必须传ctfontref，否则iOS5不能自动转化
            [attributedSting addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)ctFont range:NSMakeRange(start, title.length)];
            CFRelease(ctFont);
            
        }
        else if([typeNum intValue] == 2)
        {
            [self addASpaceImageToString:attributedSting];
            start += 1;
            
            NSString *title = [dictAttr objectForKey:GJCoreTextStr];
            //为图片设置CTRunDelegate,delegate决定留给图片的空间大小
            
            CTRunDelegateCallbacks imageCallbacks;
            imageCallbacks.version = kCTRunDelegateVersion1;
            imageCallbacks.dealloc = GJDelegateDeallocCallback;
            imageCallbacks.getAscent = GJDelegateGetAscentCallback;
            imageCallbacks.getDescent = GJDelegateGetDescentCallback;
            imageCallbacks.getWidth = GJDelegateGetWidthCallback;
            CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(title));
            NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];//空格用于给图片留位置
            [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
            CFRelease(runDelegate);
            
            [imageAttributedString addAttribute:@"imageName" value:title range:NSMakeRange(0, 1)];
            [attributedSting insertAttributedString:imageAttributedString atIndex:start];
            
            
            
        }
        else if([typeNum intValue] == 3)
        {
            [self addASpaceImageToString:attributedSting];
            start += 1;
            
            NSString *title = [dictAttr objectForKey:GJCoreTextStr];
            NSValue *sizeValue = [dictAttr objectForKey:GJCoreImageSize];
            CTRunDelegateCallbacks imageCallbacks;
            imageCallbacks.version = kCTRunDelegateVersion1;
            imageCallbacks.dealloc = GJDelegateDeallocCallback;
            imageCallbacks.getAscent = GJDelegateGetAscentCallback;
            imageCallbacks.getDescent = GJDelegateGetDescentCallback;
            imageCallbacks.getWidth = GJDelegateGetWidthCallback;
            CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(sizeValue));
            
            
        
            
            unichar objectReplacementChar = 0xFFFC;
            NSString * objectReplacementString = [NSString stringWithCharacters:&objectReplacementChar length:1];
            
            NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:objectReplacementString];//空格用于给图片留位置
            [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate range:NSMakeRange(0, 1)];
            CFRelease(runDelegate);
            
            [imageAttributedString addAttribute:@"imageName" value:title range:NSMakeRange(0, 1)];
            [imageAttributedString addAttribute:@"imgSize" value:sizeValue range:NSMakeRange(0, 1)];
            [attributedSting insertAttributedString:imageAttributedString atIndex:start];
            
            
//            if (![imageDict objectForKey:title]) {
//                GJImageParamEntity *imageParam = [[GJImageParamEntity alloc] init];
//                imageParam.urlString = title;
//                imageParam.cacheType = GJOnlyDiskCacheExpireButNoNetLoad;
//                [imageParam setSBlock:^(GJImageParamEntity *param,UIImage *imgObj){
//                    [imageDict setObject:imgObj forKey:title];
//                    [self setNeedsDisplay];
//                 
//                }];
//                
//                [imageParam setFBlock:^(GJBaseParamEntity *param,NSError *error)
//                 {
//                     
//                 }];
//                
//                [GJDataManager getObject:imageParam];
//            }
            
            
            
        }
    }
    
    if (self.commonFont) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.commonFont.fontName, self.commonFont.pointSize, NULL);
        [attributedSting addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, [attributedSting length])];
        CFRelease(fontRef);
    }
    

    
    return attributedSting;
}

// 添加一个空白占位 调节各个icon之间的距离
- (void)addASpaceImageToString:(NSMutableAttributedString *)attributedString {
    NSString *imgName1 = spaceImageName;
    CTRunDelegateCallbacks imageCallbacks1;
    imageCallbacks1.version = kCTRunDelegateVersion1;
    imageCallbacks1.dealloc = GJDelegateDeallocCallback;
    imageCallbacks1.getAscent = GJDelegateGetAscentCallback;
    imageCallbacks1.getDescent = GJDelegateGetDescentCallback;
    imageCallbacks1.getWidth = GJDelegateGetWidthCallback;
    CTRunDelegateRef runDelegate1 = CTRunDelegateCreate(&imageCallbacks1, (__bridge void *)(imgName1));
    NSMutableAttributedString *imageAttributedString1 = [[NSMutableAttributedString alloc] initWithString:@" "];//空格用于给图片留位置
    [imageAttributedString1 addAttribute:(NSString *)kCTRunDelegateAttributeName value:(__bridge id)runDelegate1 range:NSMakeRange(0, 1)];
    CFRelease(runDelegate1);
    
    
    [imageAttributedString1 addAttribute:@"imageName" value:imgName1 range:NSMakeRange(0, 1)];
    
    [attributedString insertAttributedString:imageAttributedString1 atIndex:attributedString.length];

}

- (CGSize) measureFrame: (CTFrameRef) frame forContext: (CGContextRef *) cgContext
{
	CGPathRef framePath = CTFrameGetPath(frame);
	CGRect frameRect = CGPathGetBoundingBox(framePath);
    
	CFArrayRef lines = CTFrameGetLines(frame);
	CFIndex numLines = CFArrayGetCount(lines);
    
	CGFloat maxWidth = 0;
	CGFloat textHeight = 0;
    
	// Now run through each line determining the maximum width of all the lines.
	// We special case the last line of text. While we've got it's descent handy,
	// we'll use it to calculate the typographic height of the text as well.
	CFIndex lastLineIndex = numLines - 1;
    
    
	for(CFIndex index = 0; index < numLines; index++)
	{
		CGFloat ascent, descent, leading, width;
		CTLineRef line = (CTLineRef) CFArrayGetValueAtIndex(lines, index);
		width = CTLineGetTypographicBounds(line, &ascent,  &descent, &leading);
        
		if(width > maxWidth)
		{
			maxWidth = width;
		}
        
        // 因为我传入的frame是预定义的，是不准的，所以在算高度的时候把每一行的高度相加所得，而不用下面的算法。
        textHeight += (round(ascent) + round(descent) + round(leading) + 5);

//		if(index == lastLineIndex)
//		{
//			// Get the origin of the last line. We add the descent to this
//			// (below) to get the bottom edge of the last line of text.
//			CGPoint lastLineOrigin;
//			CTFrameGetLineOrigins(frame, CFRangeMake(lastLineIndex, 1), &lastLineOrigin);
//            
//			// The height needed to draw the text is from the bottom of the last line
//			// to the top of the frame.
//			textHeight =  CGRectGetMaxY(frameRect) - lastLineOrigin.y + descent;
//		}
        

	}
    
	// For some text the exact typographic bounds is a fraction of a point too
	// small to fit the text when it is put into a context. We go ahead and round
	// the returned drawing area up to the nearest point.  This takes care of the
	// discrepencies.
	return CGSizeMake(ceil(maxWidth), ceil(textHeight));
}

- (void)sizeToFit
{
    
   [self drawRect:CGRectMake(0, 0, self.frame.size.width, self.realHeight)];
   [self sizeThatFits:CGSizeMake(self.frame.size.width, self.realHeight)];
   
}

- (BOOL)isHaveImage
{
    for (NSMutableDictionary *dict in self.arrayAttr) {
        if ([dict objectForKey:GJCoreImageSize]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark image call back methods

void GJDelegateDeallocCallback( void* refCon ){
    
}

CGFloat GJDelegateGetAscentCallback( void *refCon ){
    NSObject * obj = (__bridge NSObject *)refCon;
    if ([[obj class] isSubclassOfClass:[NSValue class]]) {
        
        CGSize size;
        
        [((NSValue *)obj) getValue:&size];
        
        return size.height;
    }
    else if ([[obj class] isSubclassOfClass:[NSString class]])
    {
        DLog(@"height is %f",[UIImage imageNamed:(NSString *)obj].size.height);
        if ([(NSString *)obj isEqualToString:spaceImageName]) {
            return 20;
        }
        return [UIImage imageNamed:(NSString *)obj].size.height;
    }
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.height;
}

CGFloat GJDelegateGetDescentCallback(void *refCon){
    return 0;
}

CGFloat GJDelegateGetWidthCallback(void *refCon){
    NSObject * obj = (__bridge NSObject *)refCon;
    if ([[obj class] isSubclassOfClass:[NSValue class]]) {
        
        CGSize size;
        
        [((NSValue *)obj) getValue:&size];
        
        return size.width;
    }
    else if ([[obj class] isSubclassOfClass:[NSString class]])
    {
        DLog(@"width is %f",[UIImage imageNamed:(NSString *)obj].size.width);
        if ([(NSString *)obj isEqualToString:spaceImageName]) {
            return icon_spaceValue;
        }
        return [UIImage imageNamed:(NSString *)obj].size.width;
    }
    
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.width;
}
@end

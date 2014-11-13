

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreLocation/CoreLocation.h>

#ifdef TEST
  #define GJNSLog(xx, ...)  NSLog(@"打印: %s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#elif RELEASE
#define GJNSLog(xx, ...)  NSLog(@"打印: %s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
  #define GJNSLog(xx, ...)  ((void)0)
#endif

#define NetWork_Enabled_String @"当前无法访问网络，请稍后重试！"

#define resumeAlertTag 996

@interface GJSystemUtil : NSObject {
}

+ (BOOL)DeviceSystemVersionIsiOS8;
+ (long long)getTempUserid:(NSString*)localID;
+(NSString *)macaddress;
+ (BOOL)connectedToNetwork;
+ (BOOL)isNetworkAvailableFlags:(SCNetworkReachabilityFlags *)outFlags;
+ (void)showAlertViewWithAlertTitle:(NSString*)title alertString:(NSString*)content;
+ (void)showAlertViewWithAlertString:(NSString*)content;

+ (void)showAlertViewWithAlertTitle:(NSString *)title 
                         message:(NSString*)message
                           delegate:(id)delegate
                  cancelButtonTitle:(NSString*)cancelButtonTitile
                   otherButtonTitle:(NSString*)otherButtonTitle
                                tag:(NSInteger)tag;
                        

+ (void)showAlertViewWithAlertString:(NSString*)content tag:(int)tag delegate:(id)delegate;


+ (void)showAutoHideAlertViewWithMessage:(NSString*)message;

+ (void)showAutoHideAlertViewWithMimafroMessage:(NSString*)message;

+ (void)showAutoHideAlertViewWithMessage:(NSString*)message afterDelay:(NSInteger)n;

+ (void)showAlertViewWithAlertStringForQQ:(NSString*)content tag:(int)tag delegate:(id)delegate;

+ (void)hideAlertView:(id)view;

+ (NSString *)GetGUID;
/**zpq for 2.1.0 deviceUID**/
+(NSString *)GetDeviceUID;
/**zpq for 2.1.0 引导页模板**/
+(UIView *)showGuideView:(CGRect)rect;
+(UIView *)showGuideView2:(CGRect)rect;
+(UILabel *)makeLabel:(CGRect)rect font:(int)fontsize stringContent:(NSString*)str bgColor:(UIColor*)color;

+ (NSString*)getPicCacheDirectory;
+ (NSString*)getAdCacheDirectory;
+ (NSString*)getPrivateLetterDirectory;
+ (NSString*)getPureDocumentDirectory;
+ (NSString*)getDocumentDirectory;
+ (NSString*)getDirectoryInDocumentWithName:(NSString*)name;
+ (NSDate*)getFileModifiedTime:(NSString*)path;
+ (BOOL)fileExist:(NSString*)path;
+ (void)deleteFile:(NSString*)path;

+ (NSString*)dateString:(NSDate*)date withFormat:(NSString*)formatString;

+(UIImage *)getImageFromView:(UIView *)view;
+(UIImage*)getImagePingPu:(UIImage*)image;

+ (CLLocationDirection)bearingFromCoordinate:(CLLocation*)first toCoordinate:(CLLocation*)second;


+ (NSString*)getHightQualityImageURLStringForWifiStatus:(NSString*)urlString;
//+ (double)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;

+(void)NSlogFrame:(CGRect)frame;

+ (BOOL)DeviceSystemVersionIsiOS7;
+ (BOOL)DeviceSystemVersionOveriOS6;
+ (BOOL)DeviceSystemVersionIsiOS6;
+ (BOOL)DeviceSystemVersionIsiOS5;

+ (BOOL)isIOS7;

+ (NSArray *)runningProcesses ;
+(BOOL)isCommonProcess:(NSString*)processName;

@end

@interface UIView(UIDrawRounded)
- (void)CGContextFillCircleWithContext:(CGContextRef)contextRef center:(CGPoint)center radius:(CGFloat)radius;
- (void)CGContextAddTopRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius;
- (void)CGContextAddRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius;
- (void)CGContextAddBottomRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius;

- (void)CGContextAddTopLeftRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius;
- (void)CGContextAddTopRightRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius;

- (void)CGContextFillTringleWithContext:(CGContextRef)contextRef rect:(CGRect)rect;
@end


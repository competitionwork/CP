
#import "GJSystemUtil.h"
#import <netinet/in.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#define KALERT @"alert"

@implementation GJSystemUtil


+(long long)getTempUserid:(NSString*)localID
{

    
    
    long long arr[4] = {0,0,0,0};
    for (int i=0; i < [localID length]; i++)
    {
        unichar ch = [localID characterAtIndex:i];
        uint hexInt = (ch >= '0' && ch <= '9') ? ch - '0' : 10 + ch - 97;
        uint no = i % 8;
        arr[i/8] |= hexInt << ((no%2 == 0 ? no + 1: no - 1)*4);
    }
    //    for (int j = 0; j < 4; j++)
    //        arr[j] = arr[j] & 0x7fffffff;
    
    return (2147483648 + (arr[0]+arr[1]+arr[2]+arr[3])/8);
}

+(NSString *)macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ([self DeviceSystemVersionIsiOS7]) {
//        GJNSLog(@"GJUID = %@",[GJUID GJUID]);
//        return [GJUID GJUID];
    }

    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}


+ (NSArray *)runningProcesses {
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        size += size / 10;
        newprocess = realloc(process, size);
        if (!newprocess){
            if (process){
                free(process);
            }
            return nil;
        }
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            if (nprocess){
                NSMutableArray * array = [[NSMutableArray alloc] init];
                for (int i = nprocess - 1; i >= 0; i--){
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil]
                                                                        forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];

                    [array addObject:dict];
                }
                free(process);
                return array ;
            }
        }
    }
    
    return nil;
}
+(BOOL)isCommonProcess:(NSString*)processName{
    
    if([processName isEqualToString:@"system"]){
        return true;
    }
    else if([processName isEqualToString:@"kernel_task"]){
        return YES;
    }
    else if([processName isEqualToString:@"launchd"]){
        return YES;
    }
    else if([processName isEqualToString:@"UserEventAgent"]){
        return YES;
    }
    else if([processName isEqualToString:@"wifid"]){
        return YES;
    }
    else if([processName isEqualToString:@"iaptransportd"]){
        return YES;
    }
    else if([processName isEqualToString:@"backboardd"]){
        return YES;
    }
    else if([processName isEqualToString:@"sharingd"]){
        return YES;
    }
    else if([processName isEqualToString:@"mDNSResponder"]){
        return YES;
    }
    else if([processName isEqualToString:@"SpringBoard"]){
        return YES;
    }
    else if([processName isEqualToString:@"aggregated"]){
        return YES;
    }
    else if([processName isEqualToString:@"syslogd"]){
        return YES;
    }
    else if([processName isEqualToString:@"powerd"]){
        return YES;
    }
    else if([processName isEqualToString:@"lockdownd"]){
        return YES;
    }
    else if([processName isEqualToString:@"locationd"]){
        return YES;
    }
    else if([processName isEqualToString:@"identityservices"]){
        return YES;
    }
    else if([processName isEqualToString:@"configd"]){
        return YES;
    }
    else if([processName isEqualToString:@"imagent"]){
        return YES;
    }
    else if([processName isEqualToString:@"fairplayd.H2"]){
        return YES;
    }
    else if([processName isEqualToString:@"vmd"]){
        return YES;
    }
    else if([processName isEqualToString:@"BTServer"]){
        return YES;
    }
    else if([processName isEqualToString:@"fseventsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"CommCenter"]){
        return YES;
    }
    else if([processName isEqualToString:@"notifyd"]){
        return YES;
    }
    else if([processName isEqualToString:@"distnoted"]){
        return YES;
    }
    else if([processName isEqualToString:@"networkd"]){
        return YES;
    }
    else if([processName isEqualToString:@"apsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"tccd"]){
        return YES;
    }
    else if([processName isEqualToString:@"gamed"]){
        return YES;
    }
    else if([processName isEqualToString:@"dataaccessd"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobileassetd"]){
        return YES;
    }
    else if([processName isEqualToString:@"filecoordination"]){
        return YES;
    }
    else if([processName isEqualToString:@"kbd"]){
        return YES;
    }
    else if([processName isEqualToString:@"CVMServer"]){
        return YES;
    }
    else if([processName isEqualToString:@"EscrowSecurityAl"]){
        return YES;
    }
    else if([processName isEqualToString:@"SCHelper"]){
        return YES;
    }
    else if([processName isEqualToString:@"mediaremoted"]){
        return YES;
    }
    else if([processName isEqualToString:@"itunesstored"]){
        return YES;
    }
    else if([processName isEqualToString:@"DTPower"]){
        return YES;
    }
    else if([processName isEqualToString:@"medialibraryd"]){
        return YES;
    }
    else if([processName isEqualToString:@"mediaserverd"]){
        return YES;
    }
    else if([processName isEqualToString:@"touchsetupd"]){
        return YES;
    }
    else if([processName isEqualToString:@"MobileSMS"]){
        return YES;
    }
    else if([processName isEqualToString:@"keybagd"]){
        return YES;
    }
    else if([processName isEqualToString:@"sandboxd"]){
        return YES;
    }
    else if([processName isEqualToString:@"securityd"]){
        return YES;
    }
    else if([processName isEqualToString:@"lsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"installd"]){
        return YES;
    }
    else if([processName isEqualToString:@"networkd_privile"]){
        return YES;
    }
    else if([processName isEqualToString:@"DuetLST"]){
        return YES;
    }
    else if([processName isEqualToString:@"wirelessproxd"]){
        return YES;
    }
    else if([processName isEqualToString:@"routined"]){
        return YES;
    }
    else if([processName isEqualToString:@"itunescloudd"]){
        return YES;
    }
    else if([processName isEqualToString:@"timed"]){
        return YES;
    }
    else if([processName isEqualToString:@"accountsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"assistantd"]){
        return YES;
    }
    else if([processName isEqualToString:@"geod"]){
        return YES;
    }
    else if([processName isEqualToString:@"voiced"]){
        return YES;
    }
    else if([processName isEqualToString:@"assistant_servic"]){
        return YES;
    }
    else if([processName isEqualToString:@"MobileGestaltHel"]){
        return YES;
    }
    else if([processName isEqualToString:@"ptpd"]){
        return YES;
    }
    else if([processName isEqualToString:@"afcd"]){
        return YES;
    }
    else if([processName isEqualToString:@"notification_pro"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobile_installat"]){
        return YES;
    }
    else if([processName isEqualToString:@"syslog_relay"]){
        return YES;
    }
    else if([processName isEqualToString:@"XcodeDeviceMonit"]){
        return YES;
    }
    else if([processName isEqualToString:@"ubd"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobile_assertion"]){
        return YES;
    }
    else if([processName isEqualToString:@"calaccessd"]){
        return YES;
    }
    else if([processName isEqualToString:@"librariand"]){
        return YES;
    }
    else if([processName isEqualToString:@"deleted"]){
        return YES;
    }
    else if([processName isEqualToString:@"assetsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"aosnotifyd"]){
        return YES;
    }
    else if([processName isEqualToString:@"springboardservi"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobile_house_arr"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobile_house_arr"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobile_house_arr"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobile_house_arr"]){
        return YES;
    }
    else if([processName isEqualToString:@"mobile_house_arr"]){
        return YES;
    }
    else if([processName isEqualToString:@"MobileMail"]){
        return YES;
    }
    else if([processName isEqualToString:@"syncdefaultsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"recentsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"gputoolsd"]){
        return YES;
    }
    else if([processName isEqualToString:@"debugserver"]){
        return YES;
    }
    else if([processName isEqualToString:@"amfid"]){
        return YES;
    }
    else if([processName isEqualToString:@"fairplayd.N78"]){
        return YES;
    }
    else if([processName isEqualToString:@"AppleIDAuthAgent"]){
        return YES;
    }
    else if([processName isEqualToString:@"CommCenterClassi"]){
        return YES;
    }
    else if([processName isEqualToString:@"xpcd"]){
        return YES;
    }
    else if([processName isEqualToString:@"BlueTool"]){
        return YES;
    }
    else if([processName isEqualToString:@"softwareupdatese"]){
        return YES;
    }
    else if([processName isEqualToString:@"lockbot"]){
        return YES;
    }
    else if([processName isEqualToString:@"pasteboardd"]){
        return YES;
    }
    else if([processName isEqualToString:@"AGXCompilerServi"]){
        return YES;
    }
    else if([processName isEqualToString:@"pasteboardd"]){
        return YES;
    }
    else if([processName isEqualToString:@"CloudKeychainPro"]){
        return YES;
    }
    else if([processName isEqualToString:@"IMDPersistenceAg"]){
        return YES;
    }
    else if([processName isEqualToString:@"CMFSyncAgent"]){
        return YES;
    }
    else if([processName isEqualToString:@"nsnetworkd"]){
        return YES;
    }
    else if([processName isEqualToString:@"adid"]){
        return YES;
    }
    else if([processName isEqualToString:@"assistivetouchd"]){
        return YES;
    }
    else if([processName isEqualToString:@"com.apple.Stream"]){
        return YES;
    }
    else if([processName isEqualToString:@"coresymbolicatio"]){
        return YES;
    }
    else if([processName isEqualToString:@"softwarebehavior"]){
        return YES;
    }
    else if([processName isEqualToString:@"limitadtrackingd"]){
        return YES;
    }
    else if([processName isEqualToString:@"biometrickitd"]){
        return YES;
    }
    else if([processName isEqualToString:@"softwareupdated"]){
        return YES;
    }
    else if([processName isEqualToString:@"WirelessCoexMana"]){
        return YES;
    }
    else if([processName isEqualToString:@"storebookkeeperd"]){
        return YES;
    }
    else{
        return NO;
    }
    
}

+ (BOOL)isNetworkAvailableFlags:(SCNetworkReachabilityFlags *)outFlags {
	SCNetworkReachabilityRef	defaultRouteReachability;
	struct sockaddr_in			zeroAddress;
	
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	
	SCNetworkReachabilityFlags flags;
	BOOL gotFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	if (!gotFlags) {
        return NO;
    }
    
	CFRelease(defaultRouteReachability);
    // kSCNetworkReachabilityFlagsReachable indicates that the specified nodename or address can
	// be reached using the current network configuration.
	BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
	
	// This flag indicates that the specified nodename or address can
	// be reached using the current network configuration, but a
	// connection must first be established.
	//
	// If the flag is false, we don't have a connection. But because CFNetwork
    // automatically attempts to bring up a WWAN connection, if the WWAN reachability
    // flag is present, a connection is not required.
	BOOL noConnectionRequired = !(flags & kSCNetworkReachabilityFlagsConnectionRequired);
	if ((flags & kSCNetworkReachabilityFlagsIsWWAN)) {
		noConnectionRequired = YES;
	}
	
	// Callers of this method might want to use the reachability flags, so if an 'out' parameter
	// was passed in, assign the reachability flags to it.
	if (outFlags) {
		*outFlags = flags;
	}
	
	return isReachable && noConnectionRequired;
}

+ (BOOL)connectedToNetwork
{
    // 创建零地址，0.0.0.0地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    // Get connect flags
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    // 如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    // 根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    return (isReachable && !needsConnection) ? YES : NO;
}




+ (NSString *)GetGUID {
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return (__bridge NSString *)string ;
}


+ (NSString *)GetDeviceUID {
//	UIDevice *device = [UIDevice currentDevice];//创建设备对象
//	NSString *deviceUID = [NSString stringWithFormat:@"%@",[device uniqueIdentifier]];
//	return deviceUID;
    return nil;
}

+ (NSString*)getPicCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0]; 
	
	path = [path stringByAppendingFormat:@"/picCache"];
	
	BOOL pathIsDirectory;
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	if (FALSE == [defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] || !pathIsDirectory)
		[defaultManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
	
	return path;
}

+ (NSString*)getAdCacheDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0]; 
	
	path = [path stringByAppendingFormat:@"/picAdvertise"];
	
	BOOL pathIsDirectory;
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	if (FALSE == [defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] || !pathIsDirectory)
		[defaultManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
	
	return path;
}

+ (NSString*)getPrivateLetterDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0]; 
	
	path = [path stringByAppendingFormat:@"/privateLetter"];
	
	BOOL pathIsDirectory;
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	if (FALSE == [defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] || !pathIsDirectory)
		[defaultManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
	
	return path;
}

+ (NSString*)getPureDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0];
    return path;
}

+ (NSString*)getDocumentDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0]; 
	
	path = [path stringByAppendingFormat:@"/1"];
	
	BOOL pathIsDirectory;
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	if (FALSE == [defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] || !pathIsDirectory)
		[defaultManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
	
	return path;
}

+ (NSString*)getDirectoryInDocumentWithName:(NSString*)name
{
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	NSString* docDirectory = [GJSystemUtil getDocumentDirectory];
	NSString* newDirectory = [docDirectory stringByAppendingFormat:@"/%@",name];
	
	BOOL pathIsDirectory;
	if (FALSE == [defaultManager fileExistsAtPath:newDirectory isDirectory:&pathIsDirectory] || !pathIsDirectory)
		[defaultManager createDirectoryAtPath:newDirectory withIntermediateDirectories:NO attributes:nil error:nil];
	
	return newDirectory;
}

+ (NSDate*)getFileModifiedTime:(NSString*)path
{
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	BOOL pathIsDirectory;
	if ([defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] && !pathIsDirectory)
		return [[defaultManager attributesOfItemAtPath:path error:nil] fileModificationDate];
	else
		return [NSDate dateWithTimeIntervalSince1970:0];
}

+ (BOOL)fileExist:(NSString*)path
{
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	BOOL pathIsDirectory;
	if ([defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] && !pathIsDirectory)
		return TRUE;
	
	else
		return  FALSE;

}

+ (void)deleteFile:(NSString*)path
{
	NSFileManager* defaultManager = [NSFileManager defaultManager];
	BOOL pathIsDirectory;
	if ([defaultManager fileExistsAtPath:path isDirectory:&pathIsDirectory] && !pathIsDirectory)
	{
		[defaultManager removeItemAtPath:path error:nil];
	}
}


+ (NSString*)dateString:(NSDate*)date withFormat:(NSString*)formatString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:formatString];
	NSString* timeString = [dateFormatter stringFromDate:date];
	
	return timeString;
}



+(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage*)getImagePingPu:(UIImage*)image{
    UIGraphicsBeginImageContext(CGSizeMake(320, image.size.height));
    [image drawAsPatternInRect:CGRectMake(0, 0, 320, image.size.height)];
    UIImage * bac_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return bac_image;
}

+ (CLLocationDirection)bearingFromCoordinate:(CLLocation*)first toCoordinate:(CLLocation*)second
{
	CGFloat latitude1 = first.coordinate.latitude * M_PI / 180;
	CGFloat latitude2 = second.coordinate.latitude * M_PI / 180;
	
	CGFloat longitudeDifference = (second.coordinate.longitude - first.coordinate.longitude) * M_PI / 180;
	
	CGFloat y = sinf(longitudeDifference) * cosf(latitude2);
	CGFloat x = cosf(latitude1) * sinf(latitude2) - sinf(latitude1)*cosf(latitude2)*cosf(longitudeDifference);
	
	CGFloat possibleAzimuth = atan2f(y, x) * 180 / M_PI;
	
	if( possibleAzimuth < 0 ) return possibleAzimuth + 360.0;
	else return possibleAzimuth;
}

+ (double)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second
{
	float longitudinalDifference = second.longitude - first.longitude;
	float latitudinalDifference = second.latitude - first.latitude;
	float possibleAzimuth = (M_PI * .5f) - atan(latitudinalDifference / longitudinalDifference);
	if (longitudinalDifference > 0) return possibleAzimuth;
	else if (longitudinalDifference < 0) return possibleAzimuth + M_PI;
	else if (latitudinalDifference < 0) return M_PI;
	
	return 0.0f;
	
	
}
+(UILabel *)makeLabel:(CGRect)rect font:(int)fontsize stringContent:(NSString*)str bgColor:(UIColor*)color{
	UILabel *dingyueLabel = [[UILabel alloc] initWithFrame:rect] ;
	
	dingyueLabel.textAlignment = UITextAlignmentCenter;
	dingyueLabel.text = str;
	dingyueLabel.font = [UIFont boldSystemFontOfSize:fontsize];
	dingyueLabel.backgroundColor = color;
    return dingyueLabel;
	
}
+(void)NSlogFrame:(CGRect)frame
{
#ifdef TEST
    NSLog(@"%f,%f,%f,%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
#endif
}

+ (BOOL)DeviceSystemVersionIsiOS8 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return YES;
    }
    return NO;
}

+ (BOOL)DeviceSystemVersionIsiOS7 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return YES;
    }
    return NO;
}
+ (BOOL)DeviceSystemVersionOveriOS6 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 ) {
        return YES;
    }
    return NO;
}
+ (BOOL)DeviceSystemVersionIsiOS6 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        return YES;
    }
    return NO;
}
+ (BOOL)DeviceSystemVersionIsiOS5 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
        return YES;
    }
    return NO;
}
+ (BOOL)isIOS7
{
    return ([[[UIDevice currentDevice] systemVersion] compare:@"7" options:NSNumericSearch] != NSOrderedAscending);
}
@end

@implementation UIView(UIDrawRounded)

- (void)CGContextFillCircleWithContext:(CGContextRef)contextRef center:(CGPoint)center radius:(CGFloat)radius
{
	CGContextBeginPath(contextRef);
	
	CGContextMoveToPoint(contextRef, center.x-radius, center.y);
	
	CGContextAddArcToPoint(contextRef, center.x-radius, center.y-radius, center.x, center.y-radius, radius);
	CGContextAddArcToPoint(contextRef, center.x+radius, center.y-radius, center.x+radius, center.y, radius);
	CGContextAddArcToPoint(contextRef, center.x+radius, center.y+radius, center.x, center.y+radius, radius);
	CGContextAddArcToPoint(contextRef, center.x-radius, center.y+radius, center.x-radius, center.y, radius);
	
	CGContextClosePath(contextRef);
	
	CGContextFillPath(contextRef);
}

- (void)CGContextAddTopLeftRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius
{
	int x_left = rect.origin.x;
	int x_left_center = rect.origin.x + corner_radius;
	//int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_top_center = rect.origin.y + corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top_center);
	
	CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_top);
	
	//CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_bottom);
	CGContextAddLineToPoint(c, x_left, y_bottom);
	CGContextAddLineToPoint(c, x_left, y_top_center);
	
	CGContextClosePath(c);
}

- (void)CGContextAddTopRightRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius
{
	int x_left = rect.origin.x;
	//int x_left_center = rect.origin.x + corner_radius;
	int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_top_center = rect.origin.y + corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top);
	
	//CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);
	CGContextAddLineToPoint(c, x_right_center, y_top);
	
	CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_bottom);
	CGContextAddLineToPoint(c, x_left, y_bottom);
	CGContextAddLineToPoint(c, x_left, y_top_center);
	
	CGContextClosePath(c);
}

- (void)CGContextAddTopRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius
{
	int x_left = rect.origin.x;
	int x_left_center = rect.origin.x + corner_radius;
	int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_top_center = rect.origin.y + corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top_center);
	
	CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);
	CGContextAddLineToPoint(c, x_right_center, y_top);
	
	CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_bottom);
	CGContextAddLineToPoint(c, x_left, y_bottom);
	CGContextAddLineToPoint(c, x_left, y_top_center);
	
	CGContextClosePath(c);
}

- (void)CGContextAddRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius
{
	int x_left = rect.origin.x;
	int x_left_center = rect.origin.x + corner_radius;
	int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_bottom_center = rect.origin.y + rect.size.height - corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	int y_top_center = rect.origin.y + corner_radius;
	
	CGContextBeginPath(c);
	
	CGContextMoveToPoint(c, x_left, y_top_center);
	
	CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, corner_radius);
	CGContextAddLineToPoint(c, x_right_center, y_top);
	
	CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, corner_radius);
	CGContextAddLineToPoint(c, x_right, y_bottom_center);
	
	CGContextAddArcToPoint(c, x_right, y_bottom, x_right_center, y_bottom, corner_radius);
	CGContextAddLineToPoint(c, x_left_center, y_bottom);
	
	CGContextAddArcToPoint(c, x_left, y_bottom, x_left, y_bottom_center, corner_radius);
	CGContextAddLineToPoint(c, x_left, y_top);
	
	CGContextClosePath(c);
}

- (void)CGContextAddBottomRoundedRect:(CGContextRef)c withRect:(CGRect)rect withCornerRadius:(NSInteger)corner_radius
{
	int x_left = rect.origin.x;
	int x_left_center = rect.origin.x + corner_radius;
	int x_right_center = rect.origin.x + rect.size.width - corner_radius;
	int x_right = rect.origin.x + rect.size.width;
	int y_top = rect.origin.y;
	int y_bottom_center = rect.origin.y + rect.size.height - corner_radius;
	int y_bottom = rect.origin.y + rect.size.height;
	
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top);
	CGContextAddLineToPoint(c, x_right, y_top);
	CGContextAddLineToPoint(c, x_right, y_bottom_center);
	
	CGContextAddArcToPoint(c, x_right, y_bottom, x_right_center, y_bottom, corner_radius);
	CGContextAddLineToPoint(c, x_left_center, y_bottom);
	
	CGContextAddArcToPoint(c, x_left, y_bottom, x_left, y_bottom_center, corner_radius);
	CGContextAddLineToPoint(c, x_left, y_top);
	
	CGContextClosePath(c);
}

- (void)CGContextFillTringleWithContext:(CGContextRef)contextRef rect:(CGRect)rect
{
	CGContextBeginPath(contextRef);
	
	CGContextMoveToPoint(contextRef, rect.origin.x, rect.origin.y+rect.size.height/2);
	CGContextAddLineToPoint(contextRef, rect.origin.x+rect.size.width, rect.origin.y);
	CGContextAddLineToPoint(contextRef, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
	CGContextAddLineToPoint(contextRef, rect.origin.x, rect.origin.y+rect.size.height/2);
	
	CGContextClosePath(contextRef);
	
	CGContextFillPath(contextRef);
}
@end
//
//  AppDelegate.h
//  competitionwork
//
//  Created by 黄俊杰 on 14-10-22.
//  Copyright (c) 2014年 hjj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPMastViewController.h"
#import "CPUserInforCenter.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) CPMastViewController * MastVC;

@property (nonatomic,strong) CPUserInforCenter *userInforCenter;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

/*自动消失提示框*/
-(void)showFloatMessge:(NSString*)message;

+ (AppDelegate *)sharedAppDelegate;



@end

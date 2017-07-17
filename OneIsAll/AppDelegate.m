//
//  AppDelegate.m
//  OneIsAll
//
//  Created by dk on 2017/2/22.
//  Copyright © 2017年 董坤. All rights reserved.
//

#import "AppDelegate.h"
#import "TableBarConfigure.h"
#import "HTServerConfig.h"
#import "IQKeyboardManager.h"
#import "HTLBSManager.h"
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()<HTLBSManagerDelegate>
@property(nonatomic ,strong)HTLBSManager * manager ;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setRootController];
    
    HTLBSManager * manger  =   [HTLBSManager startGetLBSWithDelegate:self];
    self.manager = manger;
    return YES;
}
- (void)setRootController{
    UIWindow * window =[[UIWindow alloc] init];
    window.frame = [[UIScreen mainScreen] bounds];
    
    TableBarConfigure *config =[TableBarConfigure new];
    window.rootViewController =config.tabBarController;
    
    [window makeKeyAndVisible];
    self.window = window;
    [HTServerConfig setHTConfigEnv:@"01"];
}
// 配置IQKeyboardManager
- (void)configurationIQKeyboard
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}
#pragma mark - 定位信息
- (void)getLbsSuccessWithLongitude:(NSString *)longitude latitude:(NSString *)latitude{
    
    NSLog(@"经度:%@--纬度:%@",longitude,latitude);
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

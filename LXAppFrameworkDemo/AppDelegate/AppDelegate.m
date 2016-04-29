//
//  AppDelegate.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "AppDelegate.h"
#pragma mark ---引入次文件会自动执行此文件中的load方法，仅一次。会先执行load，再执行appDelegate的代理方法(一些第三方配置，初始化网络请求可以放入)
#import "AppSatrt.h"

#import "LXTabBarController.h"
#import "LXGuidueViewController.h"

@interface AppDelegate ()
@property (nonatomic,strong)LXGuidueViewController *guideVc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    sleep(1.5);
    [self toWhere];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)toWhere{
    if (![LXTools isFirstOpenApp]) {
        [self showGuidueView];
    }else{
        [self showMainView];
    }
}

-(void)showGuidueView{
    
    _guideVc  = [[LXGuidueViewController alloc] init];
    self.window.rootViewController=_guideVc;
    
    [LXTools saveAppVersion];
    
    __weak AppDelegate *weakSelf = self;
    _guideVc.didSelectedEnter = ^() {
      
        [UIView animateWithDuration:1 animations:^{
            weakSelf.guideVc.view.alpha = 0;
        } completion:^(BOOL finished) {
            
            [weakSelf.guideVc.view removeFromSuperview];
            weakSelf.guideVc = nil;
            [weakSelf showMainView];
        }];
    };
    
}

-(void)showMainView{
    LXTabBarController *MainVc= [[LXTabBarController alloc] init];
    self.window.rootViewController=MainVc;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

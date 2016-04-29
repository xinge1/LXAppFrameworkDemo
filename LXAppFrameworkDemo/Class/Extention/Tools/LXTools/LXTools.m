//
//  LXTools.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "LXTools.h"

@implementation LXTools


+(BOOL)isFirstOpenApp{
    BOOL isFirst = NO;
    NSString * versionNumber=[[NSUserDefaults standardUserDefaults] stringForKey:USER_GUIDE_KEY];
    if (!versionNumber || ![versionNumber isEqualToString:AppVersion]) {
        isFirst = NO;
    }else{
        isFirst = YES;
    }
    return isFirst;
}

+(void)saveAppVersion{
    [[NSUserDefaults standardUserDefaults] setObject:AppVersion forKey:USER_GUIDE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)showLoginModule:(UIViewController *)viewController{
    LoginViewController *vc=[[LoginViewController alloc] init];
    vc.pushType=isModel;
    JTNavigationController * navi1 = [[JTNavigationController  alloc]initWithRootViewController:vc];
    navi1.fullScreenPopGestureEnabled=YES;
    [viewController presentViewController:navi1 animated:YES completion:^{
        
    }];
}

@end

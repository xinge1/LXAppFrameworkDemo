//
//  LXTools.h
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXTools : NSObject

/**
 *  是否第一次打开app，版本更新也会返回yes
 *
 *  @return 是，返回YES。
 */
+(BOOL)isFirstOpenApp;

/**
 *  存版本号到本地
 */
+(void)saveAppVersion;

/**
 *  弹出登录模块
 */
+(void)showLoginModule:(UIViewController *)viewController;

@end

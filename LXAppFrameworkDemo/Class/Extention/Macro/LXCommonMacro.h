//
//  LXCommonMacro.h
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//
//  开发中常用的宏
//

#ifndef LXCommonMacro_h
#define LXCommonMacro_h

/**  判断是否显示引导页*/
#define USER_GUIDE_KEY  @"enUseing"

//取版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//手机判断
#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//是否iOS9以上的系统
#define iS_iOS9 ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)

#define iS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

//颜色
#define LXColor(r,g,b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.0]
#define LXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

//屏幕相关
#define myWindow ([UIApplication sharedApplication].keyWindow)
#define windowContent  ([[UIScreen mainScreen] bounds])
#define windowContentHeight  ([[UIScreen mainScreen] bounds].size.height)
#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)

//坐标相关
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height

#define ViewBelow(v)                        (v.frame.size.height + v.frame.origin.y)
#define ViewRight(v)                        (v.frame.size.width + v.frame.origin.x)

//设置字体
#define systemFont(x) [UIFont fontWithName:@"STHeitiSC-Light" size:x]
#define systemBoldFont(x) [UIFont fontWithName:@"HelveticaNeue-Bold" size:x]

//沙盒路径
#define GetHomePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

//打印日志
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)















#endif /* LXCommonMacro_h */

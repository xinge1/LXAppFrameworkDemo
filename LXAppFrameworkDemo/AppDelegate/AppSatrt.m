//
//  AppSatrt.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "AppSatrt.h"


@implementation AppSatrt

/**
 *  在appDelegate中引入此文件后，就会仅执行一次load方法，
 */
+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [[self class] initRequst];
        
        [[self class] initServerPush];//初始化推送，推送获取的消息在AppDelegate.m中获取
        
        [[self class] initUM];//初始化友盟
        
        [[self class] initShare];//初始化分享
        
    });
}


+ (void)initRequst{
    
}

+(void)initServerPush{
    
}

+(void)initUM{
    
}

+(void)initShare{
    
}



@end

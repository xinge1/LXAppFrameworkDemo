//
//  LXSuperStyleViewController.h
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/29.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    isPush,
    isModel
}XCPushType;

@class BackBtn;

@interface LXSuperStyleViewController : UIViewController
{
    XCPushType _pushType;
    
}
@property (nonatomic,assign) XCPushType pushType;
@property (nonatomic,strong)NSString *backTitle;
@property (nonatomic,strong)BackBtn *backBtn;

- (void)close;
@end




@interface BackBtn : UIButton

@property (nonatomic,strong)UIImageView *leftView;
@property (nonatomic,strong)UILabel *titleLab;
@end
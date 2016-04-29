//
//  JTNavigationController.h
//  JTNavigationController
//
//  Created by Tian on 16/1/23.
//  Copyright © 2016年 TianJiaNan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (JTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface JTNavigationController : UINavigationController

/**
 *  次属性没什么屌用，要设置leftItem请去LXSuperStyle中设置（如果是LXSuperStyle的子类），或者直接在control中设置
 */
@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *jt_viewControllers;

@end

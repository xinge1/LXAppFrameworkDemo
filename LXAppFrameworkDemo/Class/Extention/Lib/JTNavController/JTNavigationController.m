//
//  JTNavigationController.m
//  JTNavigationController
//
//  Created by Tian on 16/1/23.
//  Copyright © 2016年 TianJiaNan. All rights reserved.
//

#import "JTNavigationController.h"
#import "UIViewController+JTNavigationExtension.h"



#pragma mark - JTWrapNavigationController

@interface JTWrapNavigationController : UINavigationController

@end

@implementation JTWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    JTNavigationController *jt_navigationController = viewController.jt_navigationController;
    NSInteger index = [jt_navigationController.jt_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:jt_navigationController.viewControllers[index] animated:animated];
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    viewControllerToPresent.jt_navigationController = (JTNavigationController *)self.navigationController;
    viewControllerToPresent.jt_fullScreenPopGestureEnabled = viewControllerToPresent.jt_navigationController.fullScreenPopGestureEnabled;
    if(self.viewControllers.count>0){
        viewControllerToPresent.hidesBottomBarWhenPushed = YES;
    }
    
    
    [self.navigationController presentViewController:[JTWrapViewController wrapViewControllerWithViewController:viewControllerToPresent] animated:flag completion:completion];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.jt_navigationController = (JTNavigationController *)self.navigationController;
    viewController.jt_fullScreenPopGestureEnabled = viewController.jt_navigationController.fullScreenPopGestureEnabled;
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    [self.navigationController pushViewController:[JTWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    self.viewControllers.firstObject.jt_navigationController=nil;
}

@end

#pragma mark - JTWrapViewController

static NSValue *jt_tabBarRectValue;

@implementation JTWrapViewController

+ (JTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    JTWrapNavigationController *wrapNavController = [[JTWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    JTWrapViewController *wrapViewController = [[JTWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !jt_tabBarRectValue) {
        jt_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && jt_tabBarRectValue) {
        self.tabBarController.tabBar.frame = jt_tabBarRectValue.CGRectValue;
    }
    
   
    
}

- (BOOL)jt_fullScreenPopGestureEnabled {
    return [self rootViewController].jt_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    JTWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end

#pragma mark - JTNavigationController

@interface JTNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation JTNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.jt_navigationController = self;
        self.viewControllers = @[[JTWrapViewController wrapViewControllerWithViewController:rootViewController]];
        
//        //修改item.title字体颜色,方法一
//        NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,nil];
//        [rootViewController.navigationController.navigationBar setTitleTextAttributes:attributes];
        
        //title的大小和颜色，方法二
        [rootViewController.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor redColor]}];
        //修改itemleftbtn字体颜色
        [rootViewController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.jt_navigationController = self;
        self.viewControllers = @[[JTWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.jt_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)jt_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (JTWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}

@end

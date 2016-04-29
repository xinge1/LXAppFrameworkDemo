//
//  LXTabBarController.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "LXTabBarController.h"
#import "NTButton.h"

#pragma mark tabbar
#import "HomeViewController.h"
#import "UserViewController.h"
#import "OthersViewController.h"

@interface LXTabBarController ()
{
    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    NTButton * _previousBtn;//记录前一次选中的按钮
}
@end

@implementation LXTabBarController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];

    }
    return self;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != _tabBarView) {//_tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
    }
    
    //_tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, tabBarViewY, 320, 49)];
    //wsq
    _tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:_tabBarView];
    //wsq
    [self.tabBar bringSubviewToFront:_tabBarView];
    [self.tabBar addSubview:_tabBarView];
    
    HomeViewController * first = [[HomeViewController alloc] init];
    JTNavigationController * navi1 = [[JTNavigationController  alloc]initWithRootViewController:first];
    navi1.fullScreenPopGestureEnabled=YES;
   // navi1.jz_fullScreenInteractivePopGestureRecognizer=YES;
   
    
    UserViewController *second = [[UserViewController alloc] init];
    JTNavigationController * navi2 = [[JTNavigationController alloc]initWithRootViewController:second];
    navi2.fullScreenPopGestureEnabled=YES;
//    navi2.jz_fullScreenInteractivePopGestureRecognizer=YES;
    
    
    OthersViewController *third = [[OthersViewController alloc] init];
    UINavigationController * navi3 = [[UINavigationController alloc]initWithRootViewController:third];
    
    self.viewControllers = [NSArray arrayWithObjects:navi1,navi2,navi3,nil];
    
    [self creatButtonWithNormalName:@"首页-默认" andSelectName:@"首页-选择" andTitle:@"随分期" andIndex:0];
    [self creatButtonWithNormalName:@"账户-默认" andSelectName:@"账户-选择" andTitle:@"账户" andIndex:1];
    [self creatButtonWithNormalName:@"帮助-默认" andSelectName:@"帮助-选择" andTitle:@"帮助" andIndex:2];
    

}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    NTButton * customButton = [NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    
    CGFloat buttonW = _tabBarView.frame.size.width / self.viewControllers.count;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    customButton.frame = CGRectMake(buttonW * index, 0, buttonW, buttonH);
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    //    customButton.titleLabel.font = systemFont(15);
    
    
    [self.tabBar addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项） 
    {
        _previousBtn = customButton;
        _previousBtn.selected = YES;
    }
    
    
    
}
#pragma mark 按钮被点击时调用
- (void)changeViewController:(NTButton *)sender
{
    //点击账户时先判断是否登录
        if(self.selectedIndex != sender.tag){
            self.selectedIndex = sender.tag; //切换不同控制器的界面
            _previousBtn.selected = ! _previousBtn.selected;
            _previousBtn = sender;
            _previousBtn.selected = YES;
            
        }

}

#pragma mark 是否隐藏tabBar
-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean{
    
    _tabBarView.hidden=boolean;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

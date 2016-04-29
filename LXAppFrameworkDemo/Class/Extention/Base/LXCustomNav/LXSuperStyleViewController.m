//
//  LXSuperStyleViewController.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/29.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define kDefaultBackImageName @"返回按钮"

#import "LXSuperStyleViewController.h"



@interface LXSuperStyleViewController () <UIGestureRecognizerDelegate>

@end

@implementation LXSuperStyleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //title的大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //navigationBar的color
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    
    
    
    if (_pushType == isModel)
    {
        _backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _backBtn.leftView.image = [UIImage imageNamed:kDefaultBackImageName];
        _backBtn.titleLab.text = self.backTitle;
        [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    }
    else if (_pushType == isPush)
    {
        _backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _backBtn.leftView.image = [UIImage imageNamed:kDefaultBackImageName];
        _backBtn.titleLab.text = self.backTitle;
        [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
        //自定义返回按钮后无法启动系统自带右划返回时设置以下代码
        //self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    
    // [self addGes];
}


- (void)close
{
    if (_pushType == isPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else if (_pushType == isModel)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
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

@implementation BackBtn
@synthesize leftView = _leftView,titleLab = _titleLab;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.frame = frame;
    if (self) {
        _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 18)/2, 10, 18)];
        [self addSubview:_leftView];
        
//        _titleLab = [YXTools allocLabel:@"" font:systemFont(20) textColor:[UIColor orangeColor] frame:CGRectMake(20, 0, self.frame.size.width - 30, self.frame.size.height) textAlignment:0];
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 30, self.frame.size.height)];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.textAlignment=0;
        _titleLab.font= [UIFont systemFontOfSize:16];
        _titleLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLab];
    }
    return self;
}

@end



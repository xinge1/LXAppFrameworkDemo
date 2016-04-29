//
//  RegisterViewController.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/29.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //此页面关闭全局返回
    //self.jt_fullScreenPopGestureEnabled=NO;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"注册";
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 100, 40);
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)registerBtn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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

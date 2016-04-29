//
//  LoginViewController.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"登录";
    self.view.backgroundColor=[UIColor whiteColor];
 //   self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
//    self.fd_UIViewControlViewBackground=[UIColor redColor];
//    self.jz_navigationBarTintColor=[UIColor redColor];
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(100, 100, 100, 40);
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)registerBtn{
    RegisterViewController *registerVc=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
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

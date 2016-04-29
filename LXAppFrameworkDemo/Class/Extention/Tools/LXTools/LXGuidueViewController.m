//
//  LXGuidueViewController.m
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import "LXGuidueViewController.h"

@interface LXGuidueViewController ()

@end

@implementation LXGuidueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPhone4S) {
        _imageArray = [NSArray arrayWithObjects:@"推广员4s",@"0等待4s",nil];
    }else
    {
        _imageArray = [NSArray arrayWithObjects:@"推广员",@"0等待",nil];
    }
    
    [self showUI];
}

- (void)showUI{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.userInteractionEnabled = YES;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 57/2,self.view.frame.size.height-70, 57, 15)];
    _pageControl.backgroundColor=[UIColor clearColor];
    _pageControl.numberOfPages =_imageArray.count;//指定页面个数,最后一页不需要
    _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    //[_pageControl setImagePageStateNormal:[UIImage imageNamed:@"个人身份-性别未选中"]];
    //[_pageControl setImagePageStateHighlighted:[UIImage imageNamed:@"个人身份-性别选中"]];
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    _pageControl.pageIndicatorTintColor=LXColor(200, 200, 200);
    
    [_pageControl addTarget:self action:@selector(guideChangePage)forControlEvents:UIControlEventValueChanged];
    [NSThread sleepForTimeInterval:1];          //添加委托方法，当点击小白点就执行此方法
    [self.view addSubview:_pageControl];
    
    for (int i= 0 ; i < _imageArray.count; i++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height)];
        //更换图片位置
        imgV.image = [UIImage imageNamed:[_imageArray objectAtIndex:i]];
        [_scrollView addSubview:imgV];
        if (i == _imageArray.count-1)
        {
            
            imgV.userInteractionEnabled = YES;
            [self initStartBtnWithView:imgV];
            
        }
    }
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _imageArray.count, self.view.bounds.size.height);
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    
    
}

-(void)initStartBtnWithView:(UIImageView *)bgView{
    
    //虚线边框
    CGFloat viewWidth = 200;
    CGFloat viewHeight = 50;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((windowContentWidth - viewWidth)/2, windowContentHeight-90, viewWidth, viewHeight)];
    if (iPhone4S) {
        view.frame=CGRectMake((windowContentWidth - viewWidth)/2, windowContentHeight-70, viewWidth, viewHeight);
    }
    view.backgroundColor = [UIColor clearColor];
    view.layer.cornerRadius = 5;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, viewWidth, viewHeight);
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    
    //    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    //虚线边框
    borderLayer.lineDashPattern = @[@8, @8];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor redColor].CGColor;
    [view.layer addSublayer:borderLayer];
    [bgView addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake((200-180)/2, (viewHeight-30)/2, 180, 30);
    //[button setBackgroundImage:[UIImage imageNamed:@"立即体验5"] forState:UIControlStateNormal];
    button.backgroundColor=[UIColor redColor];
    button.layer.cornerRadius=5;
    [button setTitle:@"开始体验" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
}





- (void)guideChangePage
{
    NSInteger page = _pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(windowContentWidth * page, 0)];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //DLog(@"滑动距离=%f,%f",[scrollView.panGestureRecognizer translationInView:scrollView.superview].x,scrollView.contentOffset.x);
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //DLog(@"-----%f",scrollView.contentOffset.x);
    CGFloat maxOffsetX=_imageArray.count>2?windowContentWidth:0;
    
    if (scrollView.contentOffset.x>maxOffsetX) {
        _pageControl.hidden=YES;
    }else{
        _pageControl.hidden=NO;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        if (![self hasNext:_pageControl]) {
            [self enter:nil];
        }
        
    }
    
}

#pragma mark - UIScrollView & UIPageControl DataSource

- (BOOL)hasNext:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages > pageControl.currentPage + 1;
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView)
    {
        _pageControl.currentPage=_scrollView.contentOffset.x/windowContentWidth;
        
    }
    
}


- (void)enter:(id)object
{
    self.didSelectedEnter();
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

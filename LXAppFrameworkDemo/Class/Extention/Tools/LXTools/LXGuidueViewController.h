//
//  LXGuidueViewController.h
//  LXAppFrameworkDemo
//
//  Created by 刘鑫 on 16/4/28.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();

@interface LXGuidueViewController : UIViewController<UIScrollViewDelegate>
{
    NSArray *_imageArray;
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
}

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

@end

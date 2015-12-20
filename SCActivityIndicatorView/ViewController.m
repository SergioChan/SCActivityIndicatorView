//
//  ViewController.m
//  SCActivityIndicatorView
//
//  Created by 叔 陈 on 15/12/10.
//  Copyright © 2015年 叔 陈. All rights reserved.
//

#import "ViewController.h"
#import "SCActivityIndicatorView.h"

@interface ViewController ()
@property (nonatomic, strong) SCActivityIndicatorView *indicator_0;
@property (nonatomic, strong) SCActivityIndicatorView *indicator_1;
@property (nonatomic, strong) SCActivityIndicatorView *indicator_2;
@property (nonatomic, strong) SCActivityIndicatorView *indicator_3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indicator_0 = [[SCActivityIndicatorView alloc]initWithOrigin:CGPointMake(ScreenWidth/2.0f - 120.0f, 100.0f) width:60.0f multipleCount:1];
    self.indicator_1 = [[SCActivityIndicatorView alloc]initWithOrigin:CGPointMake(ScreenWidth/2.0f - 120.0f, 180.0f) width:60.0f multipleCount:2];
    self.indicator_2 = [[SCActivityIndicatorView alloc]initWithOrigin:CGPointMake(ScreenWidth/2.0f - 120.0f, 260.0f) width:60.0f multipleCount:3];
    self.indicator_3 = [[SCActivityIndicatorView alloc]initWithOrigin:CGPointMake(ScreenWidth/2.0f - 120.0f, 340.0f) width:60.0f multipleCount:4];
    //self.indicator.hideWhenStopped = YES;
    //self.indicator.customColor = [UIColor redColor];
    //self.indicator.loopDuration = 2.0f;
//    [self.view addSubview:self.indicator_0];
    [self.view addSubview:self.indicator_1];
//    [self.view addSubview:self.indicator_2];
//    [self.view addSubview:self.indicator_3];
}

- (void)fuck
{
    if(self.indicator_0.isAnimating)
    {
        [self.indicator_0 stopAnimating];
    }
    else
    {
        [self.indicator_0 startAnimating];
    }
    if(self.indicator_1.isAnimating)
    {
        [self.indicator_1 stopAnimating];
    }
    else
    {
        [self.indicator_1 startAnimating];
    }
    if(self.indicator_2.isAnimating)
    {
        [self.indicator_2 stopAnimating];
    }
    else
    {
        [self.indicator_2 startAnimating];
    }
    if(self.indicator_3.isAnimating)
    {
        [self.indicator_3 stopAnimating];
    }
    else
    {
        [self.indicator_3 startAnimating];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self fuck];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

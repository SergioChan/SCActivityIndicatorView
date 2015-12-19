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
@property (nonatomic, strong) SCActivityIndicatorView *indicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indicator = [[SCActivityIndicatorView alloc]initWithOrigin:CGPointMake(ScreenWidth/2.0f - 60.0f, ScreenHeight/2.0f - 30.0f) width:60.0f mulipleCount:2.0f];
    //self.indicator.hideWhenStopped = YES;
    //self.indicator.customColor = [UIColor redColor];
    //self.indicator.loopDuration = 2.0f;
    [self.view addSubview:self.indicator];
}

- (void)fuck
{
    if(self.indicator.isAnimating)
    {
        [self.indicator stopAnimating];
    }
    else
    {
        [self.indicator startAnimating];
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

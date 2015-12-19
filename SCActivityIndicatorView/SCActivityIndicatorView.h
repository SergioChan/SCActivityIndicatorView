//
//  SCActivityIndicatorView.h
//  SCActivityIndicatorView
//
//  Created by 叔 陈 on 15/12/10.
//  Copyright © 2015年 叔 陈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFrameGeometry.h"

#define SCColor_1 [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]

@interface SCActivityIndicatorView : UIView

/**
 *  是否在转菊花
 */
@property (nonatomic) BOOL animating;

/**
 *  停止菊花时是否隐藏
 */
@property (nonatomic) BOOL hideWhenStopped;

/**
 *  自定义菊花颜色
 */
@property (nonatomic, strong) UIColor *customColor;

/**
 *  每圈菊花的时长
 */
@property (nonatomic) CGFloat loopDuration;

/**
 *  开始角度，实现多菊花的时候需要用到。
 */
@property (nonatomic) CGFloat startDegree;

/**
 *  菊花中心距离菊花瓣的间隔距离
 */
@property (nonatomic) CGFloat marginRadius;


- (id)initWithOrigin:(CGPoint)origin width:(CGFloat)width;
- (id)initWithOrigin:(CGPoint)origin width:(CGFloat)width multipleCount:(NSInteger)multiplier;
/**
 *  开始或继续动画
 */
- (void)startAnimating;
- (void)stopAnimating;
- (void)removeAnimating;
- (BOOL)isAnimating;
@end

//
//  SCActivityIndicatorView.m
//  SCActivityIndicatorView
//
//  Created by 叔 陈 on 15/12/10.
//  Copyright © 2015年 叔 陈. All rights reserved.
//

#import "SCActivityIndicatorView.h"
#define NUMBER_OF_LOOP 12

@interface SCActivityIndicatorView()
{
    CGFloat _marginRadius;
    CGFloat _indicatorWidth;
    CGFloat _indicatorLength;
    CGFloat _indicatorRadius;
    CGPoint _indicatorCenterPoint;

    NSInteger _multiplier;
}
@end

@implementation SCActivityIndicatorView

- (id)initWithOrigin:(CGPoint)origin width:(CGFloat)width multipleCount:(NSInteger)multiplier
{
    assert(multiplier>0);
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, width * multiplier, width)];
    if(self)
    {
        self.customColor = SCColor_1;
        self.loopDuration = 1.5f * multiplier;
        self.animating = NO;
        self.hideWhenStopped = NO;
        self.alpha = 0.0f;
        self.startDegree = -360.0f;
        _multiplier = multiplier;
        
        _indicatorWidth = width;
        _indicatorCenterPoint = CGPointMake(width/2.0f, width/2.0f);
        _marginRadius = (width/2.0f) / 2.0f;
        _indicatorLength = (width/2.0f) - _marginRadius;
        _indicatorRadius = 1.5f;
    }
    return self;
}

- (id)initWithOrigin:(CGPoint)origin width:(CGFloat)width
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, width)];
    if(self)
    {
        self.customColor = SCColor_1;
        self.loopDuration = 1.5f;
        self.animating = NO;
        self.hideWhenStopped = NO;
        self.alpha = 0.0f;
        self.startDegree = 0.0f;
        _multiplier = 1;
        
        _indicatorWidth = width;
        _indicatorCenterPoint = CGPointMake(width/2.0f, width/2.0f);
        _marginRadius = (width/2.0f) / 2.0f;
        _indicatorLength = (width/2.0f) - _marginRadius;
        _indicatorRadius = 1.5f;
    }
    return self;
}

- (UIImage *)viewFrameImageWithIndex:(NSInteger)index
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.width, self.height), NO, [UIScreen mainScreen].nativeScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat startDegree = self.startDegree;
    BOOL verse = YES;
    
    NSInteger circle_count = 1;
    for(NSInteger i=0;i< NUMBER_OF_LOOP * _multiplier + 1;i++)
    {
        CGPoint currentCenter = CGPointMake(_indicatorWidth/2.0f + (circle_count - 1) * ((_indicatorWidth/2.0f) + _marginRadius), _indicatorWidth/2.0f);
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat cosin = cosf(radians(startDegree));
        CGFloat sin = sinf(radians(startDegree));
        
        CGPoint p0 = CGPointMake(currentCenter.x + cosin * _marginRadius, currentCenter.y + sin * _marginRadius);
        
        CGPoint p1 = CGPointMake(p0.x + _indicatorRadius * sin, p0.y - cosin * _indicatorRadius);
        CGPoint p2 = CGPointMake(p0.x - _indicatorRadius * sin, p0.y + cosin * _indicatorRadius);
        CGPoint p11 = CGPointMake(p1.x + cosin * _indicatorRadius, p1.y + sin * _indicatorRadius);
        CGPoint p21 = CGPointMake(p2.x + cosin * _indicatorRadius, p2.y + sin * _indicatorRadius);
        
        CGPoint q0 = CGPointMake(currentCenter.x + cosin * (_indicatorWidth/2.0f) , currentCenter.y + sin * (_indicatorWidth/2.0f));
        
        CGPoint q1 = CGPointMake(q0.x + _indicatorRadius * sin, q0.y - cosin * _indicatorRadius);
        CGPoint q2 = CGPointMake(q0.x - _indicatorRadius * sin, q0.y + cosin * _indicatorRadius);
        CGPoint q11 = CGPointMake(q1.x - cosin * _indicatorRadius, q1.y - sin * _indicatorRadius);
        CGPoint q21 = CGPointMake(q2.x - cosin * _indicatorRadius, q2.y - sin * _indicatorRadius);
        
        [path moveToPoint:p0];
        [path addQuadCurveToPoint:p11 controlPoint:p1];
        [path addLineToPoint:q11];
        [path addQuadCurveToPoint:q0 controlPoint:q1];
        [path addQuadCurveToPoint:q21 controlPoint:q2];
        [path addLineToPoint:p21];
        [path addQuadCurveToPoint:p0 controlPoint:p2];
        [path closePath];
     
        CGContextAddPath(context, path.CGPath);
        
        
        if(startDegree == 0.0f && verse == YES)
        {
            if(circle_count < _multiplier)
            {
                circle_count += 1;
                startDegree = 180.0f;
                verse = NO;
            }
        }
        else if(startDegree == 0.0f && verse == NO)
        {
            if(circle_count < _multiplier)
            {
                circle_count += 1;
                startDegree = -180.0f;
                verse = YES;
            }
        }
        else if(startDegree == -180.0f && verse == NO)
        {
            if(circle_count == _multiplier)
            {
                circle_count -= 1;
                startDegree = 0.0f;
                verse = YES;
            }
        }
        else if(startDegree == 180.0f && verse == YES)
        {
            if(circle_count > 1)
            {
                circle_count -= 1;
                startDegree = 0.0f;
                verse = NO;
                
            }
        }
        
        if(verse)
        {
            startDegree += 30.0f;
        }
        else
        {
            startDegree -= 30.0f;
        }
        
        UIColor *color = [self fillColorForIndex:index forViewIndex:i];
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)startAnimating
{
    if(self.animating)
    {
        return;
    }
    
    if(self.alpha == 0.0f)
    {
        self.hidden = NO;
        self.animating = YES;
        
        [self.layer addAnimation:[self loopAnimation] forKey:@"contents"];
        
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 1.0f;
        } completion:^(BOOL finished) {
        }];
    }
    else
    {
        // 恢复菊花动画
        self.hidden = NO;
        self.animating = YES;
        
        CFTimeInterval pausedTime = [self.layer timeOffset];
        self.layer.speed = 1.0;
        self.layer.timeOffset = 0.0;
        self.layer.beginTime = 0.0;
        
        CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.layer.beginTime = timeSincePause;
    }
}

- (void)stopAnimating
{
    if(!self.animating)
    {
        return;
    }
    self.animating = NO;
    
    if(self.hideWhenStopped)
    {
        [self.layer removeAnimationForKey:@"contents"];
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
    else
    {
        // 不隐藏所以就暂停动画
        CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.layer.speed = 0.0;
        self.layer.timeOffset = pausedTime;
    }
}

- (void)removeAnimating
{
    self.hideWhenStopped = YES;
    [self stopAnimating];
}

- (BOOL)isAnimating
{
    return self.animating;
}

- (CAKeyframeAnimation *)loopAnimation
{
    NSMutableArray *tmp = [NSMutableArray array];
    for(NSInteger i=0;i<NUMBER_OF_LOOP * _multiplier + 1;i++)
    {
        [tmp addObject:(id)[self viewFrameImageWithIndex:i].CGImage];
    }
    
    CAKeyframeAnimation *loopAnimation;
    loopAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    loopAnimation.values = tmp;
    loopAnimation.duration = self.loopDuration;
    loopAnimation.cumulative = YES;
    loopAnimation.repeatCount = HUGE_VAL;
    loopAnimation.removedOnCompletion= NO;
    loopAnimation.fillMode=kCAFillModeForwards;
    loopAnimation.autoreverses = NO;
    loopAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    loopAnimation.speed = 1.0f;
    loopAnimation.beginTime = 0.0f;
    return loopAnimation;
}

- (UIColor *)fillColorForIndex:(NSInteger)index forViewIndex:(NSInteger)i
{
    UIColor *color = self.customColor;
    int t = abs((int)i-(int)index);
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    if(index <= 3 || index >= NUMBER_OF_LOOP * _multiplier - 3)
    {
        if(t == 1 || t == NUMBER_OF_LOOP * _multiplier - 1)
        {
            color = [UIColor colorWithRed:(components[0]-0.1f) green:(components[1]-0.1f) blue:(components[2]-0.1f) alpha:1.0f];
        }
        else if(t == 2 || t == NUMBER_OF_LOOP * _multiplier - 2)
        {
            color = [UIColor colorWithRed:(components[0]-0.2f) green:(components[1]-0.2f) blue:(components[2]-0.2f) alpha:1.0f];
        }
        else if(i == index)
        {
            color = self.customColor;
        }
        else if((t == 3 || t == NUMBER_OF_LOOP  * _multiplier - 3) || (t == 4 || t == NUMBER_OF_LOOP * _multiplier - 4))
        {
            color = [UIColor colorWithRed:(components[0]-0.5f) green:(components[1]-0.5f) blue:(components[2]-0.5f) alpha:1.0f];
        }
        else
        {
            color = [UIColor clearColor];
        }
    }
    else
    {
        if(t == 1)
        {
            color = [UIColor colorWithRed:(components[0]-0.1f) green:(components[1]-0.1f) blue:(components[2]-0.1f) alpha:1.0f];
        }
        else if(t == 2)
        {
            color = [UIColor colorWithRed:(components[0]-0.2f) green:(components[1]-0.2f) blue:(components[2]-0.2f) alpha:1.0f];
        }
        else if(i == index)
        {
            color = self.customColor;
        }
        else if(t == 3 || t == 4)
        {
            color = [UIColor colorWithRed:(components[0]-0.5f) green:(components[1]-0.5f) blue:(components[2]-0.5f) alpha:1.0f];
        }
        else
        {
            color = [UIColor clearColor];
        }
    }
    return color;
}
@end

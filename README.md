# SCActivityIndicatorView
An indicator view providing you more freedom to control and customize it.  
一个魔性的菊花控件，目前支持横向添加**自定义个数**的菊花。  
单个菊花的时候，和系统的indicatorView效果是一致的，但是提供了更大的自定义空间。  

Something just for fun.  
(´o・┏ω┓・o｀) 求个star。

## 预览 Preview

![image](https://raw.githubusercontent.com/SergioChan/SCActivityIndicatorView/master/preview/preview_a.gif)


## 特别 Special

* 点击屏幕可以暂停动画并且继续动画  
* 通过设置`hideWhenStopped`在停止动画的时候隐藏view

## 用法 Usage

通过初始化方法

```Objective-C
self.indicator = [[SCActivityIndicatorView alloc]initWithOrigin:CGPointMake(ScreenWidth/2.0f - 120.0f, 340.0f) width:60.0f multipleCount:4];
```

初始化指定菊花个数的indicator。并且添加到你需要的view上即可。  
༼´◓ɷ◔`༽  Simple as that！
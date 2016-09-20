//
//  BrightnessView.h
//  BrightnessVolumeView
//
//  Created by Heaven on 16/9/19.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrightnessView : UIView

// 构造方法，frame建议传入 CGZero defaultValue ＝ 0
- (instancetype)initWithFrame:(CGRect)frame defaultValue:(CGFloat)defaultValue;

// 设置frame，传入父控件 主要是针对可能的转屏事件
- (void)setFrame:(CGRect)frame withSuperView:(UIView *)superView;

// 改变数值
- (void)changeBrightnessValue:(CGFloat)brightnessValue;

// 当前项目使用这个，只需要传入SuperView
- (instancetype)initWithSuperView:(UIView *)superView;

@end

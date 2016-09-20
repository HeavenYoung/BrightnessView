//
//  BrightnessVolumeView.h
//  BrightnessVolumeView
//
//  Created by Heaven on 16/9/14.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BrightnessVolumeType){

    TypeBrightness = 0,            // 亮度
    TypeVolume                     // 音量
};

@interface BrightnessVolumeView : UIView

- (instancetype)initWithFrame:(CGRect)frame brightnessVolumeType:(BrightnessVolumeType)brightnessVolumeType defaultPercent:(CGFloat)defaultPercent isFullScreen:(BOOL)isFullScreen;

- (void)changePercentValue:(CGFloat)percentValue;

- (void)changeFrame:(CGRect)frame isFullScreen:(BOOL)isFullScreen;

@end

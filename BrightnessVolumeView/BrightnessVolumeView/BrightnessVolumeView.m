//
//  BrightnessVolumeView.m
//  BrightnessVolumeView
//
//  Created by Heaven on 16/9/14.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "BrightnessVolumeView.h"

@interface BrightnessVolumeView ()

/* 类型 */
@property (nonatomic, assign) BrightnessVolumeType brightnessVolumeType;
/* 百分比 */
@property (nonatomic, assign) CGFloat percentValue;
/* 百分比显示Label */
@property (nonatomic, strong) UILabel *percentLabel;
/* 标志 */
@property (nonatomic, strong) UIImageView *iconView;
/* 固定的进度 */
@property (nonatomic, strong) UIView *standView;
/* 黄色的进度 */
@property (nonatomic, strong) UIView *percentView;
/* 是否全屏，默认为NO */
@property (nonatomic, assign) BOOL isFullScreen;

@end

@implementation BrightnessVolumeView

- (instancetype)initWithFrame:(CGRect)frame brightnessVolumeType:(BrightnessVolumeType)brightnessVolumeType defaultPercent:(CGFloat)defaultPercent isFullScreen:(BOOL)isFullScreen{

    self = [super initWithFrame:frame];
    if (self) {
        
        // 强制给frame
        if (isFullScreen) {
            if (frame.size.width <= 78 || frame.size.height <= 160 || frame.size.width >= 78) {
                self.frame = CGRectMake(frame.origin.x, frame.origin.y, 78, 160);
            }

        } else {
        
            if (frame.size.width <= 75 || frame.size.width >= 75 || frame.size.height <= 90) {
                self.frame = CGRectMake(frame.origin.x, frame.origin.y, 75, 90);
            }
        }
        
        self.brightnessVolumeType = brightnessVolumeType;
        self.percentValue = defaultPercent;
        
        _isFullScreen = isFullScreen;
        
        [self placeSubviewsWithDefaultValue:defaultPercent];
        
    }
    return self;
}

// 初始化的时候根据初始值布局
- (void)placeSubviewsWithDefaultValue:(CGFloat)defaultValue {
    
    // 固定的线
    UIView *standView = [[UIView alloc] init];
    standView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    standView.layer.cornerRadius = 4.0f;
    standView.layer.masksToBounds = YES;
    self.standView = standView;
    
    // 调节线
    UIView *percentView = [[UIView alloc] init];
    percentView.backgroundColor = [UIColor yellowColor];
    percentView.layer.cornerRadius = 4.0f;
    percentView.layer.masksToBounds = YES;
    self.percentView = percentView;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    
    UILabel *percentLabel = [[UILabel alloc] init];
    percentLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    percentLabel.textAlignment = NSTextAlignmentCenter;
    percentLabel.font = [UIFont systemFontOfSize:12];
    NSInteger currentValue = defaultValue *100;
    percentLabel.text = [NSString stringWithFormat:@"%ld%%", currentValue];
    self.percentLabel = percentLabel;
    
    // 如果是调节亮度，线在左边，图标在右边
    if (self.brightnessVolumeType == 0) {
        iconView.image = [UIImage imageNamed:@"icon_brightness"];
        
        // 如果是全屏
        if (_isFullScreen) {
            
            standView.frame = CGRectMake(25, (self.bounds.size.height - 160)/2, 8, 160);
            percentView.frame = CGRectMake(25, (self.bounds.size.height - 160)/2 +160*(1-defaultValue) , 8, 160*defaultValue);
            iconView.frame = CGRectMake(48, (self.bounds.size.height - 30)/2, 30, 30);
            percentLabel.frame = CGRectMake(44, (self.bounds.size.height - 30)/2+30, 38, 30);

        } else {
        
            standView.frame = CGRectMake(18, (self.bounds.size.height - 90)/2, 8, 90);
            percentView.frame = CGRectMake(18, (self.bounds.size.height - 90)/2 +90*(1-defaultValue) , 8, 90*defaultValue);
            iconView.frame = CGRectMake(41, (self.bounds.size.height - 30)/2, 30, 30);
            percentLabel.frame = CGRectMake(37, (self.bounds.size.height - 30)/2+30, 38, 30);
            
        }
    }
    
    // 如果是调节音量，线在右边，图标在左边
    if (self.brightnessVolumeType == 1) {
        if (defaultValue == 0) {
            iconView.image = [UIImage imageNamed:@"icon_volumnOff"];
        } else {
            iconView.image = [UIImage imageNamed:@"icon_volumnOn"];
        }
        
        // 如果是全屏
        if (_isFullScreen) {
            
            iconView.frame = CGRectMake(4, (self.bounds.size.height - 30)/2, 30, 30);
            percentLabel.frame = CGRectMake(0, (self.bounds.size.height - 30)/2+30, 38, 30);

            standView.frame = CGRectMake(49, (self.bounds.size.height - 160)/2, 8, 160);
            percentView.frame = CGRectMake(49, (self.bounds.size.height - 160)/2 +160*(1-defaultValue) , 8, 160*defaultValue);
            
        } else {
            
            iconView.frame = CGRectMake(4, (self.bounds.size.height - 30)/2, 30, 30);
            percentLabel.frame = CGRectMake(0, (self.bounds.size.height - 30)/2+30, 38, 30);
            standView.frame = CGRectMake(49, (self.bounds.size.height - 90)/2, 8, 90);
            percentView.frame = CGRectMake(49, (self.bounds.size.height - 90)/2 +90*(1-defaultValue) , 8, 90*defaultValue);
        }

    }
    
    [self addSubview:standView];
    [self addSubview:percentView];
    [self addSubview:iconView];
    [self addSubview:percentLabel];
}

// 修改百分比
- (void)changePercentValue:(CGFloat)percentValue {

    // 修改
    self.percentValue = percentValue;
    
    NSInteger currentValue = percentValue *100;
    self.percentLabel.text = [NSString stringWithFormat:@"%ld%%", currentValue];
    
    if (self.brightnessVolumeType == TypeBrightness) {
    
        if (_isFullScreen) {
            
            self.percentView.frame = CGRectMake(25, (self.bounds.size.height - 160)/2 +160*(1-percentValue) , 8, 160*percentValue);
            
        } else {
        
            self.percentView.frame = CGRectMake(18, (self.bounds.size.height - 90)/2 +90*(1-percentValue) , 8, 90*percentValue);
        }
        
    } else if (self.brightnessVolumeType == TypeVolume) {
    
        if (percentValue == 0) {
            
            self.iconView.image = [UIImage imageNamed:@"icon_volumnOff"];
        } else {
            
            self.iconView.image = [UIImage imageNamed:@"icon_volumnOn"];
        }

        
        if (_isFullScreen) {
            
            self.percentView.frame = CGRectMake(49, (self.bounds.size.height - 160)/2 +160*(1-percentValue) , 8, 160*percentValue);

        } else {
            
            self.percentView.frame = CGRectMake(49, (self.bounds.size.height - 90)/2 +90*(1-percentValue) , 8, 90*percentValue);

        }
    }
}

// 转屏时候重置Frame
- (void)changeFrame:(CGRect)frame isFullScreen:(BOOL)isFullScreen {

    if (isFullScreen) {
        if (frame.size.width <= 78 || frame.size.height <= 160 || frame.size.width >= 78) {
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, 78, 160);
        }
        
    } else {
        
        if (frame.size.width <= 75 || frame.size.width >= 75 || frame.size.height <= 90) {
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, 75, 90);
        }
    }

    // 如果是调节亮度，线在左边，图标在右边
    if (self.brightnessVolumeType == 0) {
        self.iconView.image = [UIImage imageNamed:@"icon_brightness"];
        
        // 如果是全屏
        if (isFullScreen) {
            
            self.standView.frame = CGRectMake(25, (self.bounds.size.height - 160)/2, 8, 160);
            self.percentView.frame = CGRectMake(25, (self.bounds.size.height - 160)/2 +160*(1-self.percentValue) , 8, 160*self.percentValue);
            self.iconView.frame = CGRectMake(48, (self.bounds.size.height - 30)/2, 30, 30);
            self.percentLabel.frame = CGRectMake(44, (self.bounds.size.height - 30)/2+30, 38, 30);
            
        } else {
            
            self.standView.frame = CGRectMake(18, (self.bounds.size.height - 90)/2, 8, 90);
            self.percentView.frame = CGRectMake(18, (self.bounds.size.height - 90)/2 +90*(1-self.percentValue) , 8, 90*self.percentValue);
            self.iconView.frame = CGRectMake(41, (self.bounds.size.height - 30)/2, 30, 30);
            self.percentLabel.frame = CGRectMake(37, (self.bounds.size.height - 30)/2+30, 38, 30);
            
        }
    }
    
    // 如果是调节音量，线在右边，图标在左边
    if (self.brightnessVolumeType == 1) {
        if (self.percentValue == 0) {
            self.iconView.image = [UIImage imageNamed:@"icon_volumnOff"];
        } else {
            self.iconView.image = [UIImage imageNamed:@"icon_volumnOn"];
        }
        
        // 如果是全屏
        if (isFullScreen) {
            
            self.iconView.frame = CGRectMake(4, (self.bounds.size.height - 30)/2, 30, 30);
            self.percentLabel.frame = CGRectMake(0, (self.bounds.size.height - 30)/2+30, 38, 30);
            
            self.standView.frame = CGRectMake(49, (self.bounds.size.height - 160)/2, 8, 160);
            self.percentView.frame = CGRectMake(49, (self.bounds.size.height - 160)/2 +160*(1-self.percentValue) , 8, 160*self.percentValue);
            
        } else {
            
            self.iconView.frame = CGRectMake(4, (self.bounds.size.height - 30)/2, 30, 30);
            self.percentLabel.frame = CGRectMake(0, (self.bounds.size.height - 30)/2+30, 38, 30);
            self.standView.frame = CGRectMake(49, (self.bounds.size.height - 90)/2, 8, 90);
            self.percentView.frame = CGRectMake(49, (self.bounds.size.height - 90)/2 +90*(1-self.percentValue) , 8, 90*self.percentValue);
        }
        
    }
}

@end

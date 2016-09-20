//
//  BrightnessView.m
//  BrightnessVolumeView
//
//  Created by Heaven on 16/9/19.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "BrightnessView.h"

@interface BrightnessView ()
// 初始值
@property (nonatomic, assign) CGFloat defaultValue;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 图标
@property (nonatomic, strong) UIImageView *iconView;
// 标准线
@property (nonatomic, strong) UIView *standView;
@property (nonatomic, assign) CGFloat standVolume;
@end

@implementation BrightnessView

- (instancetype)initWithFrame:(CGRect)frame defaultValue:(CGFloat)defaultValue {
    self = [super initWithFrame:frame];
    if (self) {
        
        _defaultValue = defaultValue;
        
        self.layer.cornerRadius = 8.0f;
        self.layer.masksToBounds = YES;
        self.frame = CGRectMake(0, 0, 155, 155);
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.45];
        self.standVolume = (float)1.0/16.0;
        
        [self placeSubviews];
        
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView {
    
    self = [super init];
    
    if (self) {
        self.layer.cornerRadius = 8.0f;
        self.layer.masksToBounds = YES;
        self.frame = CGRectMake(0, 0, 155, 155);
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.30];
        self.standVolume = (float)1.0/16.0;
        
        [self placeSubviews];
        [self setFrame:CGRectZero withSuperView:superView];
    }
    return self;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 8.0f;
        self.layer.masksToBounds = YES;
        self.frame = CGRectMake(0, 0, 155, 155);
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.45];
        self.standVolume = (float)1.0/16.0;
        
        [self placeSubviews];
        
    }
    return self;
}

- (void)placeSubviews {
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = self.frame;
    [self addSubview:effectView];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"亮度";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_brightnessios"]];
    iconView.center = self.center;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UIView *standView = [[UIView alloc] init];
    standView.backgroundColor = [UIColor blackColor];
    [self addSubview:standView];
    self.standView = standView;
    
    for (int i = 0; i < 16; ++i) {
        UIView *volumeView = [[UIView alloc] init];
        volumeView.backgroundColor = [UIColor whiteColor];
        volumeView.tag = 1000 +i;
        [self.standView addSubview:volumeView];
    }
}

- (void)setFrame:(CGRect)frame withSuperView:(UIView *)superView {
    
    self.bounds = CGRectMake(0, 0, 155, 155);
    self.center = superView.center;
    
    self.titleLabel.frame = CGRectMake(0, 10, self.bounds.size.width, 20);
    
    self.standView.frame = CGRectMake(13, self.bounds.size.height - 17, self.bounds.size.width -25, 7);
    
    CGFloat volumeWidth = (self.bounds.size.width -25 - 17)/16;
    
    // 代码逻辑，在这里才能对外取得Frame所以在这里设置音量view的frame
    for (int i = 0; i < 16; ++i) {
        UIView *volumeView = [self viewWithTag:1000+i];
        volumeView.frame = CGRectMake(1 +(volumeWidth +1) *i , 1, volumeWidth, 5);
    }
}

- (void)changeBrightnessValue:(CGFloat)brightnessValue {
    
    if (brightnessValue <0 || brightnessValue >1) {
        return;
    }
    
    // 现隐藏所有音量
    for (int i = 0; i < 16; ++i) {
        UIView *volumeView = [self viewWithTag:1000+i];
        volumeView.hidden = YES;
    }
    
    NSInteger count = brightnessValue/self.standVolume;
    
    for (int j = 0; j < count; ++j) {
        UIView *volumeView = [self viewWithTag:1000 +j];
        volumeView.hidden = NO;
        
    }
    
}

@end

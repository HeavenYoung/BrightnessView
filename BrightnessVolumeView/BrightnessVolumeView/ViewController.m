//
//  ViewController.m
//  BrightnessVolumeView
//
//  Created by Heaven on 16/9/14.
//  Copyright © 2016年 Heaven. All rights reserved.
//

#import "ViewController.h"
#import "BrightnessVolumeView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "BrightnessView.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger firstPointY;
@property (nonatomic, assign) NSInteger lastPointY;
@property (nonatomic, strong) BrightnessVolumeView *volumeView;
@property (nonatomic, strong) BrightnessView *brightnessView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", [UIFont familyNames]);

    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    
    BrightnessView *brightnessView = [[BrightnessView alloc] initWithFrame:CGRectMake(0, 0, 155, 155) defaultValue:1];
    [brightnessView setFrame:CGRectZero withSuperView:self.view];
    [self.view addSubview:brightnessView];
    self.brightnessView = brightnessView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    
    CGPoint point = [touch locationInView:touch.view];
    
    self.firstPointY = point.y;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    
    CGPoint point = [touch locationInView:touch.view];
    
    self.lastPointY = point.y;
    
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
    
    float currentVolum = musicPlayer.volume;
    
    float changeVolume = -(float)(self.lastPointY - self.firstPointY)/500;
    
    float volume = currentVolum + changeVolume;
    
//    NSLog(@"%.02f", volume);
    [self.brightnessView changeBrightnessValue:volume];
    [self.volumeView changePercentValue:volume];
    
    [musicPlayer setVolume:volume];
    
    //    [[UIScreen mainScreen] setBrightness:volume];
    
    self.firstPointY = point.y;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

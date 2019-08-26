//
//  ViewController.m
//  DZMTimer
//
//  Created by dengzemiao on 2019/8/21.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "ViewController.h"
#import "DZMTimer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UILabel *autoLabel;

@property (weak, nonatomic) DZMTimer *timer;

@property (weak, nonatomic) DZMTimer *autoTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

/// 手动计时
- (IBAction)start:(UIButton *)sender {
    
    __weak ViewController *weakSelf = self;
    
    // 风格一:
    self.timer = [DZMTimer timeInterval:1.0 totalInterval:10 isStart:NO change:^(NSTimeInterval interval) {

        weakSelf.label.text = [NSString stringWithFormat:@"%f", interval];

    } complete:^{

        weakSelf.label.text = @"完成计时";
    }];
    
    // 风格二:
//    self.timer = [DZMTimer timeInterval:1.0 isStart:NO change:^(NSTimeInterval interval) {
//
//        weakSelf.label.text = [NSString stringWithFormat:@"%f", interval];
//    }];
    
    [self.timer start];
}

- (IBAction)add:(UIButton *)sender {
    
    [self.timer increase:3];
}

/// 手动停止计时
- (IBAction)stop:(UIButton *)sender {
    
    [self.timer stop];
}

/// 自动计时
- (IBAction)autoSatrt:(UIButton *)sender {
    
    __weak ViewController *weakSelf = self;
    
    // 风格一:
//    self.autoTimer = [DZMTimer timeInterval:1.0 totalInterval:10 change:^(NSTimeInterval interval) {
//
//        weakSelf.autoLabel.text = [NSString stringWithFormat:@"%f", interval];
//
//    } complete:^{
//
//        weakSelf.autoLabel.text = @"完成计时";
//    }];
    
    // 风格二:
    self.autoTimer = [DZMTimer timeInterval:1.0 change:^(NSTimeInterval interval) {

        weakSelf.autoLabel.text = [NSString stringWithFormat:@"%f", interval];
    }];
    
    // 风格三:
//    [DZMTimer timeInterval:1.0 change:^(NSTimeInterval interval) {
//
//        weakSelf.autoLabel.text = [NSString stringWithFormat:@"%f", interval];
//    }];
}

/// 自动模式下手动停止计时
- (IBAction)autoStop:(UIButton *)sender {
    
    [self.autoTimer stop];
}

@end

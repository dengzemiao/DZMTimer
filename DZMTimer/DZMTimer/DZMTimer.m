//
//  DZMTimer.m
//  DZMTimer
//
//  Created by dengzemiao on 2019/8/21.
//  Copyright © 2019 DZM. All rights reserved.
//

#import "DZMTimer.h"

@interface DZMTimer()

/// 总时间
@property (nonatomic, assign) NSTimeInterval totalInterval;

/// 时间间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;

/// 当前剩余时间
@property (nonatomic, assign) NSTimeInterval currentInterval;

/// 计时结束
@property (nonatomic, copy) DZMTimerComplete complete;

/// 计时变动
@property (nonatomic, copy) DZMTimerChange change;

/// 定时器
@property (nonatomic, strong) NSTimer *timer;

/// 强引用自身
@property (nonatomic, strong) DZMTimer *strongSelf;

@end

@implementation DZMTimer

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval change:(DZMTimerChange)change {
    
    return [DZMTimer timeInterval:timeInterval change:change complete:nil];
}

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval isStart:(BOOL)isStart change:(DZMTimerChange)change {
    
    return [DZMTimer timeInterval:timeInterval isStart:isStart change:change complete:nil];
}

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval change:(DZMTimerChange)change complete:(DZMTimerComplete _Nullable)complete  {
    
    return [DZMTimer timeInterval:timeInterval isStart:YES change:change complete:complete];
}

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval isStart:(BOOL)isStart change:(DZMTimerChange)change complete:(DZMTimerComplete _Nullable)complete  {
    
    return [DZMTimer timeInterval:timeInterval totalInterval:0 isStart:isStart change:change complete:complete];
}

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval complete:(DZMTimerComplete)complete {
    
    return [DZMTimer timeInterval:timeInterval totalInterval:totalInterval isStart:YES change:nil complete:complete];
}

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval change:(DZMTimerChange)change complete:(DZMTimerComplete)complete  {
    
    return [DZMTimer timeInterval:timeInterval totalInterval:totalInterval isStart:YES change:change complete:complete];
}

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval isStart:(BOOL)isStart change:(DZMTimerChange _Nullable)change complete:(DZMTimerComplete _Nullable)complete  {
    
    if (timeInterval < 0.01) { return nil; }
    
    DZMTimer *timer = [[DZMTimer alloc] init];
    
    timer.totalInterval = totalInterval;
    
    timer.currentInterval = totalInterval;
    
    timer.timeInterval = timeInterval;
    
    timer.complete = complete;
    
    timer.change = change;
    
    timer.strongSelf = timer;
    
    if (isStart) { [timer start]; }
    
    return timer;
}

/// 开始计时
- (void)start {
    
    if (!self.timer) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    }
}

/// 停止计时
- (void)stop {
    
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
        
        if (self.complete) { self.complete(); }
    }
    
    self.strongSelf = nil;
}

/// 时间变动调用
- (void)timerChange {
    
    if (((NSInteger)self.totalInterval) > 0) {
        
        self.currentInterval = MAX(0, self.currentInterval - self.timeInterval);
        
        if (self.change) { self.change(self.currentInterval); }
        
        if (self.currentInterval < 0.01) {
            
            [self stop];
        }
        
    }else{
        
        self.currentInterval = MAX(0, self.currentInterval + self.timeInterval);
        
        if (self.change) { self.change(self.currentInterval); }
    }
}

- (void)dealloc {
    
    NSLog(@"DZMTimer 释放了");
}

@end

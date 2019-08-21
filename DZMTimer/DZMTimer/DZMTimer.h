//
//  DZMTimer.h
//  DZMTimer
//
//  Created by dengzemiao on 2019/8/21.
//  Copyright © 2019 DZM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 计时结束
typedef void(^DZMTimerComplete)(void);

/// 计时变动 interval = 当前剩余时间
typedef void(^DZMTimerChange)(NSTimeInterval interval);

@interface DZMTimer : NSObject

/// 以下初始化得到的对象请使用 weak 引用,因为内部自带 strong 引用, 计时器结束则释放内部强引用。
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval change:(DZMTimerChange)change;

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval isStart:(BOOL)isStart change:(DZMTimerChange)change;

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval change:(DZMTimerChange)change complete:(DZMTimerComplete _Nullable)complete;

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval isStart:(BOOL)isStart change:(DZMTimerChange)change complete:(DZMTimerComplete _Nullable)complete;

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval complete:(DZMTimerComplete)complete;

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval change:(DZMTimerChange)change complete:(DZMTimerComplete)complete;

+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval isStart:(BOOL)isStart change:(DZMTimerChange _Nullable)change complete:(DZMTimerComplete _Nullable)complete;

/// 开始计时 (参数 isStart 为 NO 时手动开始计时, 为 YES 时或多次调用无效)
- (void)start;

/// 停止计时（会释放内部强引用以及对象）
- (void)stop;
@end

NS_ASSUME_NONNULL_END

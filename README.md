# DZMTimer
倒计时，定时器，NSTimer封装，简单使用！

### 使用:

```

// 自动计时器:
[DZMTimer timeInterval:1.0 change:^(NSTimeInterval interval) {

    weakSelf.autoLabel.text = [NSString stringWithFormat:@"%f", interval];
}];

// 自动倒计时:
[DZMTimer timeInterval:1.0 totalInterval:10 change:^(NSTimeInterval interval) {

    weakSelf.autoLabel.text = [NSString stringWithFormat:@"%f", interval];

} complete:^{

    weakSelf.autoLabel.text = @"完成计时";
}];

// 外部接收处理计时器对象:
self.autoTimer = [DZMTimer timeInterval....];

```

### 代码:

```
/// 计时结束
typedef void(^DZMTimerComplete)(void);

/// 计时变动 interval = 当前剩余时间
typedef void(^DZMTimerChange)(NSTimeInterval interval);

@interface DZMTimer : NSObject

/// 滚动控件中使用定时器，但是会暂停定时器，需要将定时器添加到 NSRunLoopCommonModes
/// [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

/// 子线程中使用定时器，需要将定时器添加到 NSDefaultRunLoopMode
/// [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
/// [[NSRunLoop currentRunLoop] run];

/// 定时器
@property (nonatomic, strong, readonly, nullable) NSTimer *timer;

/// 以下初始化得到的对象请使用 weak 引用,因为内部自带 strong 引用, 计时器结束则释放内部强引用。

/// 自动开始 计时器
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval change:(DZMTimerChange)change;

/// 可选开始 计时器
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval isStart:(BOOL)isStart change:(DZMTimerChange)change;

/// 自动开始 计时器
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval change:(DZMTimerChange)change complete:(DZMTimerComplete _Nullable)complete;

/// 可选开始 计时器
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval isStart:(BOOL)isStart change:(DZMTimerChange)change complete:(DZMTimerComplete _Nullable)complete;

/// 自动开始 计时器 || 倒计时
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval complete:(DZMTimerComplete)complete;

/// 自动开始 计时器 || 倒计时
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval change:(DZMTimerChange)change complete:(DZMTimerComplete)complete;

/// 可选开始 计时器 || 倒计时
/// timeInterval = 调用间隔, totalInterval = 倒计时总时间，为0则为计时器，不会倒计时, isStart = 是否自动开始计时或者倒计时
/// change = 计时器或倒计时变化调用, complete = 计时器停止或者倒计时结束调用
+ (nullable instancetype)timeInterval:(NSTimeInterval)timeInterval totalInterval:(NSTimeInterval)totalInterval isStart:(BOOL)isStart change:(DZMTimerChange _Nullable)change complete:(DZMTimerComplete _Nullable)complete;

/// 在当前剩余倒计时长上增加时长，正数为加，负数为减。(倒计时模式使用，计时器模式无效)
- (void)increase:(NSTimeInterval)increaseInterval;

/// 开始计时 (参数 isStart 为 NO 时手动开始计时, 为 YES 时或多次调用无效)
- (void)start;

/// 停止计时（会释放内部强引用以及对象）
- (void)stop;
@end

```

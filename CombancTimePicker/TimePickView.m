//
//  TimePickView.m
//  ApplyDemo
//
//  Created by Golden on 2018/9/3.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "TimePickView.h"
#import "CalendarView.h"
#import "TimePickerDefine.h"
#import "TimeView.h"
#import "NSDate+CalenderDate.h"

@interface TimePickView()<CalendarViewDelegate,TimeViewDelegate>

@property (nonatomic, strong) CalendarView *calendarView;
@property (nonatomic, strong) TimeView *timeView;
@property (nonatomic, strong) NSString *currentDate; //当前选中的日期
@property (nonatomic, strong) NSString *currentTime; //当前选中的时间
@property (nonatomic, copy  ) didSelectedTimeBlock resultBlock;

@end

@implementation TimePickView

+ (void)showWithResult:(didSelectedTimeBlock)result {
    TimePickView *pickView = [[TimePickView alloc]initWithResultBlock:result];
    [pickView showWithAnimation:YES];
}

- (instancetype)initWithResultBlock:(didSelectedTimeBlock)resultBlock {
    if (self = [super init]) {
        [self initUI];
        _resultBlock = resultBlock;
    }
    return self;
}

//UI布局，主要就是在弹出视图上添加选择器。
- (void)initUI {
    //初始化
    self.currentDate = [[NSDate new] formatterDate:@"YYYY-MM-dd"];
    self.currentTime = @"上午";
    
    [super initUI];
    [self.alertView addSubview:self.calendarView];
}

//选择器的初始化和布局
- (CalendarView *)calendarView {
    if (!_calendarView) {
        CGRect rect = self.alertView.bounds;
        rect.origin.y = KTopViewHeight;
        _calendarView = [[CalendarView alloc]initWithFrame:rect];
        _calendarView.delegate = self;
    }
    return _calendarView;
}

//时间选择器初始化
- (TimeView *)timeView {
    if (!_timeView) {
        _timeView = [[TimeView alloc]initWithFrame:self.calendarView.frame];
        CGRect timeFrame = _timeView.frame;
        timeFrame.origin.x = self.alertView.frame.size.width;
        _timeView.frame = timeFrame;
        _timeView.delegate = self;
    }
    return _timeView;
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:YES];
}

#pragma mark - 弹出视图的方法
- (void)showWithAnimation:(BOOL)animation {
    //获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        //动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertView.frame = rect;
        //浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= KDataHeight + KTopViewHeight;
            self.alertView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    //关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += KDataHeight + KTopViewHeight;
        self.alertView.frame = rect;
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 日期选择按钮点击事件
- (void)clickDataBtn {
    self.dataBtn.selected = !self.dataBtn.selected;
    CGRect rect = CGRectMake(self.dataBtn.frame.origin.x, self.dataBtn.frame.size.height - 2, self.dataBtn.frame.size.width, 2);
    [UIView animateWithDuration:0.33 animations:^{
        self.cursorView.frame = rect;
        //日历
        CGRect calanderFrame = self.calendarView.frame;
        calanderFrame.origin.x = 0;
        self.calendarView.frame = calanderFrame;
        //时间
        CGRect timeFrame = self.timeView.frame;
        timeFrame.origin.x = self.alertView.frame.size.width;
        self.timeView.frame = timeFrame;
    }];
}

#pragma mark - 时间选择按钮
- (void)clickTimeBtn {
    self.timeBtn.selected = !self.timeBtn.selected;
    if (![self.subviews containsObject:self.timeView]) {
        [self.alertView addSubview:self.timeView];
    }
    CGRect rect = CGRectMake(self.timeBtn.frame.origin.x, self.timeBtn.frame.size.height - 2, self.timeBtn.frame.size.width, 2);
    [UIView animateWithDuration:0.33 animations:^{
        self.cursorView.frame = rect;
        //日历
        CGRect calanderFrame = self.calendarView.frame;
        calanderFrame.origin.x = -self.alertView.frame.size.width;
        self.calendarView.frame = calanderFrame;
        //时间
        CGRect timeFrame = self.timeView.frame;
        timeFrame.origin.x = 0;
        self.timeView.frame = timeFrame;
    }];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    if (self.resultBlock) {
        self.resultBlock(self.currentDate,self.currentTime);
    }
    [self dismissWithAnimation:YES];
}

#pragma mark - CalendarViewDelegate
- (void)didSelectedDate:(NSDate *)selectedDate {
    int selectedYear = selectedDate.year;
    int selectedMonth = selectedDate.month;
    int selectedDay = selectedDate.day;
    self.currentDate = [selectedDate formatterDate:@"YYYY-MM-dd"];
    [self.dataBtn setTitle:[NSString stringWithFormat:@"%d年%d月%d日",selectedYear,selectedMonth,selectedDay] forState:UIControlStateNormal];
   
    //选择完日期则跳转到选择时间
    self.dataBtn.selected = NO;
    if (![self.subviews containsObject:self.timeView]) {
        [self.alertView addSubview:self.timeView];
    }
    CGRect rect = CGRectMake(self.timeBtn.frame.origin.x, self.timeBtn.frame.size.height - 2, self.timeBtn.frame.size.width, 2);
    [UIView animateWithDuration:0.33 animations:^{
        self.cursorView.frame = rect;
        //日历
        CGRect calanderFrame = self.calendarView.frame;
        calanderFrame.origin.x = -self.alertView.frame.size.width;
        self.calendarView.frame = calanderFrame;
        //时间
        CGRect timeFrame = self.timeView.frame;
        timeFrame.origin.x = 0;
        self.timeView.frame = timeFrame;
    }];
}

#pragma mark - TimeViewDelegate
- (void)selectedTime:(NSString *)time {
    [self.timeBtn setTitle:time forState:UIControlStateNormal];
    self.currentTime = time;
}

@end

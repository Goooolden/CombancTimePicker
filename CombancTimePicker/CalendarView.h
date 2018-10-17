//
//  CalendarView.h
//  ApplyDemo
//
//  Created by Golden on 2018/8/30.
//  Copyright © 2018年 Golden. All rights reserved.
//  日历控件

#import <UIKit/UIKit.h>

@protocol CalendarViewDelegate <NSObject>

- (void)didSelectedDate:(NSDate *)selectedDate;

@end

@interface CalendarView : UIView

@property (nonatomic, weak) id<CalendarViewDelegate> delegate;

@end

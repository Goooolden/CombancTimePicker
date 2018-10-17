//
//  NSDate+CalenderDate.h
//  ApplyDemo
//
//  Created by Golden on 2018/9/3.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CalenderDate)
//年
- (int)year;
//月
- (int)month;
//日
- (int)day;
//时
- (int)hour;
//分
- (int)minute;
//秒
- (int)second;
//一年的天数
- (int)daysInYear;
//是否为闰年
- (BOOL)isLeapYear;
//当前时间月份的第一天是周几
- (int)firstWeekDayInThisMonth;
//当前时间月份共有多少天
- (int)totalDaysInThisMonth;
//上个月份的此刻日期时间
- (NSDate *)lastMonth;
//下个月份的此刻日期时间
- (NSDate *)nextMonth;

/**
 格式化时间
 
 @param formatter yyyy-MM-dd/YYYY-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss
 @return 格式化后的时间String
 */
- (NSString *)formatterDate:(NSString *)formatter;

@end

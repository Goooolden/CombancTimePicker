//
//  NSDate+CalenderDate.m
//  ApplyDemo
//
//  Created by Golden on 2018/9/3.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "NSDate+CalenderDate.h"

@implementation NSDate (CalenderDate)

- (NSDateComponents *)components:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    return components;
}

- (int)year {
    return (int)[self components:self].year;
}

- (int)month {
    return (int)[self components:self].month;
}

- (int)day {
    return (int)[self components:self].day;
}

- (int)hour {
    return (int)[self components:self].hour;
}

- (int)minute {
    return (int)[self components:self].minute;
}

- (int)second {
    return (int)[self components:self].second;
}

- (int)daysInYear {
    return (self.isLeapYear ? 366 : 365);
}

- (BOOL)isLeapYear {
    int year = self.year;
    return (year%4==0 ? (year%100==0 ? (year%400==0 ? true : false) : true) : false);
}

- (int)firstWeekDayInThisMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    //1->周日 2->周一 ···
    calendar.firstWeekday = 1;
    components.day = 1;
    NSDate *first = [calendar dateFromComponents:components];
    NSInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:first];
    return (int)(firstWeekDay - 1);
}

- (int)totalDaysInThisMonth {
    NSRange totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return (int)totalDays.length;
}

- (NSDate *)lastMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)nextMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSString *)formatterDate:(NSString *)formatter {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = formatter;
    NSString *dateString = [dateformatter stringFromDate:self];
    return dateString;
}

@end

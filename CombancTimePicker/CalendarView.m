//
//  CalendarView.m
//  ApplyDemo
//
//  Created by Golden on 2018/8/30.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "CalendarView.h"
#import "TimePickerDefine.h"
#import "CalendarLayout.h"
#import "CalendarCell.h"
#import "NSDate+CalenderDate.h"
#import "UIColor+Calender.h"

static NSString *const CalendarCellID = @"CalendarCellID";

@interface CalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) CalendarLayout *calendarLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *yearLbl;
@property (nonatomic, strong) NSDate *currentDate;            //当前日期
@property (nonatomic, strong) NSDate *selectDate;             //选中日期
@property (nonatomic, assign) NSInteger lastSelected;         //上次选择

@end

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //添加周次视图
        [self creatWeekTitle];
        //添加日历视图
        [self addSubview:self.collectionView];
        //添加年份
        [self addSubview:self.yearLbl];
        [self sendSubviewToBack:self.yearLbl];
    }
    return self;
}

#pragma mark - 创建CalendarLayout
- (CalendarLayout *)calendarLayout {
    if (!_calendarLayout) {
        _calendarLayout = [[CalendarLayout alloc]init];
    }
    return _calendarLayout;
}

#pragma mark - 懒加载CurrentDate
- (NSDate *)currentDate {
    if (!_currentDate) {
        _currentDate = [[NSDate alloc]init];
    }
    return _currentDate;
}

#pragma mark - 懒加载SelectDate
- (NSDate *)selectDate {
    if (!_selectDate) {
        _selectDate = [[NSDate alloc]init];
    }
    return _selectDate;
}

#pragma mark - 上次选中的日期，默认初始值为当前日期
- (NSInteger)lastSelected {
    if (!_lastSelected) {
        _lastSelected = (42 + [NSDate new].firstWeekDayInThisMonth - 1 + [NSDate new].day);
    }
    return _lastSelected;
}

#pragma mark - 创建CollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 30, self.frame.size.width - 20, self.frame.size.height - 30 - KTopViewHeight) collectionViewLayout:self.calendarLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.pagingEnabled = true;
        [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:CalendarCellID];
        [_collectionView setContentOffset:CGPointMake(0, (self.frame.size.height - 30 - KTopViewHeight)*1) animated:false];
    }
    return _collectionView;
}

#pragma mark - 显示年份
- (UILabel *)yearLbl {
    if (!_yearLbl) {
        _yearLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, self.frame.size.height - 30 - KTopViewHeight)];
        _yearLbl.textColor = [UIColor colorWithHex:@"#E9EDF2"];
        _yearLbl.font = [UIFont fontWithName:@"DB LCD Temp" size:110];
        _yearLbl.textAlignment = NSTextAlignmentCenter;
        _yearLbl.adjustsFontSizeToFitWidth = YES;
        _yearLbl.text = [@(self.currentDate.year) description];
    }
    return _yearLbl;
}

#pragma mark - CollectionDelegate&&CollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42 * 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CalendarCellID forIndexPath:indexPath];
    
    int daysInThisMonth = self.currentDate.totalDaysInThisMonth;
    int firstWeekDay = self.currentDate.firstWeekDayInThisMonth;
    int currentMonth = self.currentDate.month;
    int currentYear = self.currentDate.year;
    NSDate *lastMonthDate = self.currentDate.lastMonth;
    int lastMonth = lastMonthDate.month;
    int daysInLastMonth = lastMonthDate.totalDaysInThisMonth;
    NSDate *nextMonthDate = self.currentDate.nextMonth;
    int nextMonth = nextMonthDate.month;
    int daysInNextMonth = nextMonthDate.totalDaysInThisMonth;
    
    int i = (int)(indexPath.row - 42);
    
    if (i < firstWeekDay) {
        int lastDay = (daysInLastMonth - firstWeekDay + 1 + i);
        if (lastDay == 1) {
            cell.textLbl.text = [NSString stringWithFormat:@"%d月",lastMonth];
        }else if (lastDay <= 0) {
            NSDate *doubleLastMonthDate = lastMonthDate.lastMonth;
            int daysInDoubleLastMonth = doubleLastMonthDate.totalDaysInThisMonth;
            cell.textLbl.text = [@(daysInDoubleLastMonth + lastDay) description];
        }else {
            cell.textLbl.text = [@(lastDay) description];
        }
        cell.textColor = [UIColor lightGrayColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.userInteractionEnabled = NO;
    }else if (i > firstWeekDay + daysInThisMonth - 1) {
        int nextCurrentDay = (i - firstWeekDay - daysInThisMonth + 1);
        if (nextCurrentDay <= daysInNextMonth) {
            if (nextCurrentDay == 1) {
                cell.textLbl.text = [NSString stringWithFormat:@"%d月",nextMonth];
            }else {
                cell.textLbl.text = [@(nextCurrentDay) description];
            }
        }else {
            int doubleNextMonthCurrentDay = (nextCurrentDay - daysInNextMonth);
            if (doubleNextMonthCurrentDay == 1) {
                if (nextMonth == 12) {
                    cell.textLbl.text = @"1月";
                }else {
                    cell.textLbl.text = [NSString stringWithFormat:@"%d月",nextMonth + 1];
                }
            }else {
                cell.textLbl.text = [@(doubleNextMonthCurrentDay) description];
            }
        }
        cell.textColor = [UIColor lightGrayColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.userInteractionEnabled = NO;
    }else {
        int currentDay = i - firstWeekDay + 1;
        if (currentDay == [NSDate new].day &&
            currentMonth == [NSDate new].month &&
            currentYear == [NSDate new].year) {
            cell.textLbl.text = [@(currentDay) description];
            if (currentDay == self.selectDate.day &&
                currentMonth == self.selectDate.month &&
                currentYear == self.selectDate.year) {
                cell.backgroundColor = [UIColor colorWithHex:@"#7D7F82"];
                cell.textColor = [UIColor whiteColor];
            }else {
                cell.backgroundColor = [UIColor colorWithHex:@"#E9F3FE"];
                cell.textColor = [UIColor colorWithHex:@"#297DFF"];
            }
        }else {
            if (currentDay == 1) {
                cell.textLbl.text = [NSString stringWithFormat:@"%d月",currentMonth];
                if (currentDay == self.selectDate.day &&
                    currentMonth == self.selectDate.month &&
                    currentYear == self.selectDate.year) {
                    cell.backgroundColor = [UIColor colorWithHex:@"#7D7F82"];
                    cell.textColor = [UIColor whiteColor];
                }else {
                    cell.backgroundColor = [UIColor clearColor];
                    cell.textColor = [UIColor colorWithHex:@"#297DFF"];
                }
            }else {
                cell.textLbl.text = [@(currentDay) description];
                if (currentDay == self.selectDate.day &&
                    currentMonth == self.selectDate.month &&
                    currentYear == self.selectDate.year) {
                    cell.backgroundColor = [UIColor colorWithHex:@"#7D7F82"];
                    cell.textColor = [UIColor whiteColor];
                }else {
                    cell.backgroundColor = [UIColor clearColor];
                    cell.textColor = [UIColor blackColor];
                }
            }
        }
        cell.userInteractionEnabled = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //计算选中的日期
    int firstWeekDay = self.currentDate.firstWeekDayInThisMonth;
    int clickDay = (int)(indexPath.row - 42 - firstWeekDay + 1);
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.day = -self.currentDate.day + clickDay;
    NSDate *clickDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self.currentDate options:0];
    self.selectDate = clickDate;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedDate:)]) {
        [self.delegate didSelectedDate:self.selectDate];
    }
    
    //刷新上次选中和当前选中的Items
    NSMutableArray <NSIndexPath *>*arr = [NSMutableArray new];
    if (self.lastSelected != indexPath.row) {
        [arr addObject:[NSIndexPath indexPathForItem:self.lastSelected inSection:0]];
    }
    [arr addObject:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
    [collectionView reloadItemsAtIndexPaths:arr];
    
    //记录选中的item
    self.lastSelected = indexPath.row;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     float direction = lroundf((float)(self.collectionView.contentOffset.y / self.collectionView.frame.size.height));
    
    if (direction == 0) {
        self.currentDate = self.currentDate.lastMonth;
        [self reseData];
    }
    if (direction == 2) {
        self.currentDate = self.currentDate.nextMonth;
        [self reseData];
    }
}

- (void)reseData {
    [self.collectionView setContentOffset:CGPointMake(0, (self.frame.size.height - 30 - KTopViewHeight) * 1)];
    [self.collectionView reloadData];
    self.yearLbl.text = [@(self.currentDate.year) description];
}

#pragma mark - 创建周次标签
- (void)creatWeekTitle {
    NSArray *titles = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < titles.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10 + (((SCREEN_WIDTH - 20 - 6 * 8) / 7) * i) + 8 * i, 0, (SCREEN_WIDTH - 20 - 6 * 8) / 7, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.text = titles[i];
        [self addSubview:label];
    }
}

@end

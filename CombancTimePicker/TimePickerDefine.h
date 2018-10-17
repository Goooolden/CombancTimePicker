//
//  TimePickerDefine.h
//  ApplyDemo
//
//  Created by Golden on 2018/9/4.
//  Copyright © 2018年 Golden. All rights reserved.
//

#ifndef TimePickerDefine_h
#define TimePickerDefine_h

#define KTopViewHeight 44  //日期,时间,确定 行高

#define KCalendarItemWH (SCREEN_WIDTH - 20 - 6 * 8) / 7  //日历宽度
#define KDataHeight (6 * KCalendarItemWH + 6 * 8 + 35)   //日期选择器高度

#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kGrayFontColor [UIColor darkGrayColor]
#define kBlueFontColor [UIColor blueColor]
#define kBlackFontColor [UIColor blackColor]

#endif /* TimePickerDefine_h */

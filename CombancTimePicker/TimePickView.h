//
//  TimePickView.h
//  ApplyDemo
//
//  Created by Golden on 2018/9/3.
//  Copyright © 2018年 Golden. All rights reserved.
//  弹出的日历和时间动画及事件

#import "BaseTimePickView.h"

typedef void(^didSelectedTimeBlock)(NSString *date,NSString *time);

@interface TimePickView : BaseTimePickView

+ (void)showWithResult:(didSelectedTimeBlock)result;

@end

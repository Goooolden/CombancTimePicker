//
//  TimeView.h
//  ApplyDemo
//
//  Created by Golden on 2018/9/3.
//  Copyright © 2018年 Golden. All rights reserved.
//  日期控件

#import <UIKit/UIKit.h>

@protocol TimeViewDelegate <NSObject>

- (void)selectedTime:(NSString *)time;

@end

@interface TimeView : UIView

@property (nonatomic, weak) id<TimeViewDelegate> delegate;

@end

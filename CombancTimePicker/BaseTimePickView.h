//
//  BaseTimePickView.h
//  ApplyDemo
//
//  Created by Golden on 2018/8/29.
//  Copyright © 2018年 Golden. All rights reserved.
//  弹出视图的基类

#import <UIKit/UIKit.h>

@interface BaseTimePickView : UIView
//背景蒙层视图
@property (nonatomic, strong) UIView *backgroundView;
//弹出视图
@property (nonatomic, strong) UIView *alertView;
//顶部视图
@property (nonatomic, strong) UIView *topView;
//日期按钮
@property (nonatomic, strong) UIButton *dataBtn;
//时间按钮
@property (nonatomic, strong) UIButton *timeBtn;
//右边确定按钮
@property (nonatomic, strong) UIButton *rightBtn;
//分割线视图
@property (nonatomic, strong) UIView *lineView;
//日期，时间按钮下划线
@property (nonatomic, strong) UIView *cursorView;

/** 初始化子视图，整体布局 */
- (void)initUI;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

/** 日期按钮点击事件 */
- (void)clickDataBtn;

/** 时间按钮点击事件*/
- (void)clickTimeBtn;

/** 确定按钮的点击事件 */
- (void)clickRightBtn;

@end

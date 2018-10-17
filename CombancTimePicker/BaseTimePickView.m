//
//  BaseTimePickView.m
//  ApplyDemo
//
//  Created by Golden on 2018/8/29.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "BaseTimePickView.h"
#import "TimePickerDefine.h"
#import "UIColor+Calender.h"

@implementation BaseTimePickView

- (void)initUI {
    self.frame = SCREEN_BOUNDS;
    //背景遮罩图层
    [self addSubview:self.backgroundView];
    //弹出视图
    [self addSubview:self.alertView];
    //添加顶部标题栏
    [self.alertView addSubview:self.topView];
    //添加日期按钮
    [self.topView addSubview:self.dataBtn];
    //添加时间按钮
    [self.topView addSubview:self.timeBtn];
    //添加确定按钮
    [self.topView addSubview:self.rightBtn];
    //添加选择状态
    [self.topView addSubview:self.cursorView];
    //添加分割线
    [self.topView addSubview:self.lineView];
}

#pragma mark - 背景遮罩层
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.3f;
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBackgroundView:)];
        [_backgroundView addGestureRecognizer:myTap];
    }
    return _backgroundView;
}

#pragma mark - 弹出视图
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - KTopViewHeight - KDataHeight, SCREEN_WIDTH, KTopViewHeight + KDataHeight)];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

#pragma mark - 顶部标题栏视图
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KTopViewHeight + 0.5)];
        _topView.backgroundColor = [UIColor colorWithHex:@"#F5F6F5"];
    }
    return _topView;
}

#pragma mark - 日历选择按钮
- (UIButton *)dataBtn {
    if (!_dataBtn) {
        _dataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dataBtn.frame = CGRectMake(5, 0, 137, KTopViewHeight);
        _dataBtn.backgroundColor = [UIColor clearColor];
        _dataBtn.layer.masksToBounds = YES;
        _dataBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_dataBtn setTitleColor:kGrayFontColor forState:UIControlStateNormal];
        [_dataBtn addTarget:self action:@selector(clickDataBtn) forControlEvents:UIControlEventTouchUpInside];
        _dataBtn.selected = YES;
        [_dataBtn setTitle:@"2018年8月30日" forState:UIControlStateNormal];
    }
    return _dataBtn;
}

#pragma mark - 时间选择器
- (UIButton *)timeBtn {
    if (!_timeBtn) {
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn.frame = CGRectMake(143+10, 0, 60, KTopViewHeight);
        _timeBtn.backgroundColor = [UIColor clearColor];
        _timeBtn.layer.masksToBounds = YES;
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_timeBtn setTitleColor:kGrayFontColor forState:UIControlStateNormal];
        [_timeBtn addTarget:self action:@selector(clickTimeBtn) forControlEvents:UIControlEventTouchUpInside];
        _timeBtn.selected = NO;
        [_timeBtn setTitle:@"上午" forState:UIControlStateNormal];
    }
    return _timeBtn;
}

#pragma mark - 右边确定按钮
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(SCREEN_WIDTH - 65, 8, 60, 28);
        _rightBtn.backgroundColor = [UIColor clearColor];
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [_rightBtn setTitleColor:kBlackFontColor forState:UIControlStateNormal];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

#pragma mark - 分割线
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, KTopViewHeight, SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
        [self.alertView addSubview:_lineView];
    }
    return _lineView;
}

#pragma mark - 选中状态
- (UIView *)cursorView {
    if (!_cursorView) {
        _cursorView = [[UIView alloc]initWithFrame:CGRectMake(self.dataBtn.frame.origin.x, self.dataBtn.frame.size.height - 2, self.dataBtn.frame.origin.x + self.dataBtn.frame.size.width, 2)];
        _cursorView.backgroundColor = kGrayFontColor;
    }
    return _cursorView;
}

#pragma mark - 点击背景遮罩层
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    
}

#pragma mark - 日期按钮点击
- (void)clickDataBtn {
    
}

#pragma mark - 时间按钮点击
- (void)clickTimeBtn {
    
}

#pragma mark - 确定按钮点击
- (void)clickRightBtn {
    
}

@end

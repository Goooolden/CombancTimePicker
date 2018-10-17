//
//  TimeView.m
//  ApplyDemo
//
//  Created by Golden on 2018/9/3.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "TimeView.h"

@interface TimeView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, copy  ) NSArray *infoArray;

@end

@implementation TimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pickerView];
    }
    return self;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:self.frame];
        CGPoint center = _pickerView.center;
        center.y = self.frame.size.height/2;
        _pickerView.center = center;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [[NSArray alloc]initWithObjects:@"上午",@"下午", nil];
    }
    return _infoArray;
}

#pragma mark - UIPickerView数据布局
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

//每一行的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.infoArray[row];
}

//选中的时的效果
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *selectTime = self.infoArray[row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedTime:)]) {
        [self.delegate selectedTime:selectTime];
    }
}

//返回宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100.0f;
}

//返回高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35.0f;
}

//分割线
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = self.infoArray[row];
    genderLabel.font = [UIFont systemFontOfSize:22];
    genderLabel.textColor = [UIColor blackColor];
    return genderLabel;
}
@end

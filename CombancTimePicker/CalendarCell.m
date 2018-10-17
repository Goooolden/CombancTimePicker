//
//  CalendarCell.m
//  ApplyDemo
//
//  Created by Golden on 2018/8/31.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLbl];
    }
    return self;
}

- (UILabel *)textLbl {
    if (!_textLbl) {
        _textLbl = [[UILabel alloc]initWithFrame:self.bounds];
        _textLbl.backgroundColor = [UIColor clearColor];
        _textLbl.textAlignment = NSTextAlignmentCenter;
        _textLbl.adjustsFontSizeToFitWidth = YES;
    }
    return _textLbl;
}

- (void)setTextColor:(UIColor *)textColor {
    self.textLbl.textColor = textColor;
}

@end

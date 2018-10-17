//
//  CalendarLayout.m
//  ApplyDemo
//
//  Created by Golden on 2018/8/30.
//  Copyright © 2018年 Golden. All rights reserved.
//

#import "CalendarLayout.h"

#define calendarItemWH ([UIScreen mainScreen].bounds.size.width - 20 - 6 * 8) / 7

@implementation CalendarLayout

- (instancetype)init {
    if (self = [super init]) {
        self.itemSize = CGSizeMake(calendarItemWH, calendarItemWH);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 8;
        self.minimumInteritemSpacing = 8;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

@end

//
//  ZBJCalendarCell.m
//  ZBJCalendar
//
//  Created by wanggang on 2/24/16.
//  Copyright © 2016 ZBJ. All rights reserved.
//

#import "ZBJCalendarCell.h"
#import "NSDate+ZBJAddition.h"

@interface ZBJCalendarCell ()

@property (nonatomic, strong) UILabel *dayLabel;


@end

@implementation ZBJCalendarCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dayLabel];
    }
    return self;
}



#pragma mark - setters
- (void)setDay:(NSDate *)day {
    _day = day;
    if (_day) {
        self.firstDayShowMonth = _firstDayShowMonth;
        self.isToday = _day.isToday;
    } else {
        _dayLabel.text = nil;
    }
}

- (void)setFirstDayShowMonth:(BOOL)firstDayShowMonth {
    _firstDayShowMonth = firstDayShowMonth;
    
    if (!self.day) {
        return;
    }
    
    NSCalendar *calendar = [NSDate gregorianCalendar];

    if (_firstDayShowMonth) {
        NSInteger day = [calendar component:NSCalendarUnitDay fromDate:self.day];
        if (day == 1) {
            NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:self.day];
            _dayLabel.text = [NSString stringWithFormat:@"%ld月\n%ld", month, day];
        } else {
            _dayLabel.text = [NSString stringWithFormat:@"%ld", day];
        }
    } else {
        _dayLabel.text = [NSString stringWithFormat:@"%ld", [calendar component:NSCalendarUnitDay fromDate:self.day]];
    }
}

- (void)setIsToday:(BOOL)isToday {
    _isToday = isToday;
    if (_isToday) {
        self.dayLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.f blue:48.0f/255.0f alpha:1.0];
        self.dayLabel.textColor = [UIColor whiteColor];
        self.dayLabel.layer.cornerRadius = CGRectGetWidth(self.dayLabel.frame) / 2;
        self.dayLabel.clipsToBounds = YES;
    } else {
        self.dayLabel.backgroundColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor darkTextColor];
        self.dayLabel.clipsToBounds = NO;
    }
}

- (void)setSelected:(BOOL)selected {
    if (self.isToday) {
        return;
    }
    if (selected) {
        self.dayLabel.backgroundColor = [UIColor grayColor];
        self.dayLabel.textColor = [UIColor whiteColor];
        self.dayLabel.layer.cornerRadius = CGRectGetWidth(self.dayLabel.frame) / 2;
        self.dayLabel.clipsToBounds = YES;
    } else {
        self.dayLabel.backgroundColor = [UIColor whiteColor];
        self.dayLabel.textColor = [UIColor darkTextColor];
        self.dayLabel.clipsToBounds = NO;
    }
}

#pragma mark - getters
- (UILabel *)dayLabel {
    if (!_dayLabel) {
        CGRect r = CGRectMake(5, 5, CGRectGetWidth(self.bounds) - 10, CGRectGetHeight(self.bounds) - 10);
        _dayLabel = [[UILabel alloc] initWithFrame: r];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.textColor = [UIColor darkTextColor];
    }
    return _dayLabel;
}


@end

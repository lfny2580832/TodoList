//
//  NSObject+NYExtends.m
//  CalendarTodoList
//
//  Created by 牛严 on 16/1/11.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "NSObject+NYExtends.h"

@implementation NSObject (NYExtends)

#pragma mark 获取当前三个月天数
+ (NSInteger)numberOfDaysOfThreeMonths {
    NSCalendar *currentCalendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *currentComponents = [currentCalendar components:NSCalendarUnitYear|
                                           NSCalendarUnitMonth|
                                           NSCalendarUnitDay|
                                           NSCalendarUnitWeekday|
                                           NSCalendarUnitCalendar
                                                             fromDate:[NSDate date]];
    //用来加一个月的component
    NSDateComponents *inc = [[NSDateComponents alloc] init];
    inc.month = 1;
    //第一个月的日期和天数
    NSInteger firstMonthDays = [currentCalendar rangeOfUnit:NSCalendarUnitDay
                                                     inUnit:NSCalendarUnitMonth
                                                    forDate:[NSDate date]].length;
    
    NSDate *currentDate = [currentCalendar dateFromComponents:currentComponents];
    //第二个月的日期和天数
    NSDate *secondDate = [currentCalendar dateByAddingComponents:inc toDate:currentDate options:0];
    NSInteger secondMonthDays = [currentCalendar rangeOfUnit:NSCalendarUnitDay
                                                      inUnit:NSCalendarUnitMonth
                                                     forDate:secondDate].length;
    //第三个月的日期和天数
    NSDate *thirdDate = [currentCalendar dateByAddingComponents:inc toDate:secondDate options:0];
    NSInteger thirdMonthDays = [currentCalendar rangeOfUnit:NSCalendarUnitDay
                                                     inUnit:NSCalendarUnitMonth
                                                    forDate:thirdDate].length;
    
    return firstMonthDays + secondMonthDays + thirdMonthDays;
}

#pragma mark 获取随机颜色
+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
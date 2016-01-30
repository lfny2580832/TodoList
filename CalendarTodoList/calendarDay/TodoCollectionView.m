//
//  TodoCollectionView.m
//  CalendarTodoList
//
//  Created by 牛严 on 16/1/8.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "TodoCollectionView.h"
#import "TodoCollectionViewCell.h"
#import <Realm/Realm.h>
#import "RLMTodoList.h"
#import "RLMThing.h"
#import "NSObject+NYExtends.h"

@implementation TodoCollectionView
{
    NSInteger _unitFlags;
    NSCalendar *_calendar;
    NSDate *_firstDayInCurrentMonth;
    NSDateFormatter *_YMDformatter;
    
}

static NSString * const reuseIdentifier = @"Cell";

- (void)getIndexPageTodoCellWithChosenDate:(NSDate *)chosenDate
{
    NSInteger pageIndex = [self daysBetweenFirstDayInCurrentMonthAndDate:chosenDate];
    [self.mdelegate cellSelectedByChosenDateWithIndexRow:pageIndex];
}

- (void)setSelectedDayTodoCellWithIndexRow:(NSInteger)indexRow
{
    [self setContentOffset:CGPointMake(SCREEN_WIDTH * indexRow, 0)];
}

#pragma mark 获取当前日期到本月第一天之间的天数，以便设置第几个cell
- (NSInteger)daysBetweenFirstDayInCurrentMonthAndDate:(NSDate *)chosenDate
{
    NSDateComponents *comps = [_calendar components:_unitFlags fromDate:chosenDate];
    comps.hour = 12;
    NSDate *newEnd  = [_calendar dateFromComponents:comps];
    NSTimeInterval interval = [newEnd timeIntervalSinceDate:_firstDayInCurrentMonth];
    NSInteger beginDays=((NSInteger)interval)/(3600*24);
    return beginDays;
}

#pragma mark 根据现在的Indexpath，获取当前日期
- (NSDate *)getChosenDateFromIndexPathRow:(NSInteger)indexpathrow
{
    NSTimeInterval interval = 3600*24*(indexpathrow);
    NSDate * chosenDate = [_firstDayInCurrentMonth dateByAddingTimeInterval:interval];
    return chosenDate;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger indexRow =  self.contentOffset.x /SCREEN_WIDTH;
    //选中week中的cell，开始滑与静止都需要选中，形成连贯效果
    [self.mdelegate selectedTodoCellWithIndexItem:indexRow];
}

#pragma mark 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-340)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumLineSpacing:0];
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        [self initDateParameters];
        [self initView];
    }
    return self;
}

- (void)initDateParameters
{
    _calendar = [NSCalendar currentCalendar];
    _unitFlags = NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear;
    //获取当前月第一天的日期
    NSDateComponents *comps = [_calendar components:_unitFlags fromDate:[NSDate date]];
    comps.day = 1;
    comps.hour = 12;
    _firstDayInCurrentMonth = [_calendar dateFromComponents:comps];
    _YMDformatter = [[NSDateFormatter alloc]init];
    [_YMDformatter setDateFormat:@"yyyyMMdd"];
}

- (void)initView
{
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.pagingEnabled = YES;
    [self registerClass:[TodoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark CollectionView返回三个月天数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [NSObject numberOfDaysOfThreeMonths];
}

#pragma mark 生成CollectionView的Item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TodoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDate *chosenDate = [self getChosenDateFromIndexPathRow:indexPath.item];
    NSInteger dayId = [[_YMDformatter stringFromDate:chosenDate] integerValue];
    [cell refreshTableViewBeforQueryData];
    cell.index = [NSString stringWithFormat:@"%ld",(long)indexPath.item + 1];
    cell.date = chosenDate;
    cell.dayId = dayId;
    cell.backgroundColor = [NSObject randomColor];
    [self.mdelegate selectedTodoCellWithIndexItem:indexPath.item];
    return cell;
}

@end
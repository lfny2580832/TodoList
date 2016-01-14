//
//  CalendarTodoDetailVC.m
//  CalendarTodoList
//
//  Created by 牛严 on 16/1/7.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import "CalendarTodoDetailVC.h"
#import "TodoCollectionView.h"
#import "WeekCollectionView.h"

@interface CalendarTodoDetailVC ()<WeekCellDelegate,TodoCollectionViewDelegate>
@property (nonatomic,strong) TodoCollectionView *todoCollectionView;
@property (nonatomic,strong) WeekCollectionView *weekCollectionView;
@end

@implementation CalendarTodoDetailVC
{
    NSDate *_chosenDate;
}

#pragma mark 根据当前日期设置
- (void)setSelectedDayWithChosenDate:(NSDate *)chosenDate
{
    [_todoCollectionView getIndexPageTodoCellWithChosenDate:chosenDate];
}

#pragma mark weekCollectionView Delegate
- (void)weekCellClickedWithIndexRow:(NSInteger)indexRow
{
    [_todoCollectionView setSelectedDayTodoCellWithIndexRow:indexRow];
}

#pragma mark 拿到日页，设置周页和日页
- (void)cellSelectedByChosenDateWithIndexRow:(NSInteger)indexRow
{
    NSInteger weekIndex = ceil(indexRow/7);
    [_weekCollectionView setWeekPageWithIndexRow:weekIndex animated:NO];
    [_todoCollectionView setSelectedDayTodoCellWithIndexRow:indexRow];
}

#pragma mark todocollectionview Delegate
- (void)selectedTodoCellWithIndexRow:(NSInteger)indexRow
{
    NSInteger weekIndex = ceil(indexRow/7);
    [_weekCollectionView setWeekPageWithIndexRow:weekIndex animated:YES];

}

#pragma mark 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView
{
    _weekCollectionView = [[WeekCollectionView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_WIDTH/7)];
    _weekCollectionView.mdelegate = self;
    [self.view addSubview:_weekCollectionView];
    
    _todoCollectionView = [[TodoCollectionView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 320)];
    _todoCollectionView.mdelegate = self;
    [self.view addSubview:_todoCollectionView];
}

@end

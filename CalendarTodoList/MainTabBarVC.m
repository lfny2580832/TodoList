//
//  MainTabBarVC.m
//  CalendarTodoList
//
//  Created by 牛严 on 15/12/25.
//  Copyright © 2015年 牛严. All rights reserved.
//

#import "MainTabBarVC.h"
#import "CalendarScrollView.h"
#import <Realm/Realm.h>
#import "RLMTodoList.h"
#import "RLMThing.h"

@interface MainTabBarVC ()

@end

@implementation MainTabBarVC

#pragma mark 初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMThing *thing = [[RLMThing alloc]init];
    thing.thingType = Entertainment;
    thing.thingStr = @"play Game";
    RLMTodoList *todolistModel = [[RLMTodoList alloc]init];
    todolistModel.tableId = 20160107;
    todolistModel.timeStamp = 1111;
    todolistModel.thing = thing;
    
    [realm beginWriteTransaction];
    [RLMTodoList createOrUpdateInRealm:realm withValue:todolistModel];
    [realm commitWriteTransaction];
    
    UINavigationController *firstController = [[UINavigationController alloc]init];
//    [firstController setCustomTitle:@"TodoList" color:[UIColor redColor]];
    [firstController setTitle:@"first"];
    CalendarScrollView *scrollView = [[CalendarScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    [firstController.view addSubview:scrollView];
    
    UINavigationController *secondController = [[UINavigationController alloc]init];
    [secondController setTitle:@"second"];
    
    [self setViewControllers:@[firstController, secondController]];
    
}


@end

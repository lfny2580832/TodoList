//
//  ChooseProjectTableCell.h
//  CalendarTodoList
//
//  Created by 牛严 on 16/2/4.
//  Copyright © 2016年 牛严. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMProject;

@interface ChooseProjectTableCell : UITableViewCell

@property (nonatomic, strong) FMProject *project;

- (instancetype)initWithContentLabel;

@end

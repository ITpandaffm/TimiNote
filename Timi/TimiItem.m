//
//  TimiItem.m
//  Timi
//
//  Created by ffm on 17/1/25.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "TimiItem.h"

@implementation TimiItem

- (instancetype)initWithContent:(NSString *)content itemCost:(double)cost logoStr:(NSString *)logoStr insertTime:(NSDate *)timeStamp contentType:(BOOL )isOutcome
{
    self = [super init];
    if (self) {
        self.content = content;
        self.cost = cost;
        self.logo = logoStr;
        self.timeStamp = timeStamp;
        self.isOutcome = isOutcome;
        self.isHeader = FALSE;
    }
    return self;
}

//设置好默认值 防止未设置type然后出错
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.content = @"嗯？忘记写东西了";
        self.cost = 0.00;
        self.logo = @"icon_normal";
        self.timeStamp = [NSDate date];
        self.isOutcome = YES;
        self.isHeader = FALSE;
    }
    return self;
}

@end

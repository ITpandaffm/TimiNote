//
//  TimiItem.h
//  Timi
//
//  Created by ffm on 17/1/25.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TimiItemType) {
    TimiItemTypeIncome,          // 收入
    TimiItemTypeOutCome         // 支出
};


@interface TimiItem : NSObject


- (instancetype)initWithContent:(NSString *)content itemCost:(double )cost itemType:(TimiItemType )type;

@property (nonatomic, copy) NSString *content; //Item的内容
@property (nonatomic, assign) double cost; //金额大小
@property (nonatomic, readonly) TimiItemType type;  //内容类型



@end

//
//  TimiDelegate.h
//  Timi
//
//  Created by ffm on 17/2/1.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TimiTableViewCell;

@protocol TimiTableViewCellDelegate <NSObject>

- (void)timiCellClickEditBtn:(TimiTableViewCell *)cell;
- (void)timiCellClickDeleteBtn:(TimiTableViewCell *)cell;

@end

@protocol ItemCompleteDelegate <NSObject>

- (void)finisCompletingItem:(NSString *)contentPic contentStr:(NSString *)contentStr totalCost:(double )cost timeStamp:(NSDate *)date;

@end

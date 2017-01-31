//
//  TimiTableViewController.h
//  Timi
//
//  Created by ffm on 17/1/21.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^TotalValueChangeBlock)(double, double);

@interface TimiTableViewController<ItemCompleteDelegate> : UITableViewController

@property (nonatomic, copy) TotalValueChangeBlock totalValueChangeBlock;

@end

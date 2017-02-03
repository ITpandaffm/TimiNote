//
//  TimiTableViewController.h
//  Timi
//
//  Created by ffm on 17/1/21.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TimiTableViewController<ItemCompleteDelegate> : UITableViewController


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@end

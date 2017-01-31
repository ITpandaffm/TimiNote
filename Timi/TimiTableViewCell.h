//
//  TimiTableViewCell.h
//  Timi
//
//  Created by ffm on 17/1/21.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimiItem.h"
#import "TimiDelegate.h"




@interface TimiTableViewCell : UITableViewCell


@property (nonatomic, weak) id <TimiTableViewCellDelegate> delegate;


- (void)configureCell:(TimiItem *)item;

@end


@interface LeftCell : TimiTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end


@interface RightCell : TimiTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end




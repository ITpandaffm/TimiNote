//
//  KeyboardView.h
//  Timi
//
//  Created by ffm on 17/1/30.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimiDelegate.h"

@interface KeyboardView : UIView

@property (nonatomic, assign) BOOL isShrink;
@property (weak, nonatomic) IBOutlet UIImageView *contentLogo;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentCostLabel;

@property (nonatomic, weak) id<ItemCompleteDelegate>delegate;

@end

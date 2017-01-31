//
//  AddNoteViewController.h
//  Timi
//
//  Created by ffm on 17/1/29.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimiDelegate.h"

@interface AddNoteViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, ItemCompleteDelegate>

@property (nonatomic, weak) id<ItemCompleteDelegate> delegate;

@end

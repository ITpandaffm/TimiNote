//
//  AddNoteViewController.h
//  Timi
//
//  Created by ffm on 17/1/29.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimiDelegate.h"
#import "KeyboardView.h"
#import "AppDelegate.h"
#import "PopTransition.h"


@interface AddNoteViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, ItemCompleteDelegate,UINavigationControllerDelegate>

@property (nonatomic, weak) id<ItemCompleteDelegate> delegate;
@property (nonatomic, strong) KeyboardView *keyboardView;

@end

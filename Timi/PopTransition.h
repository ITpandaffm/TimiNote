//
//  PopTransition.h
//  Timi
//
//  Created by ffm on 17/2/3.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PopTransition : NSObject <UIViewControllerAnimatedTransitioning>

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;


@end

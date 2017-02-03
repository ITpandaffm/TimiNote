//
//  PopTransition.m
//  Timi
//
//  Created by ffm on 17/2/3.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "PopTransition.h"

@implementation PopTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalRect = [transitionContext finalFrameForViewController:toVc];
    CGRect bounds = [UIScreen mainScreen].bounds;
    toVc.view.frame = CGRectOffset(finalRect, 0, bounds.size.height);
    
    [[transitionContext containerView] addSubview:toVc.view];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromVc.view.alpha = 0.8;
        toVc.view.frame = finalRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVc.view.alpha = 1;
    }];
}



@end

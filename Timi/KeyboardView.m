//
//  KeyboardView.m
//  Timi
//
//  Created by ffm on 17/1/30.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "KeyboardView.h"
@interface KeyboardView ()

@property (weak, nonatomic) IBOutlet UILabel *contentCostLabel;


@property (nonatomic, copy) NSString *currentCost;
@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, copy) NSString *lastCost;

@end


@implementation KeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"KeyboardView" owner:self options:nil] firstObject];
    
    containerView.frame = self.bounds;
    [self addSubview:containerView];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"KeyboardView" owner:self options:nil] firstObject];
    [self addSubview:containerView];
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.currentCost = self.contentCostLabel.text;
    self.lastCost = @"";
    self.backgroundColor = [UIColor clearColor];
}


- (IBAction)clickKeyboard:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    long tag = btn.tag;

    NSString *tagStr = [NSString stringWithFormat:@"%ld",tag];
    switch (tag) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            if ([self.currentCost isEqualToString:@"$0"]) {
                [self resetKeyboard];
            }
            [self append:tagStr];
            break;
        case 10: //点击的是0键
            if (![self.currentCost isEqualToString:@"$0"]) {
                [self append:@"0"];
            }
            break;
        case 11: //点击的是C按钮（cancel
            [self resetKeyboard];
            break;
        case 12: //点击的是小数点键 要进行判断
            if (![self.currentCost isEqualToString:@"$"] && ![self.currentCost containsString:@"."]) {
                [self append:@"."];
            }
            break;
        case 13: //点击回退键
            [self deleteKeyboardLastCharacter];
            break;
        case 14:  //点击加号 进行相加运算
            [self plus];
            break;
        case 15:  //点击ok键 完成添加 获取内容进行跳转'
            [self.delegate finisCompletingItem:self.contentLogo.image contentStr:self.contentLabel.text totalCost:[self.contentCostLabel.text substringFromIndex:1].doubleValue];
            
            break;
        default:
            break;
    }
    self.contentCostLabel.text = self.currentCost;
}

- (void)append:(NSString *)str
{
  
    if (self.currentCost.length <= 14) {
        self.currentCost = [self.currentCost stringByAppendingString:str];
    } else {
        self.alertView.hidden = false;
        [UIView animateWithDuration:1 animations:^{
            self.alertView.alpha = 0;
        } completion:^(BOOL finished) {
            self.alertView.alpha = 1;
            self.alertView.hidden = true;
        }];
    }

}

- (void)resetKeyboard
{
    self.currentCost = @"$";
    self.contentCostLabel.text = self.currentCost;
    self.lastCost = @"";
}

- (void)deleteKeyboardLastCharacter
{
    if (![self.currentCost isEqualToString:@"$"]) {
        self.currentCost = [self.currentCost substringToIndex:self.currentCost.length-1];
    }
}

- (void)plus
{
    if ([self.lastCost isEqualToString:@""]) {
        self.lastCost = [self.currentCost substringFromIndex:1];
        self.currentCost = @"$";
    } else {
        if ([self.currentCost isEqualToString:@"$"]||[self.currentCost isEqualToString:@"$0"]||[self.currentCost isEqualToString:@"0."]||[self.currentCost isEqualToString:@"0.0"]) {
            self.currentCost = [NSString stringWithFormat:@"$%@",self.lastCost];
        } else {
            double lastValue = self.lastCost.doubleValue;
            double currentValue = [self.currentCost substringFromIndex:1].doubleValue;
            double result = lastValue + currentValue;
            self.currentCost = [NSString stringWithFormat:@"$%.2f",result];
            self.lastCost = [self.currentCost substringFromIndex:1];
                }
    }



}

- (UIView *)alertView
{
    if (!_alertView)
    {
        _alertView = [[[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:nil options:nil] firstObject];
        _alertView.frame = CGRectMake((self.bounds.size.width-200)/2, (self.bounds.size.height-200)/2, 200, 200);
        [self addSubview:_alertView];
    }
    return _alertView;
}


@end

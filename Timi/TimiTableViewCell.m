//
//  TimiTableViewCell.m
//  Timi
//
//  Created by ffm on 17/1/21.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "TimiTableViewCell.h"


@implementation TimiTableViewCell

- (void)configureCell:(TimiItem *)item
{
    if (item)
    {
        if ([item.content isEqualToString:@"工资"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_salary.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"日常"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_daily.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"逛街"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_shopping.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"充话费"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_phoneCharge.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"存款"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_income.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"工作"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_work.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"零食"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_food.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"聚会"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_party.png"] forState:UIControlStateNormal];
        } else if ([item.content isEqualToString:@"生日"])
        {
            [self.addBtn setImage:[UIImage imageNamed:@"icon_birthday.png"] forState:UIControlStateNormal];
        }
        
        [self setValue:[NSString stringWithFormat:@"%@ %.2f",item.content,item.cost] forKeyPath:@"descriptionLabel.text"];
    }
}

@end


@implementation LeftCell


@end

@implementation RightCell




@end


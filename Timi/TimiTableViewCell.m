//
//  TimiTableViewCell.m
//  Timi
//
//  Created by ffm on 17/1/21.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "TimiTableViewCell.h"


@interface TimiTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, assign) BOOL isExpand;
@property (weak, nonatomic) IBOutlet UIView *dotView;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation TimiTableViewCell



- (void)configureCell:(TimiItem *)item
{
    if (item)
    {
        if (item.isHeader) {
            self.timeStampLabel.text = [item.timeStamp.description substringToIndex:10];
            self.dotView.hidden = false;
            self.dotView.layer.cornerRadius = 2.5;
        } else {
            self.timeStampLabel.hidden = YES;
            self.dotView.hidden = YES;
        }
        
        [self.addBtn setImage:[UIImage imageNamed:item.logo] forState:UIControlStateNormal];
        [self setValue:[NSString stringWithFormat:@"%@ %.2f",item.content,item.cost] forKeyPath:@"descriptionLabel.text"];
        [self close];
        
    }
}


//上面的setValue:fotKeyPath:如果keyPath找不到的话 就会调用下面的这个方法，所以重写一些
- (void)setNilValueForKey:(NSString *)key
{
    [super setNilValueForKey:key];
    NSLog(@"nil key");
}

- (IBAction)clickMidBtn:(id)sender {
    
    if (self.isExpand) {
        [self close];
    } else
    {
        [self expand];
    }
}

- (void)expand
{
    self.editBtn.hidden = false;
    self.editBtn.enabled = true;
    self.deleteBtn.hidden = false;
    self.deleteBtn.enabled = true;
//    [self setValue:@"true" forKeyPath:@"descriptionLabel.hidden"];

    CGRect currentRect = self.addBtn.frame;
    CGRect leftRect = CGRectMake(currentRect.origin.x-100, currentRect.origin.y, currentRect.size.width, currentRect.size.height);
      CGRect rightRect = CGRectMake(currentRect.origin.x+100, currentRect.origin.y, currentRect.size.width, currentRect.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.editBtn.frame = leftRect;
        self.deleteBtn.frame = rightRect;
        [self setValue:@"0.0" forKeyPath:@"descriptionLabel.alpha"];
    } completion:^(BOOL finished) {
        self.isExpand = true;
    }];
    
}

- (void)close
{
    [UIView animateWithDuration:0.3 animations:^{
        self.editBtn.frame = self.addBtn.frame;
        self.deleteBtn.frame = self.addBtn.frame;
        [self setValue:@"1.0" forKeyPath:@"descriptionLabel.alpha"];
    } completion:^(BOOL finished) {
        self.editBtn.hidden = true;
        self.deleteBtn.hidden = true;
        self.editBtn.enabled = false;
        self.deleteBtn.enabled = false;
        self.isExpand = false;
//        [self setValue:@"false" forKeyPath:@"descriptionLabel.hidden"];
    }];
}

- (IBAction)clickEditBtn:(id)sender {
    [self.delegate timiCellClickEditBtn:self];
}


- (IBAction)clickDeleteBtn:(id)sender {
    [self.delegate timiCellClickDeleteBtn:self];
}


#pragma mark 懒加载
//- (NSDate *)currentDate
//{
//    if(!_currentDate) {
//        _currentDate = [NSDate date];
//    }
//    return _currentDate;
//}
@end


@implementation LeftCell



@end

@implementation RightCell




@end


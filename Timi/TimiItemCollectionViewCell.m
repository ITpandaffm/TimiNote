//
//  TimiItemCollectionViewCell.m
//  Timi
//
//  Created by ffm on 17/1/31.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "TimiItemCollectionViewCell.h"

@interface TimiItemCollectionViewCell ()


@end


@implementation TimiItemCollectionViewCell


+ (instancetype)createCell:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)identifier
{
    TimiItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[TimiItemCollectionViewCell alloc] init];
    }
    return cell;
}


- (void)setCellImage:(UIImage *)cellImage
{
    if (_cellImage != cellImage)
    {
        [_cellImage setAccessibilityIdentifier:[cellImage accessibilityIdentifier]];
        _cellImage = cellImage;
    }
    self.cellPic.image = cellImage;
    self.cellPic.bounds = CGRectMake(0, 0, 32, 32);
    self.cellPic.center = self.contentView.center;
    [self.contentView addSubview:_cellPic];
}

#pragma mark 懒加载

- (UIImageView *)cellPic
{
    if (!_cellPic) {
        _cellPic = [[UIImageView alloc] init];
    }
    return _cellPic;
}

- (UILabel *)cellLabel
{
    if (!_cellLabel)
    {
        _cellLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.bounds.size.width-30)/2, self.contentView.bounds.size.height-30, 30, 30)];
        _cellLabel.adjustsFontSizeToFitWidth = YES;
        _cellLabel.text = @"默认值";
        _cellLabel.textColor = [UIColor blueColor];
        [self.contentView addSubview:_cellLabel];
    }
    return _cellLabel;
}



@end

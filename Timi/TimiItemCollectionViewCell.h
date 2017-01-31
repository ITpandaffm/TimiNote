//
//  TimiItemCollectionViewCell.h
//  Timi
//
//  Created by ffm on 17/1/31.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimiItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *cellImage;
@property (nonatomic, strong) UILabel *cellLabel;

@property (nonatomic, strong) UIImageView *cellPic;



+ (instancetype)createCell:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)identifier;

@end

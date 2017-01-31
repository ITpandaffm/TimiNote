//
//  AddNoteViewController.m
//  Timi
//
//  Created by ffm on 17/1/29.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "AddNoteViewController.h"
#import "KeyboardView.h"
#import "TimiItemCollectionViewCell.h"

static NSString *cellIdentifier = @"collectionViewCell";


@interface AddNoteViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *itemNameArr;
@property (nonatomic, strong) NSArray *itemPicArr;

@property (nonatomic, strong) KeyboardView *keyboardView;

@property (nonatomic, strong) UIImageView *cellImageView;
@property (nonatomic, strong) TimiItemCollectionViewCell *selectedCell;


@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view sendSubviewToBack:self.keyboardView];
    [self collectionView];
    [self keyboardView];

}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemNameArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TimiItemCollectionViewCell *cell = [TimiItemCollectionViewCell createCell:collectionView cellForItemAtIndexPath:indexPath reuseIdentifier:cellIdentifier];
    cell.cellLabel.text = self.itemNameArr[indexPath.item];
    cell.cellImage = [UIImage imageNamed:self.itemPicArr[indexPath.item]];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.keyboardView.isShrink) {
        CGRect expandRect = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
        [UIView animateWithDuration:0.5 animations:^{
            self.keyboardView.frame = expandRect;
        } completion:^(BOOL finished) {
            self.keyboardView.isShrink = false;
        }];
    }
    TimiItemCollectionViewCell *selectedCell = (TimiItemCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.selectedCell = selectedCell;
    self.cellImageView.image = selectedCell.cellImage;
    self.cellImageView.frame = CGRectMake(selectedCell.frame.origin.x+selectedCell.cellPic.frame.origin.x,selectedCell.frame.origin.y+selectedCell.cellPic.frame.origin.y, 32, 32);
    [self.collectionView addSubview:self.cellImageView];
    CABasicAnimation *leftUpAnimation = [[CABasicAnimation alloc] init];
    
    leftUpAnimation.duration = 0.3;
    leftUpAnimation.keyPath = @"position";
    leftUpAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.cellImageView.center.x-50, self.cellImageView.center.y-50)];
    leftUpAnimation.delegate = self;

    [leftUpAnimation setValue:@"first" forKey:@"leftUpAnimation"];
    [self.cellImageView.layer addAnimation:leftUpAnimation forKey:@"leftUpAnimation"];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGRect shrinkRect = CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 290);
    [UIView animateWithDuration:0.5 animations:^{
        self.keyboardView.frame = shrinkRect;
    } completion:^(BOOL finished) {
        self.keyboardView.isShrink = YES;
    }];
    [self.collectionView flashScrollIndicators];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    if (anim == [self.cellImageView.layer animationForKey:@"leftUpAnimation"]) {
    if ([[anim valueForKey:@"leftUpAnimation"] isEqualToString:@"first"]) {
        CAKeyframeAnimation *bezierTranslateAnimation = [[CAKeyframeAnimation alloc] init];
        bezierTranslateAnimation.duration = 0.8;
        
        //先判断键盘的状态，再决定到哪个点
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.cellImageView.center.x-50, self.cellImageView.center.y-50)];
        if (!self.keyboardView.isShrink) {
            [path addQuadCurveToPoint:CGPointMake(20, self.view.bounds.size.height-325) controlPoint:CGPointMake(20, self.view.bounds.size.height-325)];
        } else if (self.keyboardView.isShrink) {
            [path addQuadCurveToPoint:CGPointMake(20, self.view.bounds.size.height-100) controlPoint:CGPointMake(20, self.view.bounds.size.height-50)];
        }
        bezierTranslateAnimation.keyPath = @"position";
        bezierTranslateAnimation.path = path.CGPath;
        bezierTranslateAnimation.delegate = self;
        
        [bezierTranslateAnimation setValue:@"second" forKey:@"bezierTranslateAnimation"];
        [self.cellImageView.layer addAnimation:bezierTranslateAnimation forKey:@"bezierTranslateAnimation"];
    } else if ([[anim valueForKey:@"bezierTranslateAnimation"] isEqualToString:@"second"]) {
        self.keyboardView.contentLogo.image = self.selectedCell.cellImage;
        self.keyboardView.contentLabel.text = self.selectedCell.cellLabel.text;
    }
        
        
    
    

    
}
#pragma mark - ItemCompleteDelegate
- (void)finisCompletingItem:(UIImage *)contentPic contentStr:(NSString *)contentStr totalCost:(double)cost
{
    [self.delegate finisCompletingItem:contentPic contentStr:contentStr totalCost:cost];
    [self.navigationController popViewControllerAnimated:YES];
}





#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(80, 80);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
//        _collectionView.backgroundColor = [UIColor yellowColor];
        [_collectionView registerClass:[TimiItemCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (KeyboardView *)keyboardView
{
    if (!_keyboardView)
    {
        _keyboardView = [[KeyboardView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290)];
        _keyboardView.backgroundColor = [UIColor clearColor];
        _keyboardView.isShrink = false;
        _keyboardView.delegate = self;
        [self.view addSubview:_keyboardView];
    }
    return _keyboardView;
}

- (NSArray *)itemNameArr
{
    if (!_itemNameArr)
    {
        _itemNameArr = @[@"工资",@"日常",@"就餐",@"零食",@"充值",@"购物",@"娱乐",@"雪糕",@"生日",@"鞋帽",@"聚会",@"礼物",@"收入",@"工作",@"运动",@"普通"];
    }
    return _itemNameArr;
}

- (NSArray *)itemPicArr
{
    if (!_itemPicArr) {
        _itemPicArr = @[@"icon_salary.png",@"icon_daily.png",@"icon_dinner.png",@"icon_food.png",@"icon_phoneCharge.png",@"icon_shopping.png",@"icon_chess.png",@"icon_icecream.png",@"icon_birthday.png",@"icon_shoe.png",@"icon_party.png",@"icon_gift.png",@"icon_income.png",@"icon_work.png",@"icon_sport.png",@"icon_normal.png"];
    }
    return _itemPicArr;
}


- (UIImageView *)cellImageView
{
    if (!_cellImageView) {
        _cellImageView = [[UIImageView alloc] init];
    }
    return _cellImageView;
}

- (TimiItemCollectionViewCell *)selectedCell
{
    if (!_selectedCell) {
        _selectedCell = [[TimiItemCollectionViewCell alloc] init];
    }
    return _selectedCell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

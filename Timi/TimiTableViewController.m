//
//  TimiTableViewController.m
//  Timi
//
//  Created by ffm on 17/1/21.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "TimiTableViewController.h"
#import "TimiTableViewCell.h"
#import "AddNoteViewController.h"
#import "TimiDelegate.h"

@interface TimiTableViewController  () <TimiTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *itemArr;
@property (nonatomic, assign) double totalIncome;
@property (nonatomic, assign) double totalOutcome;
@property (weak, nonatomic)  UILabel *totalIncomeLabel;
@property (weak, nonatomic)  UILabel *totalOutcomeLabel;

@end

@implementation TimiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] firstObject];
    self.tableView.tableHeaderView = headerView;
    
    self.totalIncomeLabel = [headerView viewWithTag:2];
    self.totalOutcomeLabel = [headerView viewWithTag:3];
    UIButton *addBtn = [headerView viewWithTag:1];
    [addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAddBtn
{
    AddNoteViewController *con = [[AddNoteViewController alloc] init];
    con.delegate = self;
    con.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:con animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimiItem *item = self.itemArr[indexPath.row];
    NSString *identifier = @"";
    if (item.type == TimiItemTypeOutCome) {
        identifier = @"RightCell";
    } else if (item.type == TimiItemTypeIncome) {
        identifier = @"LeftCell";
    }

    TimiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell.delegate) {
        cell.delegate = self;
    }
    
    [self calculateTotalValue:item];
    [cell configureCell:item];
    return cell;
}

- (void)calculateTotalValue:(TimiItem *)item
{
    if (item.type == TimiItemTypeIncome) {
        self.totalIncome += item.cost;
    } else if (item.type == TimiItemTypeOutCome) {
        self.totalOutcome += item.cost;
    }
    self.totalIncomeLabel.text = [NSString stringWithFormat:@"%.2f",self.totalIncome];
    self.totalOutcomeLabel.text = [NSString stringWithFormat:@"%.2f",self.totalOutcome];
}


//从效率来讲应该是定义为总收入总支出两个属性，每次修改的时候直接在原有基础上修改就好
//但目前 重新算一遍就好了
- (void)calculateTotalValue
{
    double totalIncome,totalOutcome=0;
    for (TimiItem *item in self.itemArr) {
        if (item.type == TimiItemTypeIncome)
        {
            totalIncome += item.cost;
        } else if (item.type == TimiItemTypeOutCome)
        {
            totalOutcome += item.cost;
        }
    }
    if (self.totalValueChangeBlock) {
        self.totalValueChangeBlock(totalIncome, totalOutcome);
    }
}

#pragma mark TimiTableViewCellDelegate
- (void)timiCellClickEditBtn:(TimiTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    TimiItem *item = self.itemArr[indexPath.row];
    
    AddNoteViewController *addCon = [[AddNoteViewController alloc] init];
    addCon.delegate = self;
    addCon.view.backgroundColor = [UIColor whiteColor];
    addCon.keyboardView.contentLabel.text = item.content;
    addCon.keyboardView.contentCostLabel.text = [NSString stringWithFormat:@"$%.2f",item.cost];
    [self.navigationController pushViewController:addCon animated:YES];
}

- (void)timiCellClickDeleteBtn:(TimiTableViewCell *)cell
{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"FBI WARNING" message:@"确定要删除？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self.itemArr removeObjectAtIndex:indexPath.row];
        
        self.totalOutcome = 0;
        self.totalIncome = 0;
        [self.tableView reloadData];
    }]; //UIAlertAction相当于一种封装了触发方法的选项按钮
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]; //UIAlertAction相当于一种封装了触发方法的选项按钮
    [alertView addAction:action];
    [alertView addAction:action2];
    //    [self.navigationController pushViewController:alertView animated:YES];
    [self presentViewController:alertView animated:YES completion:^{
        
    }];

}

#pragma mark - ItemCompleteDelegate
- (void)finisCompletingItem:(UIImage *)contentPic contentStr:(NSString *)contentStr totalCost:(double)cost
{
    TimiItem *item = [[TimiItem alloc] initWithContent:contentStr itemCost:cost itemType:TimiItemTypeOutCome];
    [self.itemArr addObject:item];
    [self.tableView reloadData];
}


#pragma mark 懒加载
- (NSMutableArray *)itemArr
{
    if (!_itemArr)
    {
        _itemArr = [NSMutableArray array];
        TimiItem *item0 = [[TimiItem alloc] initWithContent:@"工资" itemCost:16000 itemType:TimiItemTypeIncome];
        TimiItem *item1 = [[TimiItem alloc] initWithContent:@"日常" itemCost:1000 itemType:TimiItemTypeOutCome];
        TimiItem *item2 = [[TimiItem alloc] initWithContent:@"就餐" itemCost:500 itemType:TimiItemTypeOutCome];
        TimiItem *item3 = [[TimiItem alloc] initWithContent:@"零食" itemCost:3000 itemType:TimiItemTypeOutCome];
        TimiItem *item4 = [[TimiItem alloc] initWithContent:@"充值" itemCost:2000 itemType:TimiItemTypeIncome];
        TimiItem *item5 = [[TimiItem alloc] initWithContent:@"购物" itemCost:6000 itemType:TimiItemTypeIncome];
        TimiItem *item6 = [[TimiItem alloc] initWithContent:@"娱乐" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item7 = [[TimiItem alloc] initWithContent:@"雪糕" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item8 = [[TimiItem alloc] initWithContent:@"生日" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item9 = [[TimiItem alloc] initWithContent:@"鞋帽" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item10 = [[TimiItem alloc] initWithContent:@"聚会" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item11 = [[TimiItem alloc] initWithContent:@"买礼物" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item12 = [[TimiItem alloc] initWithContent:@"收入" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item13 = [[TimiItem alloc] initWithContent:@"工作" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item14 = [[TimiItem alloc] initWithContent:@"运动" itemCost:380 itemType:TimiItemTypeOutCome];
        TimiItem *item15 = [[TimiItem alloc] initWithContent:@"普通" itemCost:380 itemType:TimiItemTypeOutCome];
        
        [_itemArr addObject:item0];
        [_itemArr addObject:item1];
        [_itemArr addObject:item2];
        [_itemArr addObject:item3];
        [_itemArr addObject:item4];
        [_itemArr addObject:item5];
        [_itemArr addObject:item6];
        [_itemArr addObject:item7];
        [_itemArr addObject:item8];
        [_itemArr addObject:item9];
        [_itemArr addObject:item10];
        [_itemArr addObject:item11];
        [_itemArr addObject:item12];
        [_itemArr addObject:item13];
        [_itemArr addObject:item14];
        [_itemArr addObject:item15];
        
    }
    return _itemArr;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"llal");
}


@end

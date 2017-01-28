//
//  TimiTableViewController.m
//  Timi
//
//  Created by ffm on 17/1/21.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "TimiTableViewController.h"
#import "TimiTableViewCell.h"

@interface TimiTableViewController ()

@property (nonatomic, strong) NSMutableArray *itemArr;


@end

@implementation TimiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
    [cell configureCell:item];
    return cell;
}

#pragma mark 懒加载
- (NSMutableArray *)itemArr
{
    if (!_itemArr)
    {
        _itemArr = [NSMutableArray array];
        TimiItem *item0 = [[TimiItem alloc] initWithContent:@"工资" itemCost:16000 itemType:TimiItemTypeIncome];
        TimiItem *item1 = [[TimiItem alloc] initWithContent:@"日常" itemCost:1000 itemType:TimiItemTypeOutCome];
        TimiItem *item2 = [[TimiItem alloc] initWithContent:@"逛街" itemCost:500 itemType:TimiItemTypeOutCome];
        TimiItem *item3 = [[TimiItem alloc] initWithContent:@"充话费" itemCost:3000 itemType:TimiItemTypeOutCome];
        TimiItem *item4 = [[TimiItem alloc] initWithContent:@"存款" itemCost:2000 itemType:TimiItemTypeIncome];
        TimiItem *item5 = [[TimiItem alloc] initWithContent:@"工作" itemCost:6000 itemType:TimiItemTypeIncome];
        TimiItem *item6 = [[TimiItem alloc] initWithContent:@"零食" itemCost:380 itemType:TimiItemTypeOutCome];
        [_itemArr addObject:item0];
        [_itemArr addObject:item1];
        [_itemArr addObject:item2];
        [_itemArr addObject:item3];
        [_itemArr addObject:item4];
        [_itemArr addObject:item5];
        [_itemArr addObject:item6];
    }
    return _itemArr;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  AddNoteViewController.m
//  Timi
//
//  Created by ffm on 17/1/29.
//  Copyright © 2017年 ITPanda. All rights reserved.
//

#import "AddNoteViewController.h"
#import "KeyboardView.h"


@interface AddNoteViewController ()

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KeyboardView *view = [[KeyboardView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
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

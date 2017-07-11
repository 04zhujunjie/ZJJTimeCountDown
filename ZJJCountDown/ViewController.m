//
//  ViewController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/10.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "TableViewGroupController.h"
#import "ZJJCollectionViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tableViewPlainClick:(id)sender {
    
    [self.navigationController pushViewController:[TableViewController new] animated:YES];
}
- (IBAction)tableViewGroupedClick:(id)sender {
    
    [self.navigationController pushViewController:[TableViewGroupController new] animated:YES];
}
- (IBAction)collectionViewClick:(id)sender {
    
       [self.navigationController pushViewController:[ZJJCollectionViewController new] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

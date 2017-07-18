//
//  MainViewController.m
//  ZJJCountDown
//
//  Created by xiaozhu on 2017/7/15.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewController.h"
#import "ZJJVerificationController.h"
#import "ZJJCollectionViewController.h"
#import "TableViewGroupController.h"
#import "ZJJRegularlyViewController.h"



static NSString *cellID = @"cellID";

@interface MainViewController ()
@property (nonatomic ,strong) NSArray *titleArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"倒计时";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    _titleArray = @[@"非动态Cell",@"TableView分组",@"TableView不分组",@"CollectionView",@"获取验证码"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *title = self.titleArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            
            ZJJRegularlyViewController *VC = [[ZJJRegularlyViewController alloc] initWithNibName:NSStringFromClass([ZJJRegularlyViewController class]) bundle:nil];
            VC.title = title;
          [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1:
        {
            TableViewGroupController *VC = [TableViewGroupController new];
            VC.title = title;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 2:
        {
            TableViewController *VC = [TableViewController new];
            VC.title = title;
              [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 3:
        {
            ZJJCollectionViewController *VC = [ZJJCollectionViewController new];
            VC.title = title;
              [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 4:
        {
            ZJJVerificationController *VC = [ZJJVerificationController new];
            VC.title = title;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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

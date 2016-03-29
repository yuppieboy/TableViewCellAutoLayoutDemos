//
//  ViewController.m
//  TableViewCellAutoLayoutTest
//
//  Created by WangPeng on 16/3/29.
//  Copyright © 2016年 weiwend. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation T1Cell

@end

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%s",__FUNCTION__);
    dataArr=[[NSMutableArray alloc]init];
    NSArray *temp=[NSArray arrayWithObjects:@"测试数据",@"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据",@"测试数据",@"测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据",@"测试数据",@"测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据",@"测试数据",@"测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据", nil];
    for (int i=0; i<100; i++) {
        [dataArr addObjectsFromArray:temp];
    }


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    T1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"T1Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(T1Cell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//    cell.entity = self.feedEntitySections[indexPath.section][indexPath.row];
    
    cell.myLabel.text = [dataArr objectAtIndex:indexPath.row];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:@"T1Cell" cacheByIndexPath:indexPath configuration:^(T1Cell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
}


//预估行高，如果行数过多，避免第一次加载的时候卡住主线程
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

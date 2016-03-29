//
//  ViewController.m
//  CellTest
//
//  Created by WangPeng on 16/3/28.
//  Copyright © 2016年 weiwend. All rights reserved.
//

#import "ViewController.h"
#import "C1.h"

static NSString *reuseIdentifier=@"C1";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataArr;
}
// A dictionary of offscreen cells that are used within the tableView:heightForRowAtIndexPath: method to
// handle the height calculations. These are never drawn onscreen. The dictionary is in the format:
//      { NSString *reuseIdentifier : UITableViewCell *offscreenCell, ... }
@property (strong, nonatomic) NSMutableDictionary *offscreenCells;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataArr=[[NSMutableArray alloc]init];
    NSArray *temp=[NSArray arrayWithObjects:@"测试数据",@"测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据",@"测试数据",@"测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据",@"测试数据",@"测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据",@"测试数据",@"测试数据测试数据测试数据测试数据测试数据",@"测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据数据测试数据测试数据测试数据", nil];
    for (int i=0; i<10; i++) {
        [dataArr addObjectsFromArray:temp];
    }
    self.offscreenCells = [NSMutableDictionary dictionary];
    self.tableview.estimatedRowHeight = UITableViewAutomaticDimension;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C1 *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.myLabel.text=[dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    C1 *cell = [self.offscreenCells objectForKey:reuseIdentifier];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        [self.offscreenCells setObject:cell forKey:reuseIdentifier];
    }
    cell.myLabel.text = [dataArr objectAtIndex:indexPath.row];
    cell.myLabel.preferredMaxLayoutWidth=CGRectGetWidth(tableView.bounds)-20;
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    // The cell's width must be set to the same size it will end up at once it is in the table view.
    // This is important so that we'll get the correct height for different table view widths, since our cell's
    // height depends on its width due to the multi-line UILabel word wrapping. Don't need to do this above in
    // -[tableView:cellForRowAtIndexPath:] because it happens automatically when the cell is used in the table view.
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    // NOTE: if you are displaying a section index (e.g. alphabet along the right side of the table view), or
    // if you are using a grouped table view style where cells have insets to the edges of the table view,
    // you'll need to adjust the cell.bounds.size.width to be smaller than the full width of the table view we just
    // set it to above. See http://stackoverflow.com/questions/3647242 for discussion on the section index width.
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    if([cell.contentView respondsToSelector:@selector(systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority:)])
    {
        height=[cell.contentView systemLayoutSizeFittingSize:CGSizeMake(CGRectGetWidth(cell.bounds), 0) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel].height;
    }
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

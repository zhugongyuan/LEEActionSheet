
/*!
 *  @header DemoTableViewController.m
 *          LEEActionSheetDemo
 *
 *  @brief  示例列表
 *
 *  @author 李响
 *  @copyright    Copyright © 2016年 lee. All rights reserved.
 *  @version    16/4/26.
 */

#import "DemoTableViewController.h"

#import "LEEActionSheet.h"

#import "ShareView.h"

@interface DemoTableViewController ()

@property (nonatomic , strong ) NSArray *titleArray;

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"示例列表";
    
    _titleArray = @[@"打开分享"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - 打开分享

- (void)openShare{
    
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    //初始化分享视图
    
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(10, 0, (screenWidth > screenHeight ? screenHeight : screenWidth) - 40.0f, 0) InfoArray:nil MaxLineNumber:2 MaxSingleCount:3];
    
    shareView.OpenShareBlock = ^(ShareType type){
        
        NSLog(@"%d" , type);
        
        //关闭自定义LEEActionSheet
        
        [LEEActionSheet closeCustomActionSheet];
        
    };
    
    //使用自定义类型的LEEActionSheet显示分享视图
    
    [LEEActionSheet actionSheet].custom.config
    .LeeCustomView(shareView) //添加分享视图
    .LeeAddCustomButton(^(UIButton *button){
        
        [button setTitle:@"取消" forState:UIControlStateNormal]; //添加一个按钮 并设置标题为取消
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal]; //设置按钮标题颜色
    })
    .LeeCustomActionSheetViewColor([UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f]) //设置ActionSheet视图颜色
    .LeeCustomActionSheetTouchClose() //设置可以点击背景关闭
    .LeeShow();
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            //打开分享
            
            [self openShare];
            
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


/*!
 *  @header CustomViewController.m
 *          LEEActionSheetDemo
 *
 *  @brief  自定义ActionSheet视图控制器
 *
 *  @author LEE
 *  @copyright    Copyright © 2016年 lee. All rights reserved.
 *  @version    16/4/15.
 */

#import "CustomViewController.h"

#import "LEEActionSheet.h"

@implementation CustomViewController
{
    
    CGFloat screenWidth; //屏幕宽度
    
    CGFloat screenHeight; //屏幕高度
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化子视图
    
    [self initSubviews];
    
}

- (void)initSubviews{
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button1.frame = CGRectMake(20, 60, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button1 setTitle:@"弹出自定义ActionSheet" forState:UIControlStateNormal];
    
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button2.frame = CGRectMake(20, 120, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button2 setTitle:@"弹出自定义ActionSheet" forState:UIControlStateNormal];
    
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button2];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button3.frame = CGRectMake(20, 180, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button3 setTitle:@"弹出自定义ActionSheet" forState:UIControlStateNormal];
    
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button3];
    
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button4.frame = CGRectMake(20, 240, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button4 setTitle:@"弹出自定义ActionSheet" forState:UIControlStateNormal];
    
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button5.frame = CGRectMake(20, 300, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button5 setTitle:@"弹出自定义ActionSheet" forState:UIControlStateNormal];
    
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button5];
    
    
    UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(0, 400, CGRectGetWidth(self.view.frame), 200)];
    
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮点击事件

- (void)button1Action{
    
    //一个按钮的ActionSheet
    
    [LEEActionSheet actionSheet].custom.config
    .LeeAddButton(@"按钮1" , ^(){
        
        NSLog(@"点击了按钮1");
        
    })
    .LeeShow();

}

- (void)button2Action{
    
    //多个按钮并带取消按钮的ActionSheet
    
    [LEEActionSheet actionSheet].custom.config
    .LeeCancelButtonAction(^(){
    
        NSLog(@"点击了取消按钮");
        
    })
    .LeeAddButton(@"按钮1" , ^(){
        
        NSLog(@"点击了按钮1");
        
    })
    .LeeAddButton(@"按钮2" , ^(){
        
        NSLog(@"点击了按钮2");
        
    })
    .LeeAddButton(@"按钮3" , ^(){
        
        NSLog(@"点击了按钮3");
        
    })
    .LeeAddButton(@"按钮4" , ^(){
        
        NSLog(@"点击了按钮4");
        
    })
    .LeeShow();
    
    
}


- (void)button3Action{
    
    //多个按钮并带有标题内容的ActionSheet
    
    [LEEActionSheet actionSheet].custom.config
    .LeeTitle(@"标题")
    .LeeContent(@"内容")
    .LeeAddButton(@"按钮1" , ^(){
        
        NSLog(@"点击了按钮1");
        
    })
    .LeeAddButton(@"按钮2" , ^(){
        
        NSLog(@"点击了按钮2");
        
    })
    .LeeAddButton(@"按钮3" , ^(){
        
        NSLog(@"点击了按钮3");
        
    })
    .LeeAddButton(@"按钮4" , ^(){
        
        NSLog(@"点击了按钮4");
        
    })
    .LeeShow();
    
}


- (void)button4Action{
    
    //带标题内容 销毁按钮和取消按钮以及多个自定义按钮的ActionSheet
    
    [LEEActionSheet actionSheet].custom.config
    .LeeTitle(@"标题")
    .LeeContent(@"内容")
    .LeeCancelButtonTitle(@"取消")
    .LeeCancelButtonAction(^(){
        
        NSLog(@"点击了取消按钮");
        
    })
    .LeeDestructiveButtonAction(^(){
        
        NSLog(@"点击了销毁按钮");
        
    })
    .LeeAddButton(@"按钮1" , ^(){
        
        NSLog(@"点击了按钮1");
        
    })
    .LeeAddButton(@"按钮2" , ^(){
        
        NSLog(@"点击了按钮2");
        
    })
    
    .LeeAddButton(@"按钮3" , ^(){
        
        NSLog(@"点击了按钮3");
        
    })
    .LeeAddButton(@"按钮4" , ^(){
        
        NSLog(@"点击了按钮4");
        
    })
    .LeeShow();
    
}

- (void)button5Action{
    
    screenWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    /**
     下面为全部自定义设置方法的演示说明
     */
    
    //初始化一个自定义视图
    
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 260, 100)];
    
    customView.backgroundColor = [UIColor grayColor];
    
    UIButton *customViewCloseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    customViewCloseButton.frame = CGRectMake(0, 0, 150, 30);
    
    [customViewCloseButton setBackgroundColor:[UIColor lightGrayColor]];
    
    [customViewCloseButton setTitle:@"关闭ActionSheet" forState:UIControlStateNormal];
    
    [customViewCloseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [customViewCloseButton addTarget:self action:@selector(customViewCloseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:customViewCloseButton];
    
    UIButton *customViewChangeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    customViewChangeButton.frame = CGRectMake(0, 30, 150, 30);
    
    [customViewChangeButton setBackgroundColor:[UIColor blackColor]];
    
    [customViewChangeButton setTitle:@"改变自定义视图大小" forState:UIControlStateNormal];
    
    [customViewChangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [customViewChangeButton addTarget:self action:@selector(customViewChangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:customViewChangeButton];
    
    [LEEActionSheet actionSheet].custom.config
    .LeeCustomTitle(^(UILabel *label){
        
        //自定义标题Label
        
    })
    .LeeTitle(@"自定义标题")    //添加标题
    .LeeContent(@"自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容自定义内容")   //添加内容
    .LeeCustomContent(^(UILabel *label){
        
        //自定义内容Label
        
    })
    .LeeCustomView(customView) //添加自定义视图
    .LeeAddButton(@"添加的按钮" , ^(){
        
        //添加按钮 传入按钮标题 和点击事件的Block
        
        NSLog(@"点击了添加的按钮");
        
    })
    .LeeCancelButtonTitle(@"取消")   //设置取消按钮标题
    .LeeCancelButtonAction(^(){
        
        //获取取消按钮点击事件
        
        NSLog(@"点击了取消按钮");
        
    })
    .LeeCustomCancelButton(^(UIButton *button){
        
        //自定义取消按钮
        
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
    })
    .LeeDestructiveButtonTitle(@"销毁")   //设置销毁按钮标题
    .LeeDestructiveButtonAction(^(){
        
        //获取销毁按钮点击事件
        
        NSLog(@"点击了销毁按钮");
        
    })
    .LeeAddCustomButton(^(UIButton *button){
        
        //添加自定义按钮 设置按钮字体颜色为灰色(演示用)
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    })
    .LeeAddCustomButton(^(UIButton *button){
        
        //button为你添加的自定义按钮对象 , 这里可以随意自定义button对象的属性 , 但注意一点: 尽量不要修改button的frame 可能会造成位置错乱
        //如果需要特殊样式的button 建议在customView中自行玩耍
        
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
    })
    .LeeCustomCornerRadius(15.0f)  //设置自定义ActionSheet的圆角半径 默认为 15
    .LeeCustomActionSheetMaxWidth((screenWidth > screenHeight ? screenHeight : screenWidth) - 20.0f)   //设置自定义ActionSheet的最大宽度 默认为屏幕宽度减20左右边距
    .LeeCustomActionSheetMaxHeight((screenWidth > screenHeight ? screenWidth : screenHeight) - 20.0f)   //设置自定义ActionSheet的最大高度 默认为屏幕高度减20上下边距
    .LeeCustomSubViewMargin(10.0f)  //设置自定义ActionSheet的子控件上下边距 默认为 10
    .LeeCustomTopSubViewMargin(20.0f)   //设置自定义ActionSheet的第一个子控件距离ActionSheet上边缘的边距 默认 20
    .LeeCustomBottomSubViewMargin(20.0f)   //设置自定义ActionSheet的第一个子控件距离ActionSheet下边缘的边距 (如果有按钮存在 则是距离按钮部分的边距) 默认 20
    .LeeCustomLeftSubViewMargin(20.0f)   //设置自定义ActionSheet的子控件距离左侧边缘间距 //默认为20
    .LeeCustomRightSubViewMargin(20.0f)   //设置自定义ActionSheet的子控件距离右侧边缘间距 //默认为20
    .LeeCustomActionSheetOpenAnimationDuration(0.3f)   //设置自定义ActionSheet的打开动画效果时长 默认0.3秒
    .LeeCustomActionSheetCloseAnimationDuration(0.2f)   //设置自定义ActionSheet的关闭动画效果时长 默认0.2秒
    .LeeCustomActionSheetViewColor([UIColor whiteColor])   //设置自定义ActionSheet的颜色 默认为白色
    .LeeCustomActionSheetViewBackGroundColor([UIColor blackColor])   //设置自定义ActionSheet的半透明或者模糊的背景渲染颜色
    .LeeCustomActionSheetTouchClose()   //设置自定义ActionSheet的背景点击关闭功能
    .LeeCustomButtonClickNotClose()   //设置自定义ActionSheet的自定义按钮点击不关闭ActionSheet
    .LeeCustomActionSheetViewBackGroundStypeBlur()   //设置自定义ActionSheet的背景样式为高斯模糊样式 如果不设置这项 默认为半透明样式
    .LeeShow();    //显示ActionSheet
    
}

#pragma mark - 自定义视图改变按钮点击事件

- (void)customViewChangeButtonAction:(UIButton *)sender{
    
    [UIView beginAnimations:@"" context:NULL];
    
    UIView *customView = sender.superview;
    
    CGRect customViewFrame = customView.frame;
    
    if (customViewFrame.size.height == 200) {
        
        customViewFrame.size.height = 100;
        
    } else {
        
        customViewFrame.size.height = 200;
    }
    
    customView.frame = customViewFrame;
    
    [UIView commitAnimations];
    
}

#pragma mark - 自定义视图关闭按钮点击事件

- (void)customViewCloseButtonAction:(UIButton *)sender{
    
    //关闭自定义ActionSheet
    
    [LEEActionSheet closeCustomActionSheet];
    
}

@end

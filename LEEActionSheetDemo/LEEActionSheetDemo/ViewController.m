
/*!
 *  @header ViewController.m
 *          LEEActionSheetDemo
 *
 *  @brief  系统ActionSheet视图控制器
 *
 *  @author LEE
 *  @copyright    Copyright © 2016年 lee. All rights reserved.
 *  @version    16/4/15.
 */

#import "ViewController.h"

#import "LEEActionSheet.h"

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化子视图
    
    [self initSubviews];
    
}

- (void)initSubviews{
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button1.frame = CGRectMake(20, 60, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button1 setTitle:@"弹出系统ActionSheet" forState:UIControlStateNormal];
    
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button2.frame = CGRectMake(20, 120, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button2 setTitle:@"弹出系统ActionSheet" forState:UIControlStateNormal];
    
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button2];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button3.frame = CGRectMake(20, 180, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button3 setTitle:@"弹出系统ActionSheet" forState:UIControlStateNormal];
    
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button3];
    
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button4.frame = CGRectMake(20, 240, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button4 setTitle:@"弹出系统ActionSheet" forState:UIControlStateNormal];
    
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button5.frame = CGRectMake(20, 300, CGRectGetWidth(self.view.frame) - 40, 40);
    
    [button5 setTitle:@"弹出系统ActionSheet" forState:UIControlStateNormal];
    
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button5];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮点击事件

- (void)button1Action{
    
    //带一个取消按钮的ActionSheet
    
    [LEEActionSheet actionSheet].system.config
    .LeeCancelButtonTitle(@"取消")
    .LeeCancelButtonAction(^(){
        
        NSLog(@"点击了取消按钮");
        
    })
    .LeeShow();
    
}

- (void)button2Action{
    
    //带一个取消按钮和标题内容的ActionSheet
    
    [LEEActionSheet actionSheet].system.config
    .LeeTitle(@"标题")
    .LeeContent(@"内容")
    .LeeCancelButtonTitle(@"取消")
    .LeeCancelButtonAction(^(){
        
        NSLog(@"点击了取消按钮");
        
    })
    .LeeShow();
    
}


- (void)button3Action{
    
    //带一个取消按钮和一个销毁按钮的ActionSheet
    
    [LEEActionSheet actionSheet].system.config
    .LeeTitle(@"标题")
    .LeeContent(@"内容")
    .LeeCancelButtonTitle(@"取消")
    .LeeCancelButtonAction(^(){
        
        NSLog(@"点击了取消按钮");
        
    })
    .LeeDestructiveButtonAction(^(){
        
        NSLog(@"点击了销毁按钮");
        
    })
    .LeeShow();
    
}


- (void)button4Action{
    
    //带一个取消按钮和一个销毁按钮还有一个其他按钮的ActionSheet
    
    [LEEActionSheet actionSheet].system.config
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
    .LeeShowFromViewController(self);
    
}


- (void)button5Action{
    
    //带一个取消按钮和一个销毁按钮还有多个其他按钮以及标题内容的ActionSheet
    
    [LEEActionSheet actionSheet].system.config
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
    .LeeShow(); //或.LeeShowFromViewController(self);
    
}


@end




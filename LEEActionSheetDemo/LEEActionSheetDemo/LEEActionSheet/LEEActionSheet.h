
/*!
 *  @header LEEActionSheet.h
 *          
 *
 *  @brief  操作表
 *
 *  @author 李响
 *  @copyright    Copyright © 2016年 lee. All rights reserved.
 *  @version    1.0
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LEEActionSheetSystem , LEEActionSheetCustom , LEEActionSheetConfigModel;


typedef LEEActionSheetConfigModel *(^LEEConfigActionSheet)();
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToInteger)(NSInteger number);
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToFloat)(CGFloat number);
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToString)(NSString *str);
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToView)(UIView *view);
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToColor)(UIColor *color);
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToButtonAndBlock)(NSString *title , void(^buttonAction)());
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToButtonBlock)(void(^buttonAction)());
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToCustomTextField)(void(^addTextField)(UITextField *textField));
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToCustomButton)(void(^addButton)(UIButton *button));
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToCustomLabel)(void(^addLabel)(UILabel *label));
typedef LEEActionSheetConfigModel *(^LEEConfigActionSheetToViewController)(UIViewController *viewController);


/*
 
 *********************************************************************************
 *
 * 在使用LEEActionSheet的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ    : 可以添加SDAutoLayout群 497140713 在这里找我到(LEE)
 * Email : applelixiang@126.com
 * GitHub: https://github.com/lixiang1994/LEEActionSheet
 * 简书:    http://www.jianshu.com/users/a6da0db100c8
 *
 *********************************************************************************
 
 */

// 如果需要用“断言”调试程序请打开此宏

//#define LEEDebugWithAssert

@interface LEEActionSheet : NSObject

/**
 *  系统类型
 */
@property (nonatomic , strong ) LEEActionSheetSystem *system;
/**
 *  自定义类型
 */
@property (nonatomic , strong ) LEEActionSheetCustom *custom;

/**
 *  初始化ActionSheet
 *
 *  @return 返回一个LEEActionSheet对象
 */
+ (LEEActionSheet *)actionSheet;

/**
 *  关闭自定义ActionSheet
 */
+ (void)closeCustomActionSheet;

@end

@interface LEEActionSheetConfigModel : NSObject

/*
 *************************说明************************
 
 LEEActionSheet 目前提供两种方案 1.使用系统ActionSheet  2.使用自定义ActionSheet
 
 1.系统ActionSheet [LEEActionSheet actionSheet].system.cofing.XXXXX.LeeShow();
 
 2.自定义ActionSheet [LEEActionSheet actionSheet].custom.cofing.XXXXX.LeeShow();
 
 两种ActionSheet的设置方法如下,其中系统ActionSheet类型支持基本设置,自定义ActionSheet支持全部设置/
 
 设置方法结束后在最后请不要忘记使用.LeeShow()方法显示ActionSheet.
 
 最低支持iOS7及以上
 
 *****************************************************
 */

/* ActionSheet 基本设置 */

/** 设置 ActionSheet 标题 -> 格式: .LeeTitle(@@"") */
@property (nonatomic , copy , readonly ) LEEConfigActionSheetToString LeeTitle;
/** 设置 ActionSheet 内容 -> 格式: .LeeContent(@@"") */
@property (nonatomic , copy , readonly ) LEEConfigActionSheetToString LeeContent;
/** 设置 ActionSheet 取消按钮标题 -> 格式: .LeeCancelButtonTitle(@@"") */
@property (nonatomic , copy , readonly ) LEEConfigActionSheetToString LeeCancelButtonTitle;
/** 设置 ActionSheet 取消按钮响应事件Block -> 格式: .LeeCancelButtonAction(^(){ //code.. }) */
@property (nonatomic , copy , readonly ) LEEConfigActionSheetToButtonBlock LeeCancelButtonAction;
/** 设置 ActionSheet 添加按钮 -> 格式: .LeeAddButton(@@"" , ^(){ //code.. }) */
@property (nonatomic , copy , readonly ) LEEConfigActionSheetToButtonAndBlock LeeAddButton;
/** 设置 ActionSheet 添加输入框 -> 格式: .LeeAddTextField(^(UITextField *textField){ //code.. }) */
@property (nonatomic , copy , readonly ) LEEConfigActionSheetToCustomTextField LeeAddTextField;

/* Alert 自定义设置 */



@end

@interface LEEActionSheetSystem : NSObject
/** 开始设置 */
@property (nonatomic , strong ) LEEActionSheetConfigModel *config;

@end

@interface LEEActionSheetCustom : NSObject
/** 开始设置 */
@property (nonatomic , strong ) LEEActionSheetConfigModel *config;

@end










/* 以下是内部使用的工具类 ╮(╯▽╰)╭ 无视就好 不许乱动 "( *・ω・)✄╰ひ╯ */

@interface UIImage (LEEActionSheetImageEffects)

- (UIImage*)LeeActionSheet_ApplyLightEffect;

- (UIImage*)LeeActionSheet_ApplyExtraLightEffect;

- (UIImage*)LeeActionSheet_ApplyDarkEffect;

- (UIImage*)LeeActionSheet_ApplyTintEffectWithColor:(UIColor*)tintColor;

- (UIImage*)LeeActionSheet_ApplyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage*)maskImage;

@end

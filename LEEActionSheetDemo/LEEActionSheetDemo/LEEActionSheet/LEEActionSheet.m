
/*!
 *  @header LEEActionSheet.m
 *
 *
 *  @brief  操作表
 *
 *  @author 李响
 *  @copyright    Copyright © 2016年 lee. All rights reserved.
 *  @version    1.0
 */

#import "LEEActionSheet.h"

#import <Accelerate/Accelerate.h>

#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface LEEActionSheet ()

@property (nonatomic , weak ) id currentCustomActionSheetDelegate;

@end

@protocol LEEActionSheetManagerDelegate <NSObject>

- (void)customActionSheetCloseDelegate;

@end

@implementation LEEActionSheet

- (void)dealloc{
    
    _system = nil;
    
    _custom = nil;
    
}

+ (LEEActionSheet *)shareActionSheetManager{
    
    static LEEActionSheet *actionSheetManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        actionSheetManager = [LEEActionSheet actionSheet];
        
    });
    
    return actionSheetManager;
}

+ (LEEActionSheet *)actionSheet{
    
    LEEActionSheet *actionSheet = [[LEEActionSheet alloc]init];
    
    return actionSheet;
}

+ (void)closeCustomActionSheet{
    
    if ([LEEActionSheet shareActionSheetManager].currentCustomActionSheetDelegate && [[LEEActionSheet shareActionSheetManager].currentCustomActionSheetDelegate respondsToSelector:@selector(customActionSheetCloseDelegate)]) {
        
        [[LEEActionSheet shareActionSheetManager].currentCustomActionSheetDelegate customActionSheetCloseDelegate];
    }
    
}

#pragma mark LazyLoading

- (LEEActionSheetSystem *)system{
    
    if (!_system) _system = [[LEEActionSheetSystem alloc]init];
    
    return _system;
}

- (LEEActionSheetCustom *)custom{
    
    if (!_custom) _custom = [[LEEActionSheetCustom alloc]init];
    
    return _custom;
}

@end

#pragma mark - ===================配置模型===================

typedef NS_ENUM(NSInteger, LEEActionSheetCustomBackGroundStype) {
    /** 自定义背景样式 模糊 */
    LEEActionSheetCustomBackGroundStypeBlur,
    /** 自定义背景样式 半透明 */
    LEEActionSheetCustomBackGroundStypeTranslucent,
};

typedef NS_ENUM(NSInteger, LEEActionSheetCustomSubViewType) {
    /** 自定义子视图类型 标题 */
    LEEActionSheetCustomSubViewTypeTitle,
    /** 自定义子视图类型 内容 */
    LEEActionSheetCustomSubViewTypeContent,
    /** 自定义子视图类型 输入框 */
    LEEActionSheetCustomSubViewTypeTextField,
    /** 自定义子视图类型 自定义视图 */
    LEEActionSheetCustomSubViewTypeCustomView,
};

@interface LEEActionSheetConfigModel ()

/* 以下为配置模型属性 ╮(╯▽╰)╭ 无视就好 */

@property (nonatomic , copy , readonly ) NSString *modelTitleStr;
@property (nonatomic , copy , readonly ) NSString *modelContentStr;
@property (nonatomic , copy , readonly ) NSString *modelCancelButtonTitleStr;
@property (nonatomic , copy , readonly ) NSString *modelDestructiveButtonTitleStr;

@property (nonatomic , strong ) NSMutableArray *modelButtonArray;
@property (nonatomic , strong ) NSMutableArray *modelCustomSubViewsQueue;

@property (nonatomic , copy ) void(^modelCancelButtonAction)();
@property (nonatomic , copy ) void(^modelDestructiveButtonAction)();
@property (nonatomic , copy ) void(^modelFinishConfig)(UIViewController *vc);

@end

@implementation LEEActionSheetConfigModel

-(void)dealloc{
    
    _modelTitleStr = nil;
    _modelContentStr = nil;
    _modelCancelButtonTitleStr = nil;
    _modelButtonArray = nil;
    _modelCustomSubViewsQueue = nil;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //初始化默认值
        
//        _modelCornerRadius = 10.0f; //默认警示框圆角半径
//        _modelSubViewMargin = 10.0f; //默认警示框内部控件之间间距
//        _modelTopSubViewMargin = 20.0f; //默认警示框顶部控件的间距
//        _modelBottomSubViewMargin = 20.0f; //默认警示框底部控件的间距
//        _modelAlertMaxWidth = 280; //默认最大宽度 设备最小屏幕宽度 320 去除20左右边距
//        _modelAlertMaxHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]) * 0.8f; //默认最大高度屏幕80%
//        _modelAlertOpenAnimationDuration = 0.3f; //默认警示框打开动画时长
//        _modelAlertCloseAnimationDuration = 0.2f; //默认警示框关闭动画时长
//        
//        _modelAlertViewColor = [UIColor whiteColor]; //默认警示框颜色
//        _modelAlertWindowBackGroundColor = [UIColor blackColor]; //默认警示框背景半透明或者模糊颜色
//        
//        _modelIsAlertWindowTouchClose = NO; //默认点击window不关闭
//        _modelIsCustomButtonClickClose = YES; //默认点击自定义按钮关闭
//        
//        _modelAlertCustomBackGroundStype = LEEAlertCustomBackGroundStypeTranslucent; //默认为半透明背景样式
        
        
    }
    return self;
}

-(LEEConfigActionSheetToString)LeeTitle{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *str){
        
        _modelTitleStr = str;
        
//        BOOL isAddQueue = YES; //是否加入队列
//        
//        for (NSDictionary *item in weakSelf.modelCustomSubViewsQueue) {
//            
//            if ([item[@"type"] integerValue] == LEEAlertCustomSubViewTypeTitle) {
//                
//                isAddQueue = NO; //已存在 不加入
//                
//                break;
//            }
//            
//        }
//        
//        if (isAddQueue) [weakSelf.modelCustomSubViewsQueue addObject:@{@"type" : @(LEEAlertCustomSubViewTypeTitle)}];
        
        return weakSelf;
    };
    
}

-(LEEConfigActionSheetToString)LeeContent{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *str){
        
        _modelContentStr = str;
        
//        BOOL isAddQueue = YES; //是否加入队列
//        
//        for (NSDictionary *item in weakSelf.modelCustomSubViewsQueue) {
//            
//            if ([item[@"type"] integerValue] == LEEAlertCustomSubViewTypeContent) {
//                
//                isAddQueue = NO; //已存在 不加入
//                
//                break;
//            }
//            
//        }
//        
//        if (isAddQueue) [weakSelf.modelCustomSubViewsQueue addObject:@{@"type" : @(LEEAlertCustomSubViewTypeContent)}];
        
        return weakSelf;
    };
    
}

-(LEEConfigActionSheetToString)LeeCancelButtonTitle{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *str){
        
        _modelCancelButtonTitleStr = str;
        
        return weakSelf;
    };
    
}

-(LEEConfigActionSheetToButtonBlock)LeeCancelButtonAction{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(void(^buttonAction)()){
        
        if (buttonAction) weakSelf.modelCancelButtonAction = buttonAction;
        
        return weakSelf;
    };
    
}

-(LEEConfigActionSheetToString)LeeDestructiveButtonTitle{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *str){
        
        _modelDestructiveButtonTitleStr = str;
        
        return weakSelf;
    };
    
}

-(LEEConfigActionSheetToButtonBlock)LeeDestructiveButtonAction{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(void(^buttonAction)()){
        
        if (buttonAction) weakSelf.modelDestructiveButtonAction = buttonAction;
        
        return weakSelf;
    };
    
}

-(LEEConfigActionSheetToButtonAndBlock)LeeAddButton{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *title , void(^buttonAction)()){
        
        [weakSelf.modelButtonArray addObject:@{@"title" : title , @"actionblock" : buttonAction}];
        
        return weakSelf;
    };
    
}






-(LEEConfigActionSheet)LeeShow{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(){
        
        if (weakSelf.modelFinishConfig) weakSelf.modelFinishConfig(nil);
        
        return weakSelf;
    };
    
}

-(LEEConfigActionSheetToViewController)LeeShowFromViewController{
    
    __weak typeof(self) weakSelf = self;
    
    return ^(UIViewController *viewController){
        
        if (weakSelf.modelFinishConfig) weakSelf.modelFinishConfig(viewController);
        
        return weakSelf;
    };
    
}

#pragma mark LazyLoading

- (NSMutableArray *)modelButtonArray{
    
    if (!_modelButtonArray) _modelButtonArray = [NSMutableArray array];
    
    return _modelButtonArray;
}
-(NSMutableArray *)modelCustomSubViewsQueue{
    
    if (!_modelCustomSubViewsQueue) _modelCustomSubViewsQueue = [NSMutableArray array];
    
    return _modelCustomSubViewsQueue;
}

@end

#pragma mark - =====================系统=====================

@interface LEEActionSheetSystem ()<UIActionSheetDelegate>

@property (nonatomic , strong ) NSMutableDictionary *actionSheetViewButtonIndexDic;

@end

@implementation LEEActionSheetSystem

- (void)dealloc{
    
    _config = nil;
    
    _actionSheetViewButtonIndexDic = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)configAlertWithShow:(UIViewController *)vc{
    
    NSString *title = self.config.modelTitleStr ? self.config.modelTitleStr : nil;
    
    NSString *message = self.config.modelContentStr ? self.config.modelContentStr : nil;
    
    NSString *cancelButtonTitle = self.config.modelCancelButtonTitleStr || self.config.modelCancelButtonAction ? self.config.modelCancelButtonTitleStr ? self.config.modelCancelButtonTitleStr : @"取消" : nil ;
    
    NSString *destructiveButtonTitle = self.config.modelDestructiveButtonTitleStr || self.config.modelDestructiveButtonAction ? self.config.modelDestructiveButtonTitleStr ? self.config.modelDestructiveButtonTitleStr : @"销毁" : nil ;
    
    if (iOS8) {
        
        __weak typeof(self) weakSelf = self;
        
        //使用 UIAlertController
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        if (cancelButtonTitle) {
         
            void (^cancelButtonAction)() = weakSelf.config.modelCancelButtonAction;
            
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                if (cancelButtonAction) cancelButtonAction();
                
            }];
            
            [alertController addAction:alertAction];
            
        }
        
        if (destructiveButtonTitle) {
            
            void (^destructiveButtonAction)() = weakSelf.config.modelDestructiveButtonAction;
            
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                if (destructiveButtonAction) destructiveButtonAction();
                
            }];
            
            [alertController addAction:alertAction];
            
        }
        
        for (NSDictionary *buttonDic in self.config.modelButtonArray) {
            
            NSString *buttonTitle = buttonDic[@"title"];
            
            void (^buttonAction)() = buttonDic[@"actionblock"];
            
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (buttonAction) buttonAction();
                
            }];
            
            [alertController addAction:alertAction];
            
        }
        
        if (vc) {
            
            [vc presentViewController:alertController animated:YES completion:^{}];
            
        } else {
            
            if ([UIApplication sharedApplication].keyWindow.rootViewController) {
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{}];
                
            } else {
                
#ifdef LEEDebugWithAssert
                /*
                 * keywindow的rootViewController 获取不到 建议传入视图控制器对象
                 *
                 * 建议: XXX.system.config.XXX().XXX().showFromViewController(视图控制器对象);
                 */
                NSAssert(self, @"LEEAlert : keywindow的rootViewController 获取不到 建议传入视图控制器对象");
#endif
                
            }
            
        }
        
        //释放模型
        
        _config = nil;
        
    } else {
        
        //使用UIActionSheet
        
        if (message) title = [NSString stringWithFormat:@"%@\n\n%@" , title , message];
        
        UIActionSheet *actionSheet = nil;
        
        //暂时傻逼式无奈处理
        
        actionSheet = [self sbHandleActionSheetWithTitle:title CancelButtonTitle:cancelButtonTitle DestructiveButtonTitle:destructiveButtonTitle];
        
        [self.config.modelButtonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSDictionary *buttonDic = obj;
            
            void (^buttonAction)() = buttonDic[@"actionblock"];
            
            [self.actionSheetViewButtonIndexDic setValue:buttonAction forKey:[NSString stringWithFormat:@"%ld" , actionSheet.firstOtherButtonIndex + idx]];
            
        }];
        
        
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        
    }
    
    //清空按钮数组
    
    [self.config.modelButtonArray removeAllObjects];
    
}

- (UIActionSheet *)sbHandleActionSheetWithTitle:(NSString *)title CancelButtonTitle:(NSString *)cancelButtonTitle DestructiveButtonTitle:(NSString *)destructiveButtonTitle{
    
    NSArray *array = self.config.modelButtonArray;
    
    switch (array.count) {
        case 0:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
            break;
        case 1:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"], nil];
            break;
        case 2:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"], nil];
            break;
        case 3:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"], nil];
            break;
        case 4:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"],array[3][@"title"], nil];
            break;
        case 5:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"],array[3][@"title"],array[4][@"title"], nil];
            break;
        case 6:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"],array[3][@"title"],array[4][@"title"],array[5][@"title"], nil];
            break;
        case 7:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"],array[3][@"title"],array[4][@"title"],array[5][@"title"],array[6][@"title"], nil];
            break;
        case 8:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"],array[3][@"title"],array[4][@"title"],array[5][@"title"],array[6][@"title"],array[7][@"title"], nil];
            break;
        case 9:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"],array[3][@"title"],array[4][@"title"],array[5][@"title"],array[6][@"title"],array[7][@"title"],array[8][@"title"], nil];
            break;
        case 10:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:array[0][@"title"],array[1][@"title"],array[2][@"title"],array[3][@"title"],array[4][@"title"],array[5][@"title"],array[6][@"title"],array[7][@"title"],array[8][@"title"],array[9][@"title"], nil];
            break;
        default:
            return [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
            break;
    }
    
    return nil;
    
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        
        if (self.config.modelCancelButtonAction) self.config.modelCancelButtonAction();
        
    } else if (buttonIndex == actionSheet.destructiveButtonIndex) {
        
        if (self.config.modelDestructiveButtonAction) self.config.modelDestructiveButtonAction();
        
    } else {
     
        void (^buttonAction)() = self.actionSheetViewButtonIndexDic[[NSString stringWithFormat:@"%ld" , buttonIndex]];
        
        if (buttonAction) buttonAction();
        
    }

}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    //清空UIAlertView按钮下标字典
    
    [self.actionSheetViewButtonIndexDic removeAllObjects];
    
    //延迟释放模型 防止循环引用
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        _config = nil;
    });
    
}

#pragma mark LazyLoading

- (LEEActionSheetConfigModel *)config{
    
    if (!_config) {
        
        _config = [[LEEActionSheetConfigModel alloc]init];
        
        __weak typeof(self) weakSelf = self;
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        _config.modelFinishConfig = ^(UIViewController *vc){
            
            [strongSelf configAlertWithShow:vc];
        };
        
    }
    
    return _config;
    
}

-(NSMutableDictionary *)actionSheetViewButtonIndexDic{
    
    if (!_actionSheetViewButtonIndexDic) _actionSheetViewButtonIndexDic = [NSMutableDictionary dictionary];
    
    return _actionSheetViewButtonIndexDic;
}


@end

#pragma mark - ====================自定义====================

@interface LEEActionSheetCustom ()

@property (nonatomic , strong ) UIWindow *currentKeyWindow;

@property (nonatomic , strong ) UIWindow *actionSheetWindow;

@property (nonatomic , strong ) UIImageView *actionSheetWindowImageView;

@property (nonatomic , strong ) UIScrollView *actionSheetView;

@property (nonatomic , strong ) NSMutableArray *actionSheetButtonArray;

@end

static NSString * const LEEActionSheetShowNotification = @"LEEActionSheetShowNotification";

@implementation LEEActionSheetCustom



@end


#pragma mark - ====================工具类====================


@implementation UIImage (LEEActionSheetImageEffects)

-(UIImage*)LeeActionSheet_ApplyLightEffect {
    
    UIColor*tintColor =[UIColor colorWithWhite:1.0 alpha:0.3];
    
    return[self LeeActionSheet_ApplyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}
-(UIImage*)LeeActionSheet_ApplyExtraLightEffect {
    
    UIColor*tintColor =[UIColor colorWithWhite:0.97 alpha:0.82];
    
    return[self LeeActionSheet_ApplyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}
-(UIImage*)LeeActionSheet_ApplyDarkEffect {
    
    UIColor*tintColor =[UIColor colorWithWhite:0.11 alpha:0.73];
    
    return[self LeeActionSheet_ApplyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}
-(UIImage*)LeeActionSheet_ApplyTintEffectWithColor:(UIColor*)tintColor {
    
    const CGFloat EffectColorAlpha = 0.6;
    UIColor*effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if(componentCount == 2) {
        CGFloat b;
        if([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    } else{
        CGFloat r, g, b;
        if([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return[self LeeActionSheet_ApplyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:1.0f maskImage:nil];
}
-(UIImage*)LeeActionSheet_ApplyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage*)maskImage {
    /**
     *  半径,颜色,色彩饱和度
     */
    //  Check pre-conditions. 检查前提条件
    if(self.size.width <1||self.size.height <1){
        NSLog(@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@",self.size.width,self.size.height,self);
        return nil;
    }
    if(!self.CGImage){
        NSLog(@"*** error: image must be backed by a CGImage: %@",self);
        return nil;
    }
    if(maskImage &&!maskImage.CGImage){
        NSLog(@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = {CGPointZero , self.size};
    UIImage*effectImage = self;
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor -1.)> __FLT_EPSILON__;
    if(hasBlur || hasSaturationChange) {
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO,[[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext,1.0,-1.0);
        CGContextTranslateCTM(effectInContext,0,-self.size.height);
        CGContextDrawImage(effectInContext,imageRect,self.CGImage);
        vImage_Buffer effectInBuffer;
        effectInBuffer.data = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        if(hasBlur){
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius *[[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius *3.* sqrt(2* M_PI)/4+0.5);
            if(radius %2 != 1) {
                radius += 1;// force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer,&effectOutBuffer, NULL,0,0, (uint32_t)radius, (uint32_t)radius,0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer,&effectInBuffer, NULL,0,0, (uint32_t)radius, (uint32_t)radius,0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer,&effectOutBuffer, NULL,0,0, (uint32_t)radius, (uint32_t)radius,0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if(hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722+0.9278* s,0.0722-0.0722* s,0.0722-0.0722* s,0,
                0.7152-0.7152* s,0.7152+0.2848* s,0.7152-0.7152* s,0,
                0.2126-0.2126* s,0.2126-0.2126* s,0.2126+0.7873* s,0,
                0,0,0,1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for(NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i]* divisor);
            }
            if(hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer,&effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else{
                vImageMatrixMultiply_ARGB8888(&effectInBuffer,&effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if(!effectImageBuffersAreSwapped)
            effectImage =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if(effectImageBuffersAreSwapped)
            effectImage =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    // Set up output context. 设置输出上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    // Draw base image. 绘制基准图像
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    // Draw effect image. 绘制效果图像
    if(hasBlur) {
        CGContextSaveGState(outputContext);
        if(maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    // Add in color tint. 添加颜色渲染
    if(tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    // Output image is ready. 输出图像
    UIImage*outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}
@end

//
//  CPSMacro.h
//  wisdom_school_ios
//
//  Created by Het on 2018/10/25.
//  Copyright © 2018 het. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define CBLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define CBLog(...)
#endif

#pragma mark - 机型适配
#define isiPhone6 (([[UIScreen mainScreen] bounds].size.width>320)&&([[UIScreen mainScreen] bounds].size.width<=375))
#define isiPhone6Plus (([[UIScreen mainScreen] bounds].size.width>375)&&([[UIScreen mainScreen] bounds].size.width<=414))

#define isiPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define isiPhone4 ([[UIScreen mainScreen] bounds].size.height <568)

#define  iPhone4Weight 320.0
#define  iPhone4Height 480.0

#define  iPhone5Weight 320.0
#define  iPhone5Height 568.0

#define  iPhone6Weight 375.0
#define  iPhone6Height 667.0

#define  iPhone6PWeight 414.0
#define  iPhone6PHeight 736.0

//获取屏幕宽度与高度

#define kScreen_Width   [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

//  适配屏幕的大小(每一像素所用的宽度）
#define kPixelWith (kScreen_Width/1080)
#define KPixelWithGrid (kScreen_Width/640)
#define kAdaptPixel (kScreen_Width / 320.0f)
#define kPixelWithIphone6 (kScreen_Width/iPhone6Weight)

//比例适配
#define  iphone5BasicHeight   (1/iPhone5Height*(isiPhone4?iPhone5Height:kScreen_Height))
#define  iphone5BasicWeight   (1/iPhone5Weight*kScreen_Width)

#define  NewBasicHeight (1/iPhone6Height*(isiPhone6?iPhone6Height:kScreen_Height))
#define  NewBasicWidth (1/iPhone6Weight*kScreen_Width)

#define  BasicHeight  (1/iPhone5Height*(isiPhone4?iPhone5Height:kScreen_Height))
#define  BasicWidth  (1/iPhone5Weight*kScreen_Width)

//导航栏和tabbarheight
#define IPX_STATUSBAROFFSETHEIGHT   ((kDevice_Is_iPhoneX) ? 24.0 : 0.0)
#define IPX_HOMEINDICATORHEIGHT     ((kDevice_Is_iPhoneX) ? 34.0 : 0.0)

#define KStatusBarHeight  20.0
#define KNavHeight        44.0
#define KNavStatusHeight (KStatusBarHeight+KNavHeight+IPX_STATUSBAROFFSETHEIGHT)
#define KTabBarHeight    ((kDevice_Is_iPhoneX) ? 83 : 49)

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark - 颜色定义
//获取颜色
#define KCOLOR(o)  [UserDefaultsUtil colorFromHexRGB:o]

//设置颜色
#define KRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

//设置随机颜色
#define KRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

// clear背景颜色
#define KBGColor [UIColor clearColor]

//APP通用字体颜色
#define KAPPPopularFontColor KRGBColor(255, 255, 255)

//APP通用线条颜色
#define KAPPPopularLineColor KRGBColor(241, 241, 241)

//内容颜色
#define KcontentTextColor KRGBColor(78, 73, 68)

#pragma mark - 字体设置
// 字体
#define KFont(F) [UIFont systemFontOfSize:(F)]
#define KFontB(F) [UIFont boldSystemFontOfSize:(F)] //加粗
#define KFONT(o) [UIFont systemFontOfSize:o]
//导航栏字体
#define KNavFont KFontB(18)

#pragma mark - UI定制
//由角度转换弧度 由弧度转换角度
#define KDegreesToRadian(x) (M_PI * (x) / 180.0)
#define KRadianToDegrees(radian) (radian*180.0)/(M_PI)

//设置 view 圆角和边框
#define KViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

////计算当前的线宽度
#define SINGLE_LINE_WIDTH (1/ [UIScreen mainScreen].scale)

#define kWindow [UIApplication sharedApplication].keyWindow

#pragma mark - 其他
// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#pragma mark - 通知常量
static NSString *kPhotoWallListRefreshNotification = @"kPhotoWallListRefreshNotification";// 动态墙刷新通知
static NSString *kTaskFinishNotification = @"kTaskFinishNotification";
static NSString *kHealthAssessmentFinishNotification = @"kHealthAssessmentFinishNotification";
static NSString *kStudentInfoSaveNotification = @"kStudentInfoSaveNotification";

#pragma mark - ===================================================================================================
// 提示文案
#define HET_LOADING @"加载中"
// 加载中提示
#define HET_LOADING_OBSERVE @weakify(self);\
[[RACObserve(self.viewModel, errorMsg) filter:^BOOL(id value) {\
return value?YES:NO;\
}] subscribeNext:^(NSString *errorMsg) {\
@strongify(self);\
[self.view showAutoDissmissAlertView:nil msg:errorMsg];\
}];\
[RACObserve(self.viewModel, loadingMsg) subscribeNext:^(NSString *loadingMsg) {\
@strongify(self);\
loadingMsg?[self.view showCustomHudtitle:loadingMsg]:[self.view HidHud];\
}];\
// 假数据调试模式
//#define DEBUG_MODEL
// 默认分页
#define PAGE_ROWS 10

#define RGBA_COLOR(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define FORMATSTRING(str) [CPSMacro formateString:str]
#define FORMAT_NULL_STRING(str) [CPSMacro formateNullString:str]
#define FORMAT_NUMBER_STRING(str) [CPSMacro formateNumberString:str]
#define FORMATNUMBER(str) [CPSMacro formateNumber:str]
#define FORMAT_DECIMAL_OBJ(obj,len) [CPSMacro formateDecimalString:(obj) pointLength:(len)]
#define WEAK_OBJ(obj) __weak typeof(obj) weak_##obj = obj;
#define STRONG_OBJ(obj) __strong typeof(obj) strong_##obj = obj;
#define CLASS_NAME(obj) NSStringFromClass([obj class])
// 去空格
#define WHITESPACE(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
#define WHITEALLSPACE(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

// 判断是否是非空的数组、字典、字符串
#define IS_NONEMPTY_ARRAY(_obj_) [CPSMacro isNonEmptyArray:(_obj_)]
#define IS_NONEMPTY_DICTIONARY(_obj_) [CPSMacro isNonEmptyDictionary:(_obj_)]
#define IS_NONEMPTY_STRING(_obj_) [CPSMacro isNonEmptySring:(_obj_)]

#define VALUEFORKEY(_dic,_key) [CPSMacro dicValueForKey:_dic key:_key]
#define OBJECTATINDEX(_array,_index) [CPSMacro getObjcAtIndex:(_index) array:(_array)]
#define ADDOBJECT(_array,_object) [CPSMacro addObject:(_object) array:(_array)]

// 时间 yyyy-MM-dd HH:mm:ss
#define NOWTIMESTR(date_format) [CPSMacro getNowTime:(date_format)]
#define TIMESTAMP_TO_TIMESTRING(timestamp,date_format) [CPSMacro getDateWithTimestamp:(timestamp) format:(date_format)]
#define FORMATEDATE(_date,_formate) [CPSMacro formateDataWith:(_date) formate:(_formate)]
#define FORMATEDATE_ZONE(_date,_formate,_timeZone) [CPSMacro formateDataWith:(_date) formate:(_formate) timeZone:(_timeZone)]
#define DATE_TO_TIMEINTERVAL(_dateString_, _formate_) [CPSMacro dateStringToTimeStamp:(_dateString_) format:(_formate_)]
#define FORMAT_DATE_STRING(_dateString,_fromFormat,_toFormat) [CPSMacro formatDateString:_dateString formFormat:_fromFormat toFormat:_toFormat]
#define FORMAT_TIME(numOrStr) [CPSMacro formatStringWithCreateTime:(numOrStr)]

// 视图
#define VIEW_W(_VIEW_)  round(_VIEW_.frame.size.width)
#define VIEW_H(_VIEW_)  round(_VIEW_.frame.size.height)
#define VIEW_X(_VIEW_)  round(_VIEW_.frame.origin.x)
#define VIEW_Y(_VIEW_)  round(_VIEW_.frame.origin.y)
#define VIEW_H_Y(_VIEW_)  round(_VIEW_.frame.origin.y + _VIEW_.frame.size.height)
#define VIEW_W_X(_VIEW_)  round(_VIEW_.frame.size.width + _VIEW_.frame.origin.x)

//系统颜色
#define WHITE_COLOR [UIColor whiteColor]
#define BLACK_COLOR [UIColor blackColor]
#define GRAY_COLOR  [UIColor grayColor]
#define ORANGE_COLOR [UIColor orangeColor]
#define CLEAR_COLOR [UIColor clearColor]

//导航栏高度
#define NAVIGATIONBARHEIGHT (STATUSBARHEIGHT + 44)
#define SELFNAVIGATIONBARHEIGHT (STATUSBARHEIGHT + self.navigationController.navigationBar.frame.size.height)
//状态栏高度
#define STATUSBARHEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#define ALREADY_OPEN @"already_open"

#define screenHeight [[UIScreen mainScreen] bounds].size.height
#define screenWidth [[UIScreen mainScreen] bounds].size.width
#define GetImage(imageName)  [UIImage imageNamed:imageName]
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define THEME_COLOR KCOLOR(@"0acabd")
#define LINE_COLOR KCOLOR(@"EDEEF1")
#define NAV_BAR_LINE_COLOR KCOLOR(@"F0F0F0")

@interface CPSMacro : NSObject

/**
 *  初始化文本输入框
 *
 *  @param view          父视图
 *  @param sizefont      字体大小
 *  @param backgroundObj 背景（UIImage或UIColor）
 *  @param keyBoardType  键盘类型
 *  @param placeholder   占位符
 *  @param secure        是否加密
 *  @param leftObj       左视图（UIImage或NSString）
 *
 *  @return 初始化的输入框
 */
+ (UITextField *)textFieldInView:(UIView *)view
                        sizeFont:(CGFloat)sizefont
                      background:(id)backgroundObj
                    keyBoardType:(NSInteger)keyBoardType
                     placeholder:(NSString *)placeholder
                          secure:(BOOL)secure
                        leftView:(id)leftObj
;
/**
 *  初始化文本框
 *
 *  @param view      父视图
 *  @param textColor 字体颜色
 *  @param textSize  字体大小
 *  @param text      文本内容
 *
 *  @return 文本框对象
 */
+ (UILabel *)labelInView:(UIView *)view
               textColor:(UIColor *)textColor
                textFont:(CGFloat)textSize
                    text:(NSString *)text;

/**
 *  初始化文本框
 *
 *  @param view      父视图
 *  @param color     字体颜色
 *  @param fontSize  字体大小
 *  @param text      文本内容
 *  @param alignment 对齐方式
 *  @param bold      是否加粗
 *  @param fit       是否自适应
 *
 *  @return 文本框对象
 */
+ (UILabel *)labelInView:(UIView *)view
               textColor:(UIColor *)color
                fontSize:(CGFloat)fontSize
                    text:(NSString *)text
               alignment:(NSTextAlignment)alignment
                    bold:(BOOL)bold
                     fit:(BOOL)fit;

/**
 *  初始化图片视图
 *
 *  @param view            父视图
 *  @param image           图片对象
 *  @param mode            显示模式
 *  @param backgroundColor 背景颜色
 *  @param cornerRadius    圆角半径
 *  @param width           边框宽度
 *  @param borderColor     边框颜色
 *
 *  @return 图片视图对象
 */
+ (UIImageView *)imageViewInView:(UIView *)view
                           image:(id)image
                     contentMode:(id)mode
                 backgroundColor:(id)backgroundColor
                    cornerRadius:(CGFloat)cornerRadius
                     borderWidth:(CGFloat)width
                     borderColor:(id)borderColor;

/**
 *  初始化按钮
 *
 *  @param view               父视图
 *  @param title              标题
 *  @param normalColor        正常标题颜色
 *  @param selectedColor      选中标题颜色
 *  @param fontSize           标题大小
 *  @param normalBackground   正常状态背景图片或颜色
 *  @param selectedBackground 选中状态背景图片或颜色
 *  @param cornerRadius       圆角大小
 *  @param borderWidth        边框宽度
 *  @param borderColor        边框颜色
 *  @param block              点击事件
 *
 *  @return 初始化后的按钮
 */
+ (UIButton *)buttonInView:(UIView *)view
                     title:(NSString *)title
          titleColorNormal:(UIColor *)normalColor
        titleColorSelected:(UIColor *)selectedColor
             titleFontSize:(CGFloat)fontSize
          backgroundNormal:(id)normalBackground
        backgroundSelected:(id)selectedBackground
              cornerRadius:(CGFloat)cornerRadius
               borderWidth:(CGFloat)borderWidth
               borderColor:(id)borderColor
                     block:(void (^)(UIButton *sender))block;

/**
 *  初始化视图
 *
 *  @param view         父视图
 *  @param color        背景色
 *  @param cornerRadius 圆角大小
 *
 *  @return 初始化的视图
 */
+ (UIView *)viewInView:(UIView *)view
       backgroundColor:(UIColor *)color
          cornerRadius:(CGFloat)cornerRadius;


/**
 格式化为字符串
 
 @param object 对象
 @return 字符串
 */
+ (NSString *)formateString:(id)object;

/**
 格式化字符串null-> --
 
 @param object 对象
 @return 字符串
 */
+ (NSString *)formateNullString:(id)object;

/**
 格式化number为字符串
 */
+ (NSString *)formateNumberString:(id)object;

/**
 格式化number为字符串同上 为空返回 0
 */
+ (NSString *)formateNumber:(id)object;

/**
 保留小数位数(忽略正负)
 
 @param object 对象（number或string）
 @param pointLength 保留小数位数长度
 @return 结果字符串
 */
+ (NSString *)formateDecimalString:(id)object pointLength:(NSInteger)pointLength;

/**
 接收入参格式 yyyy-MM-dd HH:mm:ss
 
 @param createTime NSNumber 或者 NSString 类型
 @return 时间显示字符串
 */
+ (NSString *)formatStringWithCreateTime:(id)createTime;

/**
 判断非空数组
 
 @param obj 对象
 @return 结果
 */
+ (BOOL)isNonEmptyArray:(id)obj;

/**
 判断非空字典
 
 @param obj 对象
 @return 结果
 */
+ (BOOL)isNonEmptyDictionary:(id)obj;

/**
 判断非空字符串
 
 @param obj 对象
 @return 结果
 */
+ (BOOL)isNonEmptySring:(id)obj;

/**
 获取当前时间字符串
 
 @param date_format 格式 yyyy-MM-dd HH:mm:ss
 @return 结果
 */
+ (NSString *)getNowTime:(NSString *)date_format;

/**
 格式化时间戳为字符串
 
 @param time 时间戳
 @param date_format 格式
 @return 结果
 */
+ (NSString *)getDateWithTimestamp:(NSTimeInterval)time format:(NSString *)date_format;

/**
 格式化时间为字符串
 
 @param date 时间
 @param fromate 格式
 @return 结果
 */
+ (NSString *)formateDataWith:(NSDate *)date formate:(NSString *)fromate;

/**
 格式化时间为字符串
 
 @param date 时间
 @param fromate 格式
 @param timeZone 时区
 @return 结果
 */
+ (NSString *)formateDataWith:(NSDate *)date formate:(NSString *)fromate timeZone:(NSInteger)timeZone;

/**
 格式化字符串时间为时间戳
 
 @param dateString 时间
 @param formate 格式
 @return 结果
 */
+ (NSTimeInterval)dateStringToTimeStamp:(NSString *)dateString format:(NSString *)formate;


/**
 格式化字符串
 
 @param dateString 字符串
 @param fromFormat 原格式
 @param toFormat 转格式
 @return 结果
 */
+ (NSString *)formatDateString:(NSString *)dateString formFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat;

/**
 视图转图片
 
 @param view 视图
 @return 结果
 */
+ (UIImage*)convertViewToImage:(UIView*)view;

/**
 字典读取校验
 
 @param dic 字典
 @param key 键
 @return 结果(异常返回空字符串)
 */
+ (id )dicValueForKey:(NSDictionary *)dic key:(NSString *)key;

/**
 数组读取校验
 
 @param index 序号
 @param array 数组
 @return 结果
 */
+ (id) getObjcAtIndex:(NSUInteger)index array:(NSArray *)array;

/**
 数组增加值
 
 @param object 序号
 @param array 数组
 */
+ (NSMutableArray *)addObject:(id)object array:(NSMutableArray *)array;

@end


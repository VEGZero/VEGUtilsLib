//
//  CPSMacro.h
//  wisdom_school_ios
//
//  Created by Het on 2018/10/25.
//  Copyright © 2018 het. All rights reserved.
//

#ifndef CPSMacro_h
#define CPSMacro_h

#import "CPSMacro.h"
#import "UIButton+Clicked.h"

@implementation CPSMacro

#pragma mark 初始化UITextField

+ (UITextField *)textFieldInView:(UIView *)view sizeFont:(CGFloat)sizefont background:(id)backgroundObj keyBoardType:(NSInteger)keyBoardType placeholder:(NSString *)placeholder secure:(BOOL)secure leftView:(id)leftObj
{
    UITextField *textField = [[UITextField alloc] init];
    //textField.delegate = self;
    //如果背景是一张图片，在下边插入一张图片
    if (backgroundObj && [backgroundObj isKindOfClass:[UIImage class]]) {
        UIImageView *bgPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        bgPic.image = backgroundObj;
        [view insertSubview:bgPic atIndex:0];
//        [bgPic mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
    }
    //如果背景是颜色，设置背景颜色
    else if (backgroundObj && [backgroundObj isKindOfClass:[UIColor class]]) {
        textField.backgroundColor = backgroundObj;
    }
    //如果背景是视图，设置背景视图
    else if (backgroundObj && [backgroundObj isKindOfClass:[UIView class]]) {
        UIView *tempView = backgroundObj;
        tempView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        if (view) {
            [view insertSubview:tempView belowSubview:textField];
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//            }];
        }
    }
    
    textField.keyboardType = keyBoardType;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:sizefont];
    textField.textColor = [UIColor blackColor];
    textField.secureTextEntry = secure;
    if (view) {
        [view addSubview:textField];
    }
    
    return textField;
}

#pragma mark 初始化Label
+ (UILabel *)labelInView:(UIView *)view textColor:(UIColor *)textColor textFont:(CGFloat)textSize text:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:textSize];
    label.text = text;
    [view addSubview:label];
    return label;
}

+ (UILabel *)labelInView:(UIView *)view textColor:(UIColor *)color fontSize:(CGFloat)fontSize text:(NSString *)text alignment:(NSTextAlignment)alignment bold:(BOOL)bold fit:(BOOL)fit{
    if (!text) {
        text = @"";
    }
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    if (alignment) {
        label.textAlignment = alignment;
    }
    if (color) {
        label.textColor = color;
    }
    if (bold) {
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    if (fit) {
        //label.frame = CGRectMake(frame.origin.x, frame.origin.y + 2, frame.size.width, frame.size.height);
        label.numberOfLines = 0;
        NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setAlignment:label.textAlignment];
        [paragraphStyle setLineSpacing:2];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        [attributedString addAttribute:NSFontAttributeName value:label.font range:NSMakeRange(0, [text length])];
        [attributedString addAttribute:NSForegroundColorAttributeName value:label.textColor range:NSMakeRange(0, [text length])];
        [label setAttributedText:attributedString];
        [label sizeToFit];
    }
    if (view) {
        [view addSubview:label];
    }
    
    return label;
}
#pragma mark 初始化UIImageView
+ (UIImageView *)imageViewInView:(UIView *)view image:(id)image contentMode:(id)mode backgroundColor:(id)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(id)borderColor{
    UIImageView *imageView = [[UIImageView alloc] init];
    if (image && [image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
    }
    if (image && [image isKindOfClass:[NSString class]]) {
        //[imageView sd_setImageWithURL:[NSURL URLWithString:FORMATSTRING(image)]];
    }
    if (mode) {
        imageView.contentMode = (UIViewContentMode)mode;
    }
    if (backgroundColor && [backgroundColor isKindOfClass:[UIColor class]]) {
        imageView.backgroundColor = backgroundColor;
    }
    if (cornerRadius > 0) {
        imageView.layer.cornerRadius = cornerRadius;
        imageView.layer.masksToBounds = YES;
    }
    if (width > 0) {
        imageView.layer.borderWidth = width;
    }
    if (borderColor && [borderColor isKindOfClass:[UIColor class]]) {
        imageView.layer.borderColor = ((UIColor *)borderColor).CGColor;
    }
    [view addSubview:imageView];
    
    return imageView;
    
}

#pragma mark 初始化UIButton

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
                     block:(void (^)(UIButton *sender))block{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([normalBackground isKindOfClass:[UIImage class]]) {
        [button setBackgroundImage:normalBackground forState:UIControlStateNormal];
    }
    if ([selectedBackground isKindOfClass:[UIImage class]]) {
        [button setBackgroundImage:selectedBackground forState:UIControlStateSelected];
    }
    if ([normalBackground isKindOfClass:[UIColor class]]) {
        [button setBackgroundColor:normalBackground];
        [button setBackgroundColor:normalBackground forState:UIControlStateNormal];
    }
    if ([selectedBackground isKindOfClass:[UIColor class]]) {
        [button setBackgroundColor:normalBackground];
        [button setBackgroundColor:selectedBackground forState:UIControlStateSelected];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (normalColor) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (fontSize) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    }
    if (cornerRadius) {
        button.layer.cornerRadius = cornerRadius;
        button.clipsToBounds = YES;
    }
    if (borderWidth) {
        button.layer.borderWidth = borderWidth;
        button.layer.borderColor = ((UIColor *)borderColor).CGColor;
    }
    __weak UIButton *weakbutton = button;
    [button addTargetWithBlock:^(UIButton *sender) {
        block(weakbutton);
    }];
    if (view) {
        [view addSubview:button];
    }
    return button;
}

/**
 *  初始化视图
 *
 *  @param view         父视图
 *  @param color        背景色
 *  @param cornerRadius 圆角大小
 *
 *  @return 初始化的视图
 */
+ (UIView *)viewInView:(UIView *)view backgroundColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    UIView *tempView = [[UIView alloc] init];
    if (color) {
        tempView.backgroundColor = color;
    }
    if (cornerRadius) {
        tempView.layer.cornerRadius = cornerRadius;
    }
    if (view) {
        [view addSubview:tempView];
    }
    return tempView;
}

+ (NSString *)formateString:(id)object{
    if (object == nil || object == NULL || [object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return  [NSString stringWithFormat:@"%@",object];
}

+ (NSString *)formateNullString:(id)object{
    if (object == nil || object == NULL || [object isKindOfClass:[NSNull class]]) {
        return @"--";
    }
    return  [NSString stringWithFormat:@"%@",object];
}

+ (NSString *)formateNumberString:(id)object{
    if (object == nil || object == NULL || [object isKindOfClass:[NSNull class]]) {
        return @"--";
    }
    if ([object isKindOfClass:NSClassFromString(@"NSNumber")]) {
        if ([[NSString stringWithFormat:@"%@", object] containsString:@"."]) {
            double conversionValue = [object doubleValue];
            NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
            NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
            if (decNumber) {
                return [decNumber stringValue];
            }else{
                return @"--";
            }
            
        }
    }
    return  [NSString stringWithFormat:@"%@",object];
}

/**
 格式化number为字符串同上 为空返回 0
 */
+ (NSString *)formateNumber:(id)object{
    if (object == nil || object == NULL || [object isKindOfClass:[NSNull class]]) {
        return @"0";
    }
    if ([object isKindOfClass:NSClassFromString(@"NSNumber")]) {
        if ([[NSString stringWithFormat:@"%@", object] containsString:@"."]) {
            double conversionValue = [object doubleValue];
            NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
            NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
            if (decNumber) {
                return [decNumber stringValue];
            }else{
                return @"0";
            }
            
        }
    }
    return  [NSString stringWithFormat:@"%@",object];
}


/**
 保留小数位数
 
 @param object 对象（number或string）
 @param pointLength 保留小数位数长度
 @return 结果字符串
 */
+ (NSString *)formateDecimalString:(id)object pointLength:(NSInteger)pointLength{
    if (object == nil || object == NULL || [object isKindOfClass:[NSNull class]]) {
        return @"0";
    }
    if ([object isKindOfClass:NSClassFromString(@"NSNumber")] || [object isKindOfClass:NSClassFromString(@"NSString")]) {
        if ([[NSString stringWithFormat:@"%@", object] containsString:@"."]) {
            double conversionValue = fabs([object doubleValue]);
            //保留两位并四舍五入
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
            NSDecimalNumber *decNumber = [[[NSDecimalNumber alloc] initWithDouble:conversionValue] decimalNumberByRoundingAccordingToBehavior:roundUp];
            if (decNumber) {
                NSString *returnString = [NSString stringWithFormat:@"%@", decNumber];
                return returnString;
            }else{
                return @"0";
            }
            
        }else{
            return [NSString stringWithFormat:@"%ld",labs([object integerValue])];
        }
    }
    return  [NSString stringWithFormat:@"%@",object];
}



+ (BOOL)isNonEmptyArray:(id)obj{
    if (obj == nil) {
        return NO;
    }
    if (![obj isKindOfClass:[NSArray class]]) {
        return NO;
    }
    if (((NSArray *)obj).count < 1) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isNonEmptyDictionary:(id)obj{
    if (obj == nil) {
        return NO;
    }
    if (![obj isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    if (([(NSDictionary *)obj allKeys]).count < 1) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isNonEmptySring:(id)obj{
    if (obj == nil) {
        return NO;
    }
    if (![obj isKindOfClass:[NSString class]]) {
        return NO;
    }
    if (((NSString *)obj).length < 1) {
        return NO;
    }
    
    return YES;
}

+ (NSString *)getNowTime:(NSString *)date_format{
    //当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:date_format];
    return FORMATSTRING([formatter stringFromDate:[NSDate date]]);
}

+ (NSString *)getDateWithTimestamp:(NSTimeInterval)time format:(NSString *)date_format{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:date_format];
    return [formatter stringFromDate:date];
}

+ (NSString *)formateDataWith:(NSDate *)date formate:(NSString *)fromate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromate];
    return [formatter stringFromDate:date];
}

+ (NSString *)formateDataWith:(NSDate *)date formate:(NSString *)fromate timeZone:(NSInteger)timeZone{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromate];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:timeZone*60*60]];
    return [formatter stringFromDate:date];
}

+ (NSTimeInterval)dateStringToTimeStamp:(NSString *)dateString format:(NSString *)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:dateString];
    NSTimeInterval interval = [date timeIntervalSince1970];
    return interval;
}

/**
 格式化字符串
 
 @param dateString 字符串
 @param fromFormat 原格式
 @param toFormat 转格式
 @return 结果
 */
+ (NSString *)formatDateString:(NSString *)dateString formFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat{
    if (IS_NONEMPTY_STRING(dateString)) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:fromFormat];
        NSDate *date = [formatter dateFromString:dateString];
        [formatter setDateFormat:toFormat];
        return [formatter stringFromDate:date];
    }else{
        NSLog(@"Warning: 格式化时间字符串异常，无有效字符串");
        return @"";
    }
}

+ (UIImage*)convertViewToImage:(UIView*)view{
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (id)dicValueForKey:(NSDictionary *)dic key:(NSString *)key{
    if ([dic isKindOfClass:[NSDictionary class]]) {
        if ([[dic allKeys] containsObject:key]) {
            return [dic objectForKey:key];
        }else{
            return @"";
        }
    }else{
        return @"";
    }
}

+ (id)getObjcAtIndex:(NSUInteger)index array:(NSArray *)array{
    if (array && [array isKindOfClass:[NSArray class]] && array.count > index) {
        return [array objectAtIndex:index];
    }else{
        return nil;
    }
}

/**
 数组增加值
 
 @param object 序号
 @param array 数组
 */
+ (NSMutableArray *)addObject:(id)object array:(NSMutableArray *)array{
    if (array == nil) {
        array  = [[NSMutableArray alloc] init];
    }
    if ([array isKindOfClass:[NSMutableArray class]]) {
        if (object != nil) {
            if ([object isKindOfClass:[NSArray class]]) {
                [array addObjectsFromArray:object];
            }else{
                [array addObject:object];
            }
        }else{
            NSLog(@"NSMutableArray can not add a nil value");
        }
    }else{
        NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:array];
        if (object != nil) {
            if ([object isKindOfClass:[NSArray class]]) {
                [newArray addObjectsFromArray:object];
            }else{
                [newArray addObject:object];
            }
        }else{
            NSLog(@"NSMutableArray can not add a nil value");
        }
        array = newArray;
    }
    return array;
}

/**
 接收入参格式 yyyy-MM-dd HH:mm:ss
 
 @param createTime NSNumber 或者 NSString 类型
 @return 时间显示字符串
 */
+ (NSString *)formatStringWithCreateTime:(id)createTime{
//    NSString *tempStr;
//    NSDate *dt;
//    if ([createTime isKindOfClass:[NSNumber class]]) {
//        tempStr = TIMESTAMP_TO_TIMESTRING([createTime doubleValue]/1000, @"yyyy-MM-dd HH:mm:ss");
//        dt = [NSDate dateWithString:tempStr format:@"yyyy-MM-dd HH:mm:ss" isUTC:YES];
//    }else if([createTime isKindOfClass:[NSString class]]){
//        tempStr = FORMAT_DATE_STRING(createTime, @"yyyy-MM-dd HH:mm", @"yyyy-MM-dd HH:mm:ss");
//        if(tempStr){
//            dt = [NSDate dateWithString:tempStr format:@"yyyy-MM-dd HH:mm:ss" isUTC:NO];
//        }else{
//            dt = [NSDate dateWithString:createTime format:@"yyyy-MM-dd HH:mm:ss" isUTC:NO];
//        }
//    }
//    if (dt == nil) {
//        return FORMATSTRING(createTime);
//    }
//    // V2.0 版本时间显示逻辑
//    NSInteger yearNow = [FORMATEDATE([NSDate date], @"yyyy") integerValue];
//    NSInteger monthNow = [FORMATEDATE([NSDate date], @"MM") integerValue];
//    NSInteger dayNow = [FORMATEDATE([NSDate date], @"dd") integerValue];
//    NSInteger year = [FORMATEDATE(dt, @"yyyy") integerValue];
//    NSInteger month = [FORMATEDATE(dt, @"MM") integerValue];
//    NSInteger day = [FORMATEDATE(dt, @"dd") integerValue];
//    // 今天
//    if (yearNow == year && monthNow == month && dayNow == day) {
//        NSTimeInterval timeInterval = fabs([dt timeIntervalSinceNow]);
//        if (timeInterval < 60) {
//            return @"刚刚";
//        }else if (timeInterval >= 60 && timeInterval < 60*60) {
//            return [NSString stringWithFormat:@"%ld分钟前", (NSInteger)(timeInterval/60)];
//        }else if (timeInterval >= 60*60 && timeInterval < 24*60*60) {
//            return [NSString stringWithFormat:@"%ld小时前", (NSInteger)(timeInterval/(60*60))];
//        }
//    }
//    // 昨天
//    else if ((yearNow == year && monthNow == month && dayNow == day + 1) ||
//             (yearNow == year && monthNow == month + 1 && [CPSMacro getDaysWithYear:year withMonth:month] == day && dayNow == 1)) {
//        return [NSString stringWithFormat:@"昨天 %@", FORMATEDATE(dt, @"HH:mm")];
//    }
//    else if (yearNow == year){
//        return [NSDate dateToString:dt format:@"MM-dd" isUTC:NO];
//    }else{
//        return [NSDate dateToString:dt format:@"yyyy-MM-dd" isUTC:NO];
//    }
//
    // V1.0 版本时间显示逻辑
    /*NSString *dateStr = [NSDate dateToString:dt format:@"yyyy-MM-dd" isUTC:NO];
     NSArray * weekdays = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
     NSString *weakdayString = OBJECTATINDEX(weekdays, ([dt weekday] - 1));
     if (IS_NONEMPTY_STRING(dateStr) && [dateStr containsString:@"-"]) {
     // 今天
     if ([dateStr isEqualToString:NOWTIMESTR(@"yyyy-MM-dd")]) {
     return [NSDate dateToString:dt format:@"HH:mm" isUTC:NO];
     }
     // 昨天
     else if ([dateStr isEqualToString:FORMATEDATE([[NSDate date] dateByAddingDays:-1], @"yyyy-MM-dd")]) {
     return @"昨天";
     }
     else if ([dateStr isEqualToString:FORMATEDATE([[NSDate date] dateByAddingDays:-2], @"yyyy-MM-dd")] ||
     [dateStr isEqualToString:FORMATEDATE([[NSDate date] dateByAddingDays:-3], @"yyyy-MM-dd")] ||
     [dateStr isEqualToString:FORMATEDATE([[NSDate date] dateByAddingDays:-4], @"yyyy-MM-dd")] ||
     [dateStr isEqualToString:FORMATEDATE([[NSDate date] dateByAddingDays:-5], @"yyyy-MM-dd")] ||
     [dateStr isEqualToString:FORMATEDATE([[NSDate date] dateByAddingDays:-6], @"yyyy-MM-dd")] ) {
     return weakdayString;
     }
     else{
     return dateStr;
     }
     }*/
    return @"";
}

/**
 获取天数
 
 @param year 年
 @param month 月
 @return 天数
 */
+ (NSInteger)getDaysWithYear:(NSInteger)year withMonth:(NSInteger)month{
    if((month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12))
        return 31 ;
    
    if((month == 4) || (month == 6) || (month == 9) || (month == 11))
        return 30;
    
    if((year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3))
    {
        return 28;
    }
    
    if(year % 400 == 0)
        return 29;
    
    if(year % 100 == 0)
        return 28;
    
    return 29;
}

@end

#endif /* CPSMacro_h */

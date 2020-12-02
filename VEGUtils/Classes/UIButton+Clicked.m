//
//  UIButton+Clicked.m
//
//
//  Created by VEG on 16/2/25.
//  Copyright © 2016年 VEG. All rights reserved.
//

#import "UIButton+Clicked.h"
#import <objc/runtime.h>

@implementation UIButton (Clicked)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origionSelected = class_getInstanceMethod(self, @selector(setSelected:));
        Method newSelected = class_getInstanceMethod(self, @selector(replaceSetSelected:));
        
        method_exchangeImplementations(origionSelected, newSelected);
    });
}

- (void)setStateDic:(NSMutableDictionary *)stateDic{
    objc_setAssociatedObject(self, @selector(stateDic), stateDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)stateDic{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setClickBlock:(void (^)(UIButton *))clickBlock{
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UIButton *))clickBlock{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)addTargetWithBlock:(void(^)(UIButton *sender))clickedAction{
    self.clickBlock = clickedAction;
    [self addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(down_action) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(outside_action) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(exit_action) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(cancel_action) forControlEvents:UIControlEventTouchCancel];
}

- (void)down_action{
    self.alpha = 0.6;
}
- (void)outside_action{
    self.alpha = 1;
}
- (void)exit_action{
    self.alpha = 1;
}
- (void)cancel_action{
    self.alpha = 1;
}
- (void)action{
    self.clickBlock(self);
    self.alpha = 1;
}


/**
 设置背景颜色

 @param backgroundColor 颜色
 @param state 状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    if (!self.stateDic) {
        self.stateDic = [[NSMutableDictionary alloc] init];
    }
    [self.stateDic setObject:backgroundColor forKey:@(state)];
}


/**
 替换方法

 @param selected 是否选中
 */
- (void)replaceSetSelected:(BOOL)selected{
    // 调用原方法
    [self replaceSetSelected:selected];
    // 修改背景色
    for (int i = 0; i < [self.stateDic allKeys].count; i++) {
        NSInteger state_save = [[self.stateDic allKeys][i] integerValue];
        UIColor *color_save = [self.stateDic allValues][i];
        // 设置选中颜色
        if (selected && state_save == UIControlStateSelected) {
            self.backgroundColor = color_save; break;
        }
        // 取消选中设置普通颜色
        if (!selected && state_save == UIControlStateNormal) {
            self.backgroundColor = color_save; break;
        }
    }                                       
}

@end

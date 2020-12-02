//
//  UIButton+Clicked.h
//  
//
//  Created by VEG on 16/2/25.
//  Copyright © 2016年 VEG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Clicked)

@property (nonatomic,strong) void(^clickBlock)(UIButton *sender);
@property (nonatomic,strong) NSMutableDictionary* stateDic;

- (void)addTargetWithBlock:(void(^)(UIButton *sender))clickedAction;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

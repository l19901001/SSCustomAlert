//
//  SSCustomAlter.h
//  SSAlterView
//
//  Created by lss on 2017/4/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSAlertView.h"

typedef NS_ENUM(NSInteger, SSCustomAlterAnimationStyle)
{
    //从底部弹出
    SSCustomAlterAnimationStyleDefault = 0,
    //从中心弹出
    SSCustomAlterAnimationStyleCenter
};

@interface SSCustomAlter : UIView
//初始化
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(SSCustomAlterStyle)style;

//弹出样式
@property (nonatomic, assign) SSCustomAlterAnimationStyle animationStyle;
//背景色
@property (nonatomic, strong) UIColor *bgColor;
//是否是显示
@property (nonatomic, assign, getter=isShow) BOOL show;
//动画时间 默认0.5
@property (nonatomic, assign) CGFloat duration;
//输入框文本内容
@property (nonatomic, strong) NSString *contentText;
//添加事件方法
-(void)addAction:(SSActionAlter *)action;

-(void)showView;

-(void)hiddenView;


@end

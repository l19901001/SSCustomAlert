//
//  SSAlertView.h
//  SSAlertView
//
//  Created by lss on 2017/4/17.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSActionAlter.h"

typedef NS_ENUM(NSInteger, SSCustomAlterStyle)
{
    //纯文本弹出框
    SSCustomAlterStyleDefault,
    //输入框弹出框
    SSCustomAlterStyleTextView
};

@protocol SSAlertViewDelegate;

@interface SSAlertView : UIView

-(instancetype)initWithStyle:(SSCustomAlterStyle)style;

@property (nonatomic, weak) id<SSAlertViewDelegate> delegate;
//提示
@property (nonatomic, copy) NSString *title;
//消息内容
@property (nonatomic, copy) NSString *message;
//输入框内容
@property (nonatomic, copy) NSString *textViewContent;
//输入框提示语
@property (nonatomic, copy) NSString *plahort;
//textView 文本内容
@property (nonatomic, copy) NSString *contentText;
//添加事件方法
-(void)addAction:(SSActionAlter *)action;

@end

@protocol SSAlertViewDelegate <NSObject>

-(void)completeContent:(SSAlertView *)alertView content:(NSString *)content;

@end

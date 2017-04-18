//
//  SSCustomAlter.m
//  SSAlterView
//
//  Created by lss on 2017/4/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#define kMARANG 20
#define kHEIGHT 200
#define kDURATION 0.25
#define kSCREENH [UIScreen mainScreen].bounds.size.height
#define kSCREENW [UIScreen mainScreen].bounds.size.width


#import "SSCustomAlter.h"


typedef void(^callBack)();

@interface SSCustomAlter () <CAAnimationDelegate, SSAlertViewDelegate>

@property (nonatomic, strong) SSAlertView *alertView;

@end

@implementation SSCustomAlter

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(SSCustomAlterStyle)style
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        _alertView = [[SSAlertView alloc] initWithStyle:style];
        CGRect rect = _alertView.frame;
        rect.size.width = kSCREENW-kMARANG*2;
        _alertView.frame = rect;
        _alertView.title = title;
        _alertView.message = message;
        _alertView.delegate = self;
        [self addSubview:_alertView];
        
        _bgColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        _duration = 0.5;
        _animationStyle = SSCustomAlterAnimationStyleDefault;
        _show = YES;
    }
    return self;
}

#pragma mark 添加事件控件
-(void)addAction:(SSActionAlter *)action
{
    if(action.style == SSActionStyleCancel && !action.eventBack){
        action.eventBack = ^{[self hiddenView];};
    }
    
    [_alertView addAction:action];
}

#pragma mark 显示与隐藏
-(void)showView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = _duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = (id)_bgColor.CGColor;
    [self.layer addAnimation:animation forKey:nil];
    [self setSelfFrame];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [_alertView.layer addAnimation:[self basicAnimation] forKey:nil];
}

-(void)setSelfFrame
{
    if(_animationStyle == SSCustomAlterAnimationStyleDefault){
        _alertView.layer.anchorPoint = CGPointZero;
        CGRect rect = _alertView.frame;
        rect.origin.y = kSCREENH;
        rect.origin.x = kMARANG;
        rect.size.width = kSCREENW-kMARANG*2;
        _alertView.frame = rect;
    }else{
        CGRect rect = _alertView.frame;
        rect.origin.y = 0;
        rect.origin.x = kMARANG;
        rect.size.width = kSCREENW-kMARANG*2;
        _alertView.frame = rect;
        _alertView.center = self.center;
    }
}

-(void)hiddenView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = _duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.toValue = (id)[UIColor colorWithWhite:0.8 alpha:0.0].CGColor;
    [self.layer addAnimation:animation forKey:nil];
    [_alertView.layer addAnimation:[self basicAnimation] forKey:nil];
}

#pragma mark 创建动画(基本动画)
-(CABasicAnimation *)basicAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = _duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    if(_animationStyle == SSCustomAlterAnimationStyleCenter){
        animation.keyPath = @"transform.scale";
        if(_show){
            animation.fromValue = [NSNumber numberWithFloat:0.0];
            animation.toValue = [NSNumber numberWithFloat:1.0];
        }else{
            animation.fromValue = [NSNumber numberWithFloat:1.0];
            animation.toValue = [NSNumber numberWithFloat:0.0];
        }
    }else{
        animation.keyPath = @"position";
        if(_show){
            animation.toValue =[NSValue valueWithCGPoint:CGPointMake(kMARANG,kSCREENH-_alertView.bounds.size.height)];
        }else{
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(kMARANG, kSCREENH)];
        }
    }
    
    return animation;
}

#pragma mark SSAlertViewDelegate
-(void)completeContent:(SSAlertView *)alertView content:(NSString *)content
{
    if (content) {
        _contentText = content;
    }
}

#pragma mark 动画代理
-(void)animationDidStart:(CAAnimation *)anim
{
    self.superview.userInteractionEnabled = NO;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(_animationStyle == SSCustomAlterAnimationStyleDefault){
        CABasicAnimation *baseAnima = (CABasicAnimation *)anim;
        CGPoint point = [baseAnima.toValue CGPointValue];
        _alertView.layer.position = point;
    }

    if(flag){
        self.superview.userInteractionEnabled = YES;
        if(!_show){
            [self removeFromSuperview];
        }
        _show = !self.isShow;
    }
}

#pragma mark 事件拦截
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *tch = touches.anyObject;
    if(tch.view == self){
        [self hiddenView];
    }
}

@end

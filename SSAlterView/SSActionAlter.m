//
//  SSActionAlter.m
//  SSAlterView
//
//  Created by lss on 2017/4/10.
//  Copyright © 2017年 lss. All rights reserved.
//



#import "SSActionAlter.h"
#import <objc/runtime.h>

@interface SSActionAlter ()

@property (nonatomic, copy) NSString *title;

@end

@implementation SSActionAlter

const void *key = "k_BUT_BLOCK";

-(instancetype)initWithTitle:(NSString *)title style:(SSActionStyle)style eventBack:(eventBack)eventBack
{
    self = [super init];
    if (self) {
        _title = title;
        _eventBack = eventBack;
        _style = style;
        
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitle:_title forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    but.backgroundColor = [UIColor greenColor];
    but.frame = self.bounds;
    [self addSubview:but];
    
    [but addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(but, key, _eventBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)clickEvent:(id)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    UIButton *but = (UIButton *)sender;
    eventBack block = objc_getAssociatedObject(but, key);
    if(block){
        block();
    }else{
        if(_eventBack){
            _eventBack();
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        view.frame = self.bounds;
    }
}

@end

//
//  SSActionAlter.h
//  SSAlterView
//
//  Created by lss on 2017/4/10.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^eventBack)();
typedef NS_ENUM(NSInteger, SSActionStyle)
{
    SSActionStyleCancel,
    SSActionStyleOK
};

@interface SSActionAlter : UIView

-(instancetype)initWithTitle:(NSString *)title style:(SSActionStyle)style eventBack:(eventBack)eventBack;

@property (nonatomic, copy) eventBack eventBack;

@property (nonatomic, assign) SSActionStyle style;

@end

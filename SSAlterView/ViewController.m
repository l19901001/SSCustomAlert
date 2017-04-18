//
//  ViewController.m
//  SSAlterView
//
//  Created by lss on 2017/4/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "ViewController.h"
#import "SSCustomAlter.h"

@interface ViewController ()

//@property (nonatomic, strong) SSCustomAlter *alter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SSCustomAlter *_alter = [[SSCustomAlter alloc] initWithTitle:@"提示" message:@"发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧发表一下您使用过程中的感受吧" style:SSCustomAlterStyleDefault];
    _alter.animationStyle = SSCustomAlterAnimationStyleCenter;
    SSActionAlter *alterOK = [[SSActionAlter alloc] initWithTitle:@"确定" style:SSActionStyleOK eventBack:^{
        
        NSLog(@"点击了确认按钮===%@", _alter.contentText);
        
        [_alter hiddenView];
    }];
    
    SSActionAlter *alterCancel = [[SSActionAlter alloc] initWithTitle:@"取消" style:SSActionStyleCancel eventBack:nil];
    
    [_alter addAction:alterOK];
    [_alter addAction:alterCancel];
    
    [_alter showView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

# SSCustomAlert
简单的弹框控件功能
支持底部弹出与中心弹出,同时支持简单的提示信息,以及带输入框的弹框功能

![image](https://github.com/l19901001/SSCustomAlert/blob/master/images_md/IMG_07222.PNG)
![image](https://github.com/l19901001/SSCustomAlert/blob/master/images_md/IMG_07233.PNG)

![image](https://github.com/l19901001/SSCustomAlert/blob/master/images_md/IMG_07244.PNG)
![image](https://github.com/l19901001/SSCustomAlert/blob/master/images_md/IMG_07255.PNG)
![image](https://github.com/l19901001/SSCustomAlert/blob/master/images_md/IMG_07266.PNG)
```
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

```

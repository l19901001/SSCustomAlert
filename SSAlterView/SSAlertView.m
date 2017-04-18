//
//  SSAlertView.m
//  SSAlertView
//
//  Created by lss on 2017/4/17.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "SSAlertView.h"


@interface SSAlertView ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIView *upSepaceLine;
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerLableH;
@property (weak, nonatomic) IBOutlet UITextView *cTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;

//控件样式
@property (nonatomic, assign) SSCustomAlterStyle style;


@end

@implementation SSAlertView

-(instancetype)initWithStyle:(SSCustomAlterStyle)style
{
    self = [super init];
    if(self){
        self = [[NSBundle mainBundle] loadNibNamed:@"SSAlertView" owner:self options:nil].firstObject;
        _style = style;
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.userInteractionEnabled = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.f;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor orangeColor];
    _bottomView.backgroundColor = [UIColor orangeColor];
    _bottomLine.backgroundColor = [UIColor grayColor];
    _upSepaceLine.backgroundColor = [UIColor grayColor];
    
    _cTextView.layer.borderColor = [UIColor orangeColor].CGColor;
    _cTextView.layer.borderWidth = 1.f;
    _cTextView.layer.masksToBounds = YES;
    _cTextView.layer.cornerRadius = 5.f;
}

-(void)addAction:(SSActionAlter *)action
{
    action.layer.masksToBounds = YES;
    action.layer.cornerRadius = 5;
    action.clipsToBounds = YES;
    
    [_bottomView addSubview:action];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark textView 代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(text.length <= 0 && textView.text.length > 0){
        _contentText = [textView.text substringToIndex:textView.text.length-1];
    }else{
        _contentText = [NSString stringWithFormat:@"%@%@", textView.text, text];
    }
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.editable){
        if([_delegate respondsToSelector:@selector(completeContent:content:)]){
            [_delegate completeContent:self content:textView.text];
            textView.editable = NO;
        }
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    _placeholder.hidden = textView.text.length==0?NO:YES;
}

-(void)setTitle:(NSString *)title
{
    if(title==nil || [title isEqualToString:@""]){
        _headerLableH.constant = 0;
    }else{
        _headerTitle.text = title;
        [_headerTitle sizeToFit];
        _headerLableH.constant = _headerTitle.bounds.size.height+10;
    }
}

-(void)setMessage:(NSString *)message
{
    if(_style == SSCustomAlterStyleDefault){
        _cTextView.hidden = YES;
        _placeholder.hidden = YES;
        _messageTitle.text = message;
        [_messageTitle sizeToFit];
        
    }else{
        _messageTitle.hidden = YES;
        _placeholder.hidden = NO;
        _placeholder.text = message;
    }
    
    CGRect rect = self.frame;
    rect.size.height = [self getSubviewsSumHeight];
    self.frame = rect;
}

-(CGFloat)getSubviewsSumHeight
{
    if(_style == SSCustomAlterStyleDefault){
        CGSize size = [_messageTitle.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_messageTitle.font} context:nil].size;
        CGFloat _headerTitleH = _headerLableH.constant;
        CGFloat _messageTitleH = size.height+10;
        CGFloat _bottomViewH = _bottomView.bounds.size.height;
        
        return _headerTitleH+_messageTitleH+_bottomViewH+2;
    }else{
        return self.frame.size.height;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    [self setBottomLayout];
}

-(void)setBottomLayout
{
    CGFloat mange = 20.f;
    __block CGFloat x = mange;
    __block CGFloat y = 5.f;
    __block CGFloat w = 0.f;
    __block CGFloat h = 0.0;
   
    [_bottomView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = [UIColor redColor];
            w = (CGRectGetWidth(_bottomView.frame)-(_bottomView.subviews.count+1)*mange)/_bottomView.subviews.count;
            h = CGRectGetHeight(_bottomView.frame)-mange/2;
            obj.frame = CGRectMake(x, y, w, h);
            x += (w+mange);
    }];
}


@end

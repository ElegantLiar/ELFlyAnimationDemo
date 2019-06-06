//
//  ELRewardButton.m
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import "ELRewardButton.h"
#import "ELRewardAnimationView.h"
#import "ELRewardAnimationManager.h"

#import "ELBasic.h"

@interface ELRewardButton ()<UIGestureRecognizerDelegate>

@property (nonatomic, copy) void (^tapBlock)(double rmbLevel);
@property (nonatomic, copy) void (^longPressBlock)(double rmbLevel);

@end

@implementation ELRewardButton{
    UIImageView     *_iconImageView;
}

- (instancetype)initWithTapBlock:(void (^)(double))tapBlock
                  longPressBlock:(void (^)(double))longPressBlock{
    if (self = [super init]) {
        
        self.tapBlock = tapBlock;
        self.longPressBlock = longPressBlock;
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_icon_zanshang_default"]];
        [self addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.center.mas_equalTo(self).with.offset(0);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
        longPressGesture.delegate = self;
        [self addGestureRecognizer:longPressGesture];
        
    }
    return self;
}

- (void)animateRewardView{
    CABasicAnimation *animation = [_iconImageView.layer animationForKey:@"Bounce"];
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.repeatCount = NSIntegerMax;
    animation.autoreverses = YES;
    animation.toValue = @(CATransform3DMakeScale(1.3, 1.3, 1));
    animation.duration = 0.3;
    [_iconImageView.layer addAnimation:animation forKey:@"Bounce"];
}

- (void)tapGesture{
    if (self.tapBlock) {
        self.tapBlock(1);
    }
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture{
    CGRect frame = [self.superview convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
    [ELRewardAnimationManager manager].animationView.frame = frame;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [[ELRewardAnimationManager manager].animationView startAnimation];
        
        _iconImageView.image = [UIImage imageNamed:@"chat_icon_zanshang_press"];
        [self animateRewardView];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [[ELRewardAnimationManager manager].animationView endAnimation];
        
        _iconImageView.image = [UIImage imageNamed:@"chat_icon_zanshang_default"];
        [_iconImageView.layer removeAllAnimations];
        
        if (self.longPressBlock) {
            self.longPressBlock([ELRewardAnimationManager manager].animationView.rmbLevel);
        }
    } else if (gesture.state == UIGestureRecognizerStateCancelled) {
        [[ELRewardAnimationManager manager].animationView endAnimation];
        
        _iconImageView.image = [UIImage imageNamed:@"chat_icon_zanshang_default"];
        [_iconImageView.layer removeAllAnimations];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}

@end

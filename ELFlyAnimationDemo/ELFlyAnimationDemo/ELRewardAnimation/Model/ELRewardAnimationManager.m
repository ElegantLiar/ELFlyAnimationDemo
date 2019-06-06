//
//  ELRewardAnimationManager.m
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import "ELRewardAnimationManager.h"

#import "ELRewardAnimationView.h"

@implementation ELRewardAnimationManager

+ (ELRewardAnimationManager *)manager{
    static ELRewardAnimationManager *manager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        manager = [[ELRewardAnimationManager alloc] init];
    });
    return manager;
}

- (ELRewardAnimationView *)animationView{
    if (!_animationView) {
        _animationView = [[ELRewardAnimationView alloc] init];
        [_animationView setHidden:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:_animationView];
    }
    return _animationView;
}


@end

//
//  ELRewardRMBScrollAnimationView.h
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELRewardRMBScrollAnimationView : UIView

- (void)startAnimationWithCountBlock:(void (^)(NSInteger count, ELRewardRMBScrollAnimationView *animationView))countBlock;

- (void)pause;

- (void)goOn;

- (void)endAnimation;

@end

NS_ASSUME_NONNULL_END

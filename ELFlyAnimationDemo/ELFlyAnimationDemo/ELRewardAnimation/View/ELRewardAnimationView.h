//
//  ELRewardAnimationView.h
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELRewardAnimationView : UIView

@property (nonatomic, assign) double rmbLevel;

- (void)startAnimation;

- (void)endAnimation;

@end

NS_ASSUME_NONNULL_END

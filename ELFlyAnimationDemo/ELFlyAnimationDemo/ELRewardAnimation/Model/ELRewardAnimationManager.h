//
//  ELRewardAnimationManager.h
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ELRewardAnimationView;

@interface ELRewardAnimationManager : NSObject

+ (ELRewardAnimationManager *)manager;

@property (nonatomic, strong) ELRewardAnimationView *animationView;

@end

NS_ASSUME_NONNULL_END

//
//  ELRewardButton.h
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELRewardButton : UIView

- (instancetype)initWithTapBlock:(void (^)(double rmbLevel))tapBlock
                  longPressBlock:(void (^)(double rmbLevel))longPressBlock;
@end

NS_ASSUME_NONNULL_END

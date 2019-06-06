//
//  ELBasic.h
//  ELFlyAnimationDemo
//
//  Created by ElegantLiar on 2019/6/5.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Lottie.h"
#import "UIView+Custom.h"
#import "Masonry.h"

extern CGFloat const kELFlyAnimationnLotViewWidth;
extern CGFloat const kELFlyAnimationnLotViewHeight;

NS_ASSUME_NONNULL_BEGIN

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif


#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


@interface ELBasic : NSObject

@end

NS_ASSUME_NONNULL_END

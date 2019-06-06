//
//  ELRewardRMBScrollAnimationView.m
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import "ELRewardRMBScrollAnimationView.h"
#import "Masonry.h"

@interface ELRewardRMBScrollAnimationView ()

@property (nonatomic, copy) void(^countBlock)(NSInteger count, ELRewardRMBScrollAnimationView *view);

@end

@implementation ELRewardRMBScrollAnimationView{
    UIImageView     *_rmbSymbloImageView;
    UIImageView     *_pointImageView;
    UIImageView     *_hundredImageView;
    UIImageView     *_tenImageView;
    UIImageView     *_oneImageView;
    
    NSTimer         *_timer;
    
    NSInteger       _hundred;
    NSInteger       _ten;
    NSInteger       _one;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    NSArray *imageNames = @[@"anim_num_symbol", @"anim_num_0", @"anim_num_point", @"anim_num_0", @"anim_num_0"];

    for (NSInteger i = 0; i < imageNames.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(i <= 2 ? 32 * i : (16 + 32 * (i - 1)));
            make.top.bottom.mas_equalTo(self).with.offset(0);
            make.width.mas_equalTo(@(i == 2 ? 16 : 32));
        }];
        
        if (i == 0) {
            _rmbSymbloImageView = imageView;
        } else if (i == 1) {
            _hundredImageView = imageView;
        } else if (i == 2) {
            _pointImageView = imageView;
        } else if (i == 3) {
            _tenImageView = imageView;
        } else if (i == 4) {
            _oneImageView = imageView;
        }
    }
}

- (void)startAnimationWithCountBlock:(void (^)(NSInteger, ELRewardRMBScrollAnimationView * _Nonnull))countBlock{
    
    self.countBlock = countBlock;
    
    _one = 0;
    _ten = 0;
    _hundred = 0;
    
    [_oneImageView setImage:[UIImage imageNamed:@"anim_num_0"]];
    [_tenImageView setImage:[UIImage imageNamed:@"anim_num_0"]];
    [_hundredImageView setImage:[UIImage imageNamed:@"anim_num_0"]];
    
    _timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(refreshUI) userInfo:nil repeats:YES];
}

- (void)refreshUI{
    _one ++;
    [_oneImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"anim_num_%zd", _one % 10]]];
    
    if (_one > 0 && _one % 10 == 0) {
        _ten++;
        [_tenImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"anim_num_%zd", _ten % 10]]];
    }
    
    if (_one > 0 && _one % 100 == 0) {
        _hundred++;
        [_hundredImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"anim_num_%zd", _hundred % 10]]];
    }
    
    if (_one > 888) {
        [_timer invalidate];
    }
    
    if (self.countBlock) {
        self.countBlock(_one, self);
    }
}

- (void)pause{
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)goOn{
    [_timer setFireDate:[NSDate date]];
}

- (void)endAnimation{
    [_timer invalidate];
    _timer = nil;
}

@end

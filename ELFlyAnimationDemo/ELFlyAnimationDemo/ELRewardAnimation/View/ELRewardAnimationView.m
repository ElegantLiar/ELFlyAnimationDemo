//
//  ELRewardAnimationView.m
//  ELFlyChatAnimationView
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import "ELRewardAnimationView.h"
#import "ELRewardRMBScrollAnimationView.h"

#import <AudioToolbox/AudioToolbox.h>

#import "ELBasic.h"

static void completionCallback(SystemSoundID mySSID)
{
    AudioServicesPlaySystemSound(1519);
}

@implementation ELRewardAnimationView{
    CAEmitterLayer      *_emitterLayer;
    LOTAnimationView    *_lotAnimationView;
    SystemSoundID       _mp3SoundID;
    
    ELRewardRMBScrollAnimationView      *_coinAnimationView;
    
    CGRect      _lotWindowRect;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    _emitterLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:_emitterLayer];
    
    _emitterLayer.emitterSize = CGSizeMake(25, 25);
    _emitterLayer.emitterShape = kCAEmitterLayerSphere;
    _emitterLayer.emitterMode = kCAEmitterLayerPoints;
    _emitterLayer.emitterPosition = CGPointMake(25, 0.f);
    
    
    NSMutableArray *emitterCells = @[].mutableCopy;
    for (NSInteger i = 0; i < 6; i++) {
        CAEmitterCell *cell = [self cellWithName:[NSString stringWithFormat:@"cell%zd", i + 1]
                                       imageName:[NSString stringWithFormat:@"gold_like_coin%zd.png", i + 1]
                                       birthRate:6.f
                                        lifetime:0.8
                               emissionLongitude:- (M_PI_2 / 4 * 3)
                                   emissionRange:M_PI_4 ];
        [emitterCells addObject:cell];
    }
    _emitterLayer.emitterCells = emitterCells;
    
    _lotAnimationView = [LOTAnimationView animationNamed:@"reward_88_data.json" inBundle:[NSBundle mainBundle]];
    _lotAnimationView.loopAnimation = YES;
    _lotAnimationView.frame = CGRectMake(18, - 80 - 168, 300, 168);
    _lotAnimationView.loopAnimation = NO;
    [self addSubview:_lotAnimationView];
    
    _coinAnimationView = [[ELRewardRMBScrollAnimationView alloc] init];
    [self addSubview:_coinAnimationView];
    _coinAnimationView.size = CGSizeMake(32 * 4 + 16, 46);
    _coinAnimationView.center = _lotAnimationView.center;

    _lotWindowRect = CGRectMake(([UIScreen mainScreen].bounds.size.width - kELFlyAnimationnLotViewWidth) / 2, 95, kELFlyAnimationnLotViewWidth, kELFlyAnimationnLotViewHeight);
}

- (void)startAnimation{
    
    CGRect frame = [[UIApplication sharedApplication].keyWindow convertRect:_lotWindowRect toView:self];
    
    _lotAnimationView.frame = frame;
    _coinAnimationView.center = _lotAnimationView.center;

    [self setHidden:NO];

    [_emitterLayer setValue:[NSValue valueWithCGPoint:CGPointMake(self.width / 2 ,self.height / 2)] forKeyPath:@"emitterPosition"];

    @weakify(self);
    [_coinAnimationView startAnimationWithCountBlock:^(NSInteger count, ELRewardRMBScrollAnimationView * _Nonnull animationView) {
        @strongify(self);
        if (!self) return;
        
        self.rmbLevel = (double)count / 100;
        
        if (count == 88 ||
            count == 111 ||
            count == 233 ||
            count == 666 ||
            count == 888 ) {
            [_lotAnimationView setAnimationNamed:[NSString stringWithFormat:@"reward_%zd_data", count]];
            [animationView pause];
            [animationView setHidden:YES];
            [_lotAnimationView setHidden:NO];
            [_lotAnimationView playWithCompletion:^(BOOL animationFinished) {
                if (count != 888) {
                    [self->_lotAnimationView setHidden:YES];
                    [animationView goOn];
                    [animationView setHidden:NO];
                }
            }];
        }
    }];
    
    [self playAudio];
}

- (void)playAudio{
    AudioServicesAddSystemSoundCompletion(1519, nil, nil, (void *)completionCallback, nil);
    AudioServicesPlaySystemSound(1519);
}

- (void)stopAudio {
    AudioServicesDisposeSystemSoundID(1519);
    AudioServicesRemoveSystemSoundCompletion(1519);
}

- (void)endAnimation{
    [self setHidden:YES];
    
    [self stopAudio];
    [_coinAnimationView endAnimation];
    [_lotAnimationView stop];
    
}

- (CAEmitterCell *)cellWithName:(NSString *)name
                      imageName:(NSString *)imageName
                      birthRate:(CGFloat)birthRate
                       lifetime:(CGFloat)lifetime
              emissionLongitude:(CGFloat)emissionLongitude
                  emissionRange:(CGFloat)emissionRange{
    
    CAEmitterCell *colorBallCell = [CAEmitterCell emitterCell];
    colorBallCell.name = name;
    colorBallCell.birthRate = birthRate;
    colorBallCell.lifetime = lifetime;
    
    colorBallCell.velocity = 350.f;
    colorBallCell.velocityRange = 40.f;
    colorBallCell.yAcceleration = 50.f;
    
    colorBallCell.emissionLongitude = - (M_PI_2 / 3 * 2);
    colorBallCell.emissionRange = M_PI_4;
    
    colorBallCell.emissionLongitude = emissionLongitude;
    colorBallCell.emissionRange = emissionRange;
    
    colorBallCell.emissionRange = (M_PI_2 / 3 * 2);
    
    
    colorBallCell.scale = 0.6;
    //    colorBallCell.scaleRange = 0.05;
    //    colorBallCell.scaleSpeed = 0.02;
    
    colorBallCell.spin = M_PI * 2;
    colorBallCell.spinRange = M_PI;
    
    colorBallCell.contents = (id)[[UIImage imageNamed:imageName] CGImage];
    colorBallCell.color = [[UIColor whiteColor] CGColor];
    colorBallCell.alphaRange = 0.8;
    colorBallCell.alphaSpeed = - 0.2f;
    
    return colorBallCell;
}

@end


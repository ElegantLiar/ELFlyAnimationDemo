//
//  ViewController.m
//  ELFlyAnimationDemo
//
//  Created by ElegantLiar on 2019/6/4.
//  Copyright © 2019 ElegantLiar. All rights reserved.
//

#import "ViewController.h"

#import "ELRewardButton.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    ELRewardButton *btn = [[ELRewardButton alloc] initWithTapBlock:^(double rmbLevel) {
        
    } longPressBlock:^(double rmbLevel) {
        
    }];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.mas_equalTo(self.view).with.offset(0);
        make.left.mas_equalTo(self.view).with.offset(40);
    }];
}


@end

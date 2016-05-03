//
//  ViewController.m
//  LPSegmentDemo
//
//  Created by LP.99 on 16/5/3.
//  Copyright © 2016年 anonymous. All rights reserved.
//

#import "ViewController.h"
#import "LPSegmentView.h"

@interface ViewController () <LPSegmentViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *beganPlayBtn;

/**
 *  使用控件一定要先声明@property 然后 ==
 */
@property (nonatomic, strong) LPSegmentView * segmentView;

/**
 *  dropMenuOpen - 判断开关
 */
@property (nonatomic, assign, getter=isDropMenuOpen) BOOL dropMenuOpen;

@end

@implementation ViewController

- (IBAction)beganPlay:(id)sender {
    
    if (!self.isDropMenuOpen) {
        
        [self openDropMenu];
        
    } else {
        
        [self closeDropMenu];
    }
}

- (void)openDropMenu {
    
    NSLog(@"openDropMenu");
    
    self.segmentView.hidden = NO;

    [UIView animateWithDuration:0.3f animations:^{
        
        self.segmentView.alpha = 1.0f;

    } completion:^(BOOL finished) {
        
        self.dropMenuOpen = YES;
    }];
}

- (void)closeDropMenu {
    
    NSLog(@"closeDropMenu");

    self.segmentView.hidden = YES;

    [UIView animateWithDuration:0.3f animations:^{
        
        self.segmentView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        self.dropMenuOpen = NO;
    }];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.beganPlayBtn.layer.masksToBounds = YES;
    self.beganPlayBtn.layer.cornerRadius = 30.0f;
    self.beganPlayBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.beganPlayBtn.layer.borderWidth = 1.0f;
    
    // PS: 高度设置自己注意 .. 
    LPSegmentView * segmentView = [[LPSegmentView alloc] initWithOrginY:self.view.frame.size.height - 100 - 30 TitleArr:@[@"标清", @"高清", @"超清"] delegate:self];
    segmentView.alpha = 0.0f;
    [self.view addSubview:segmentView];
    self.segmentView = segmentView;
    self.segmentView.hidden = YES;
}

- (void)lpSegmentView:(LPSegmentView *)lpSegment selectAtIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            NSLog(@"标清");
            break;
        case 1:
            NSLog(@"高清");
            break;
        case 2:
            NSLog(@"超清");
            break;
        default:
            NSLog(@"Others");
            break;
    }
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

@end

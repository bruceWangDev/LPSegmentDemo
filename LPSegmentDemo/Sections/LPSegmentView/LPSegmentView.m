//
//  LPSegmentView.m
//  LPSegmentDemo
//
//  Created by LP.99 on 16/5/3.
//  Copyright © 2016年 anonymous. All rights reserved.
//

#import "LPSegmentView.h"

#define LPSegmentView_Width [UIScreen mainScreen].bounds.size.width
#define LPSegmentView_Height 30.0

#define Min_Width_Button 80.0
#define Define_Tag_add 1000

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LPSegmentView ()

/**
 *  滚动视图
 */
@property (nonatomic, weak) UIScrollView * scrollView;

/**
 *  按钮下方的线条
 */
@property (nonatomic, weak) UIView * bottomLineView;

/**
 *  按钮数组
 */
@property (nonatomic, strong) NSMutableArray * btnsArr;

@end

@implementation LPSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // .. No Code ..
    }
    
    return self;
}

- (instancetype)initWithOrginY:(CGFloat)y TitleArr:(NSArray *)titleArr delegate:(id)delegate {
    
    // 设置selfFrame - 宽度是整个屏幕的宽度 高度是宏定义的LPSegmentView_Height 有需要自己修改
    CGRect selfViewFrame = CGRectMake(0, y, LPSegmentView_Width, LPSegmentView_Height);
    
    if (self = [super initWithFrame:selfViewFrame]) {
        
        // 设置背景颜色
        self.backgroundColor = UIColorFromRGBValue(0xf3f3f3);
        
        [self setUserInteractionEnabled:YES]; // set No edit
        
        self.delegate = delegate;
        
        _btnsArr = [[NSMutableArray alloc] initWithCapacity:[titleArr count]];
        
        CGFloat btnWidth = selfViewFrame.size.width/[titleArr count];
        
        // 按钮的长度最小不小于80 - 设置一个最小长度 没有按照4、5个标准 有需要自己修改
        if (btnWidth < Min_Width_Button) {
            btnWidth = Min_Width_Button;
        }
        
        // 创建滚动视图
        UIScrollView * scorllView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scorllView.backgroundColor = self.backgroundColor;
        scorllView.userInteractionEnabled = YES;
        scorllView.contentSize = CGSizeMake([titleArr count] * btnWidth, LPSegmentView_Height);
        scorllView.showsHorizontalScrollIndicator = NO;
//        scrollView.layer.borderWidth = 0.4f;
//        scrollView.layer.borderColor = UIColorFromRGBValue(0x999999).CGColor;
        
        // for循环 创建点击按钮
        for (int i = 0; i < [titleArr count]; i++ ) {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, LPSegmentView_Height);
//            btn.layer.borderWidth = 0.4f;
//            btn.layer.borderColor = UIColorFromRGBValue(0x999999).CGColor;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:[titleArr objectAtIndex:i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = Define_Tag_add + i; // tag
            [scorllView addSubview:btn];
            [_btnsArr addObject:btn];
            
            if (i == 0) { // 如果一个个数都没有 ..
                
                btn.selected = YES;
            }
            
            // 分割线
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(btnWidth * i - 1.0f, 0, 1.0f, LPSegmentView_Height)];
            lineView.backgroundColor = UIColorFromRGBValue(0xcccccc);
            [scorllView addSubview:lineView];
        }
        
        // 创建底部 lineView
        UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, LPSegmentView_Height - 1, btnWidth, 1.0f)];
        bottomLineView.backgroundColor = [UIColor orangeColor];
//        [scorllView addSubview:bottomLineView]; // 需要在显示Line
        self.bottomLineView = bottomLineView;
        
        [self addSubview:scorllView];
        self.scrollView = scorllView;
    }
    
    return self;
}

// 每一个按钮点击的方式
- (void)segmentedControlChange:(UIButton *)btn {
    
    // 首先 点击的按钮状态为选中
    btn.selected = YES;
    
    // 其次 在整个按钮数组中 除了点击的这个按钮 其他按钮都未不选中状态
    for (UIButton *subBtn in self.btnsArr) {
        
        if (subBtn != btn) {
            
            subBtn.selected = NO;
        }
    }
    
    // 设置frame
    CGRect bottomLine = self.bottomLineView.frame;
    bottomLine.origin.x = btn.frame.origin.x;
    
    CGPoint pt = CGPointZero;
    
    BOOL canScrolle = NO;
    
    if ((btn.tag - Define_Tag_add) >= 2 && [_btnsArr count] > 4 && [_btnsArr count] > (btn.tag - Define_Tag_add + 2)) {
        
        pt.x = btn.frame.origin.x - Min_Width_Button * 1.5f;
        
        canScrolle = YES;
        
    } else if ([_btnsArr count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_btnsArr count]) {
        
        pt.x = (_btnsArr.count - 4) * Min_Width_Button;
        
        canScrolle = YES;
        
    } else if (_btnsArr.count > 4 && (btn.tag - Define_Tag_add) < 2) {
        
        pt.x = 0;
        
        canScrolle = YES;
    }
    
    if (canScrolle) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            _scrollView.contentOffset = pt;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.bottomLineView.frame = bottomLine;
            }];
        }];
        
    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.bottomLineView.frame = bottomLine;
        }];
    }
    
    // 需要执行代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(lpSegmentView:selectAtIndex:)]) {
        
        [self.delegate lpSegmentView:self selectAtIndex:btn.tag - 1000];
    }
}

- (void)changLPSegemntViewWithIndex:(NSInteger)index {
    
    if (index > [_btnsArr count]-1) {
        
        NSLog(@"index 超出范围");
        return;
    }
    
    UIButton *btn = [_btnsArr objectAtIndex:index];
    
    [self segmentedControlChange:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

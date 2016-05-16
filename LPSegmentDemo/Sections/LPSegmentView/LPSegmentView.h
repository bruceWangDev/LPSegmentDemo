//
//  LPSegmentView.h
//  LPSegmentDemo
//
//  Created by LP.99 on 16/5/3.
//  Copyright © 2016年 anonymous. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPSegmentView;

@protocol LPSegmentViewDelegate <NSObject>

/**
 *  获取当前下标
 *
 *  @param lpSegment lpSegment description
 *  @param index     index description
 */
- (void)lpSegmentView:(LPSegmentView *)lpSegment selectAtIndex:(NSInteger)index;

@end

@interface LPSegmentView : UIView

/**
 *  LPSegmentViewDelegate
 */
@property (nonatomic, assign) id <LPSegmentViewDelegate> delegate;

/**
 *  初始化 LPSegmentView
 *
 *  @param y        LPSegmentView的高度
 *  @param titleArr 标签数组
 *  @param delegate 代理对象
 *
 *  @return LPSegmentView
 */
- (instancetype)initWithOrginY:(CGFloat)y TitleArr:(NSArray *)titleArr delegate:(id)delegate;

/**
 *  改变下标的方法
 *
 *  @param index 提供修改的index
 */
- (void)changLPSegemntViewWithIndex:(NSInteger)index;

@end

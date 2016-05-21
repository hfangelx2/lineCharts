//
//  LineView.h
//  lineAtScoreView
//
//  Created by jack on 16/5/19.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LineViewModel;
@interface LineView : UIView

/** 所有的点 */
@property (nonatomic, strong) LineViewModel *dataModel;

/** 图表的宽度 */
@property (nonatomic, assign) CGFloat chartsWidth;
/** 图表的高度 */
@property (nonatomic, assign) CGFloat chartsHeight;

/** 获取图表的宽度 */
@property (nonatomic, copy) void(^getChartsWidth)(CGFloat chartsWidth);

/** 获取图表的高度 */
@property (nonatomic, copy) void(^getChartsHeight)(CGFloat chartsHeight);

/** X轴的颜色 defult = 黑色 */
@property (nonatomic, strong) UIColor *xLineColor;

/** X轴刻度的颜色 deafult = 白色 */
@property (nonatomic, strong) UIColor *xLineDialsColor;

/** Y轴刻度的颜色 deafult = 黑色 */
@property (nonatomic, strong) UIColor *yLineColor;

/** Y轴刻度的颜色 deafult = 白色 */
@property (nonatomic, strong) UIColor *yLineDialsColor;

/** 是否显示Y轴 deafult = YES */
@property (nonatomic, assign) BOOL displayYLine;

/** 是否显示X轴 deafult = YES */
@property (nonatomic, assign) BOOL displayXline;

/** 是否显示X轴刻度 deafult = YES */
@property (nonatomic, assign) BOOL displayXDials;

/** 是否显示Y轴刻度 deafult = YES */
@property (nonatomic, assign) BOOL displayYDials;

/** 是否显示刻度的过渡的动画 deafult = YES */
@property (nonatomic, assign) BOOL displayAnimation;

#pragma mark - method

/** 初始化图表 */
+ (instancetype)lineView;

/** 重绘 */
- (void)updateCharts;

/** 重新布局 */
- (void)updateSubViews;

@end

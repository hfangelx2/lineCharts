//
//  LineView.m
//  lineAtScoreView
//
//  Created by jack on 16/5/19.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "LineView.h"
#import "LineViewModel.h"
#import "UIView+Extension.h"
@interface LineView ()
/**
 *  X轴 线
 */
@property (nonatomic, weak) UIView* xlineView;

/**
 *  Y轴 线
 */
@property (nonatomic, weak) UIView *yLineView;

@end

@implementation LineView
/*
 *  没点之间的间距
 */
static float pedding = 55;

+ (instancetype)lineView
{
    LineView *lineView = [[LineView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [lineView deafult];
    return lineView;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

//默认配置
- (void)deafult
{
    //默认配置
    self.width = [UIScreen mainScreen].bounds.size.width;
    
    self.xLineColor = [UIColor blackColor];
    self.yLineColor = [UIColor blackColor];
    
    self.xLineDialsColor = [UIColor whiteColor];
    self.yLineDialsColor = [UIColor whiteColor];
    
    self.displayXline = YES;
    self.displayYLine = YES;
    
    self.displayXDials = YES;
    self.displayXDials = YES;
    
    self.displayAnimation = YES;
}

#pragma mark - 布局视图

//先布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.chartsWidth) {
        if (self.getChartsWidth) {
            self.getChartsWidth(self.width);
        }
    }
    if (!self.chartsHeight) {
        if (self.getChartsHeight) {
            self.getChartsHeight(self.height);
        }
    }
}

#pragma mark - 绘图

//后划线
- (void)drawRect:(CGRect)rect
{
    NSLog(@"%s", __func__);
    //画图 -> 最好的选择 AsyncDisplayKit
}

#pragma mark - public

//重绘
- (void)updateCharts
{
    [self setNeedsDisplay];
}

//重新布局
- (void)updateSubViews
{
    [self setNeedsDisplay];
}

#pragma mark - UI
//X轴
- (void)xLine
{
    /*
     1.确认多少个点, 每个点的间距为多少. -> 整个控件的宽度
     2.确认取点的范围 -> 确认X轴的每一个刻度宽度
     3.
     */
    
    self.xlineView.width = self.dataModel.xLine.count * pedding;//X轴总宽度
    
    self.width = self.xlineView.width;
    
}

//Y轴
- (void)yLine
{
    /*
     1.确认多少个点, 每个点的间距为多少. -> 整个控件的高度
     2.确认取点的范围 -> 确认Y轴的每一个刻度高度
     3.
     */
}

#pragma mark - lazy

- (UIView*)xlineView
{
    if (!_xlineView) {
        UIView* view = [[UIView alloc] init];
        [self addSubview:_xlineView = view];
    }
    return _xlineView;
}

- (UIView *)yLineView
{
    if (!_yLineView) {
        UIView *yLine = [[UIView alloc] init];
        [self addSubview:_yLineView = yLine];
    }
    return _yLineView;
}

#pragma mark - setter

//数据源
- (void)setDataModel:(LineViewModel*)dataModel
{
    _dataModel = dataModel;
    
    [self xLine];
    [self yLine];
}

- (void)setChartsWidth:(CGFloat)chartsWidth
{
    _chartsWidth = chartsWidth;
    
}

- (void)setChartsHeigh:(CGFloat)chartsHeight
{
    _chartsHeight = chartsHeight;
}

@end

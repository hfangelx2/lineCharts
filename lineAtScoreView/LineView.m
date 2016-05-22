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

/**
 *  贝塞尔曲线
 */
@property (nonatomic, strong) UIBezierPath *berierPath;

/** 内部维护的数据源 */
@property (nonatomic, strong) LineViewModel *dataSource;

@property (nonatomic, assign) CGFloat paddingW;

@property (nonatomic, assign) CGFloat paddingH;

@end

@implementation LineView
/** 每点之间的间距 */
static float padding = 55;

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAction:) name:willRomote object:nil];
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
    NSLog(@"%s",__func__);
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
    
//    if (!self.berierPath.empty) {
//        [self.berierPath removeAllPoints];
//    }
//    
//    if (self.dataModel) {
//
//        //判断两个点的位数是否一致
//        NSInteger count = self.dataModel.xLine.count == self.dataModel.yLine.count ? self.dataModel.xLine.count : (self.dataModel.xLine.count > self.dataModel.yLine.count ? self.dataModel.yLine.count : self.dataModel.xLine.count);
//        //绘点
//        /*
//         1.这里的点是需要自己内部计算的,不是外面传进来的点
//         2.根据使用者传进来不不同参数来进行计算点的坐标
//         */
//        for (int i = 0; i < count; i++) {
//            CGFloat x = [self.dataModel.xLine[i] floatValue];
//            CGFloat y = [self.dataModel.yLine[i] floatValue];
//            if (i == 0) {
//                [self.berierPath moveToPoint:CGPointMake(x, y)];
//            }
//            else {
//                [self.berierPath addLineToPoint:CGPointMake(x, y)];
//            }
//            NSLog(@"%f --- %f" ,x ,y);
//        }
//        
//    }
//    [self.berierPath stroke];

}

/** 计算 (核心方法) */
- (void)calculate
{
    if (self.dataSource) {//如果内部有数据 先移除掉  重新计算点
        [self.dataSource clearProperty];
    }

    //1.计算在当前视图的宽度下, 每段是多少间距
    if (self.chartsWidth) {//如果已传入宽度
       _paddingW = self.chartsWidth / self.dataSource.xLine.count;
    }else//如果未传入宽度,默认使用padding来设置间距
    {
        _paddingW = padding;
    }
    
    //2.计算在当前视图的高度下, 每段是多少间距
    if (self.chartsHeight) {//如果已传入高度
        _paddingH = self.chartsHeight / self.dataSource.yLine.count;
    }else//如果未传入宽度,默认使用padding来设置间距
    {
        _paddingH = padding;
    }
    for (LineViewPointModel *pointModel in self.dataModel.pointArray) {
        //3.计算 实际每个点所对应的位置
        [self calculatePoint:pointModel block:^(LineViewPointModel *currentPoint) {
            
        }];
        
    }
    
    //4.然后画X    Y轴
    [self xLine];
    [self yLine];
    
}

/** 计算点在控件中的实际位置 */
- (void)calculatePoint:(LineViewPointModel *)point block:(void(^)(LineViewPointModel *))block
{
    //1.计算该点 位于 X Y 轴的某一段区间内
    LineViewIndexModel *indexModel = [self calculatePoint:point atXline:self.dataModel.xLine yLine:self.dataModel.yLine];
    
    
    //2.计算出实际点的坐标
    
    LineViewPointModel *currentPoint = [[LineViewPointModel alloc] init];
    block(currentPoint);
}

/** 计算该点在X轴 Y轴的某一段区间内 */
- (LineViewIndexModel *)calculatePoint:(LineViewPointModel *)point atXline:(NSArray *)xLine yLine:(NSArray *)yLine
{
    LineViewIndexModel *indexModel = [[LineViewIndexModel alloc] init];
    //计算区间
    indexModel.xIndex = [self calculateValue:point.x at:xLine];
    indexModel.yIndex = [self calculateValue:point.y at:yLine];
    
    NSLog(@"%ld  ===== %ld",indexModel.xIndex ,indexModel.yIndex);
    return indexModel;
}

/** 返回区间 */
- (NSInteger)calculateValue:(CGFloat)value at:(NSArray *)array
{
    
    for (int i = 0 ; i < array.count; i++) {
        if (i == array.count - 1) {//说明是最后一个
            CGFloat value1 = [array[i] floatValue];
            if (value > value1) {//如果大于最后一个点 说明在该点右侧
                return i;
                break;
            }else{//否则在该点内
                return i == 0 ? 0 : i - 1;
            }
        }else{//如果不是最后一个
            CGFloat value1 = [array[i] floatValue];
            CGFloat value2 = [array[i] floatValue];
            if (value1 > value && value < value2)
            {//如果满足 说明找到index
                return i;
                break;
            }
            else
            {//如果不满足
                 if(value < value1)//是否小于所取到的第一个数
                 {
                     //如果i = 0 说明点在第一个区间内 所以返回i
                     //反之 返回i - 1的区间
                     return i == 0 ? i : i - 1;
                     
                 }
                 else if(value > value2)//判断是否大于取得的第二个数
                 {
                     if (i == array.count - 1)//如果是最后一个  返回i = array.count
                     {
                         return array.count;
                         break;
                     }
                     continue;
                 }
                
            }
            
        }
        
        
        
    }
    
    return 0;
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
    [self layoutSubviews];
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
    
    self.xlineView.width = self.dataModel.xLine.count * _paddingW;//X轴总宽度
    
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

- (UIBezierPath *)berierPath
{
    if (!_berierPath) {
        _berierPath = [UIBezierPath bezierPath];
    }
    return _berierPath;
}

- (LineViewModel *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[LineViewModel alloc] init];
    }
    return _dataSource;
}
#pragma mark - setter

//数据源
- (void)setDataModel:(LineViewModel*)dataModel
{
    _dataModel = dataModel;
    
    [self calculate];
}

/** 设置宽度 */
- (void)setChartsWidth:(CGFloat)chartsWidth
{
    _chartsWidth = chartsWidth;
    
}

/** 设置高度 */
- (void)setChartsHeigh:(CGFloat)chartsHeight
{
    _chartsHeight = chartsHeight;
}

#pragma mark - other

/** 设置默认刻度间距 */
- (void)deafultDials
{
    self.xDials = self.width / self.dataModel.xLine.count;
    self.yDials = self.height / self.dataModel.yLine.count;
}

- (void)updateAction:(NSNotification *)noti
{
    [self updateSubViews];
    [self updateCharts];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

//
//  ViewController.m
//  lineAtScoreView
//
//  Created by jack on 16/5/19.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "LineView.h"
#import "UIView+Extension.h"
#import "ViewController.h"
#import "LineViewModel.h"
@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView* sc;

@property (nonatomic, weak) LineView *line;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.line.dataModel = [self creatData];
}

/**
 *  模拟创建模拟数据模型
 */
- (LineViewModel *)creatData
{
    LineViewModel *model = [[LineViewModel alloc] init];
    model.yLine = @[@0 ,@30 ,@60 ,@90 ,@120, @160];
    model.xLine = @[@0 ,@20 ,@40 ,@60 ,@80 ,@100];
    
    for (int i = 0 ; i < model.yLine.count; i++) {
        LineViewPointModel *point = [[LineViewPointModel alloc] init];
//        point.x = arc4random()%100;
//        point.y = arc4random()%70;
        point.x = i * 30;
        point.y = i * 35;
        [model.pointArray addObject:point];
        NSLog(@"%f ------- %f" ,point.x, point.y);
    }
    NSLog(@"--------------------------");
    return model;
}

- (LineView *)line
{
    if (!_line) {
        LineView* line = [LineView lineView];
        
//        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleView:)];
//        [line addGestureRecognizer:pin];
        
        __weak typeof(self)weaSelf = self;
        
        line.chartsWidth = 500.0f;
        
        line.chartsHeight = 300.f;
        
        line.getChartsWidth = ^(CGFloat chartsWidth){
            weaSelf.sc.contentSize = CGSizeMake(chartsWidth, 0);
        };
        
        self.sc.contentSize = CGSizeMake(line.chartsWidth, 0);
        
        [self.sc addSubview:_line = line];
    }
    return _line;
}

- (UIScrollView*)sc
{
    if (!_sc) {

        UIScrollView* sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 400)];
        sc.backgroundColor = [UIColor yellowColor];

        sc.delegate = self;

        sc.minimumZoomScale = 0.5;

        sc.maximumZoomScale = 2.0;

        sc.showsHorizontalScrollIndicator = NO;

        sc.alwaysBounceHorizontal = YES;//只允许横向滚动

        sc.bounces = NO;
        
        [self.view addSubview:_sc = sc];
    }
    return _sc;
}

- (void)scaleView:(UIPinchGestureRecognizer*)pin
{
    LineView* line = [_sc.subviews objectAtIndex:0];
    
    line.x = 0;
    
    if (!(line.width < self.view.width + 1)) {
        line.transform = CGAffineTransformMakeScale(pin.scale, 1.0f);
    }
    
    NSLog(@"%@", line);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSLog(@"%@=====%@",NSStringFromCGSize(size),coordinator);
    [[NSNotificationCenter defaultCenter] postNotificationName:willRomote object:nil];
}

@end

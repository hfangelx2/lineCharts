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
 *  创建模拟数据模型
 */
- (LineViewModel *)creatData
{
    LineViewModel *model = [[LineViewModel alloc] init];
    model.yLine = @[@10 ,@30 ,@50 ,@70 ,@90];
    model.xLine = @[@20 ,@40 ,@60 ,@80 ,@100];
    model.pointArray = @[@12,@24,@36,@48,@60,@82,@93];
    return model;
}

- (LineView *)line
{
    if (!_line) {
        LineView* line = [LineView lineView];
        
        UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleView:)];
        [line addGestureRecognizer:pin];
        
        __weak typeof(self)weaSelf = self;
        
        line.getChartsWidth = ^(CGFloat chartsWidth){
            weaSelf.sc.contentSize = CGSizeMake(chartsWidth, 0);
        };
        
        self.sc.contentSize = CGSizeMake(line.width, 0);
        
        [self.sc addSubview:_line = line];
    }
    return _line;
}

- (UIScrollView*)sc
{
    if (!_sc) {

        UIScrollView* sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];

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

@end

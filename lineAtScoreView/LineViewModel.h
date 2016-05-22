//
//  LineViewModel.h
//  lineAtScoreView
//
//  Created by jack on 16/5/19.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LineViewModel : NSObject
/**
 *  Y轴显示的值
 */
@property (nonatomic, strong) NSArray *yLine;
/**
 *  X轴显示的值
 */
@property (nonatomic, strong) NSArray *xLine;
/**
 *  每个点
 */
@property (nonatomic, strong) NSMutableArray *pointArray;

/** 清空内部数据 */
- (void)clearProperty;

@end


@interface LineViewPointModel : NSObject

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@end


@interface LineViewIndexModel : NSObject

@property (nonatomic, assign) NSInteger xIndex;

@property (nonatomic, assign) NSInteger yIndex;
@end
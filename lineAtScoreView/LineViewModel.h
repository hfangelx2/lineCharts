//
//  LineViewModel.h
//  lineAtScoreView
//
//  Created by jack on 16/5/19.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (nonatomic, strong) NSArray *pointArray;

/** 清空内部数据 */
- (void)clearProperty;
@end

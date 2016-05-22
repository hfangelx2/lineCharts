//
//  LineViewModel.m
//  lineAtScoreView
//
//  Created by jack on 16/5/19.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "LineViewModel.h"

@implementation LineViewModel
- (void)clearProperty
{
    self.xLine = nil;
    self.yLine = nil;
    self.pointArray = nil;
}

- (NSMutableArray *)pointArray
{
    if (!_pointArray) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}

@end

@implementation LineViewPointModel


@end

@implementation LineViewIndexModel



@end
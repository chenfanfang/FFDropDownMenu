//
//  FFDropDownMenuTriangleView.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuTriangleView.h"

@implementation FFDropDownMenuTriangleView

- (void)drawRect:(CGRect)rect {
    
    //绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设置颜色
    [[UIColor whiteColor] set];
    
    //设置起点
    [path moveToPoint:CGPointMake(0, rect.size.height)];
    
    //添加一根线到某个点
    [path addLineToPoint:CGPointMake(rect.size.width * 0.5, 0)];
    
    //添加一根线到某个点
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    
    //关闭路径
    [path closePath];
    
    //填充（会把颜色填充进去）
    [path fill];
}

@end

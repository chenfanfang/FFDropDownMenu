//
//  FFDropDownMenuTriangleView.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuTriangleView.h"

@interface FFDropDownMenuTriangleView ()

@end

@implementation FFDropDownMenuTriangleView

- (void)setTriangleColor:(UIColor *)triangleColor {
    _triangleColor = triangleColor;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    //绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设置颜色
    [self.triangleColor set];
    
    //-------------绘制三角形------------
    //
    //                 B
    //                /\
    //               /  \
    //              /    \
    //             /______\
    //            A        C
    //
    //
    
    //设置起点 A
    [path moveToPoint:CGPointMake(0, rect.size.height)];
    
    //添加一根线到某个点 B
    [path addLineToPoint:CGPointMake(rect.size.width * 0.5, 0)];
    
    //添加一根线到某个点 C
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    
    //关闭路径
    [path closePath];
    
    //填充（会把颜色填充进去）
    [path fill];
}

@end

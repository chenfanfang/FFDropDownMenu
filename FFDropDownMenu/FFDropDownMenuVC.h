//
//  FFDropDownMenuVC.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFViewController.h"
@class FFDropDownMenuModel;

/**
 *  下拉菜单控制器
 */
@interface FFDropDownMenuVC : FFViewController

/**
 *  快速实例化一个下拉菜单
 *
 *  @param model               下拉菜单模型
 *  @param menuWidth           菜单的宽度
 *  @param eatchItemHeight     每一个选项的高度
 *  @param nemuRightMargin     菜单条离屏幕右边的边距
 *  @param triangleRightMargin 三角形的右边距
 *  @param alpha               背景颜色的透明度(效果:灰色蒙板)
 *  @param bgColorBeginAlpha   背景颜色开始时的透明度(还没展示menu的透明度)
 *  @param bgColorEndAlpha     背景颜色结束的的透明度(menu完全展示的透明度)
 *
 *  @return 实例化的一个下拉菜单对象
 */
+ (instancetype)dropDownMenuWithDropDownMenuModel:(FFDropDownMenuModel *)model menuWidth:(CGFloat)menuWidth eatchItemHeight:(CGFloat)eatchItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin bgColorBeginAlpha:(CGFloat)bgColorBeginAlpha bgColorEndAlpha:(CGFloat)bgColorEndAlpha;


/** 弹出菜单 */
- (void)showMenu;

@end

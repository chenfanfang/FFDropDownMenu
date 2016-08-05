//
//  FFDropDownMenuVC.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

//model
#import "FFDropDownMenuModel.h"


/**
 *  下拉菜单控制器
 */
@interface FFDropDownMenuView : UIView

/**
 *  快速实例化一个下拉菜单
 *
 *  @param menuModelsArray     菜单模型数组
 *  @param menuWidth           菜单的宽度
 *  @param eatchItemHeight     每一个选项的高度
 *  @param nemuRightMargin     菜单条离屏幕右边的边距
 *  @param triangleRightMargin 三角形的右边距
 *  @param triangleSize        三角形的size  size.width:代表三角形底部边长，size.Height:代表三角形的高度
 *  @param bgColorBeginAlpha   背景颜色开始时的透明度(还没展示menu的透明度)
 *  @param bgColorEndAlpha     背景颜色结束的的透明度(menu完全展示的透明度)
 *  @param animateDuration     动画效果的时间
 *  @return 实例化的一个下拉菜单对象
 */
+ (instancetype)ff_DropDownMenuWithMenuModelsArray:(NSArray<FFDropDownMenuModel *> *)menuModelsArray menuWidth:(CGFloat)menuWidth eatchItemHeight:(CGFloat)eatchItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin triangleSize:(CGSize)triangleSize bgColorBeginAlpha:(CGFloat)bgColorBeginAlpha bgColorEndAlpha:(CGFloat)bgColorEndAlpha animateDuration:(CGFloat)animateDuration;


/** 弹出菜单 */
- (void)showMenu;

@end

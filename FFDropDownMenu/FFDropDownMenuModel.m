//
//  FFDropDownMenuModel.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuModel.h"

@implementation FFDropDownMenuModel

/**
 *  快速实例化一个下拉菜单模型
 *
 *  @param menuItemTitle    菜单选项的标题
 *  @param menuItemIconName 菜单选项的图标名称
 *  @param extra            若觉得:标题、图标名称、回调的block三个属性不够用，可以再传个extra属性(若没有自定义cell,传nil即可)
 *  @param menuBlock        点击的回调block
 *
 *  @return 实例化的菜单模型
 */
+ (instancetype)ff_DropDownMenuModelWithMenuItemTitle:(NSString *)menuItemTitle menuItemIconName:(NSString *)menuItemIconName extra:(id)extra menuBlock:(FFMenuBlock)menuBlock {
    FFDropDownMenuModel *model = [FFDropDownMenuModel new];
    model.menuItemTitle = menuItemTitle;
    model.menuItemIconName = menuItemIconName;
    model.extra = extra;
    model.menuBlock = menuBlock;
    return model;
}

@end

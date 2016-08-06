//
//  FFDropDownMenuModel.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuBasedModel.h"

/**
 *  下拉菜单模型
 */
@interface FFDropDownMenuModel : FFDropDownMenuBasedModel


/** 菜单选项标题 */
@property (nonatomic, copy) NSString *menuItemTitle;

/** 菜单选项图标名称 */
@property (nonatomic, copy) NSString *menuItemIconName;



/**
 *  快速实例化一个下拉菜单模型
 *
 *  @param menuItemTitle    菜单选项的标题
 *  @param menuItemIconName 菜单选项的图标名称
 *  @param menuBlock        点击的回调block
 *
 *  @return 实例化的菜单模型
 */
+ (instancetype)ff_DropDownMenuModelWithMenuItemTitle:(NSString *)menuItemTitle menuItemIconName:(NSString *)menuItemIconName menuBlock:(FFMenuBlock)menuBlock;

@end

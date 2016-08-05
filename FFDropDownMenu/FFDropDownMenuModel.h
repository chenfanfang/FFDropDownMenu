//
//  FFDropDownMenuModel.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

//定义一个菜单的block
typedef void(^FFMenuBlock)();

/**
 *  下拉菜单模型
 */
@interface FFDropDownMenuModel : NSObject

/**标题数组*/
@property (nonatomic, strong) NSArray *titlesArray;

/** 图标 */
@property (nonatomic, strong) NSArray *imagesArray;

/**回调block数组，将回调bLock保存在数组中*/
@property (nonatomic, strong) NSArray *callBackBlocksArray;


/** 菜单选项标题 */
@property (nonatomic, copy) NSString *menuItemTitle;

/** 菜单选项图标名称 */
@property (nonatomic, copy) NSString *menuItemIconName;

/** 点击回调的block */
@property (nonatomic, copy) FFMenuBlock menuBlock;

/** 扩展的属性(额外的属性) */
@property (nonatomic, strong) id extra;

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
+ (instancetype)ff_DropDownMenuModelWithMenuItemTitle:(NSString *)menuItemTitle menuItemIconName:(NSString *)menuItemIconName extra:(id)extra menuBlock:(FFMenuBlock)menuBlock;

@end

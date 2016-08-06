//
//  FFDropDownMenuBasedModel.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/8/6.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义一个菜单的block
typedef void(^FFMenuBlock)();

/**
 *  下拉菜单的基本模型，所有自定义模型必须继承这个模型
 *
 *  注意:若自定义一个继承于这个类的菜单模型，必须要自定义一个继承于FFDropDownMenuBasedCell的菜单cell
 */
@interface FFDropDownMenuBasedModel : NSObject

/** 点击回调的block */
@property (nonatomic, copy) FFMenuBlock menuBlock;

@end

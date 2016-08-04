//
//  FFDropDownMenuModel.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>
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

@end

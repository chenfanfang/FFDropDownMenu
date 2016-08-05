//
//  FFDropDownMenuCell.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FFDropDownMenuModel;

/**
 *  下拉菜单cell
 */
@interface FFDropDownMenuCell : UITableViewCell

/** 菜单模型 */
@property (nonatomic, strong) FFDropDownMenuModel *menuModel;

@end

//
//  FFDropDownMenuCell.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuBasedCell.h"

/**
 *  下拉菜单cell
 */
@interface FFDropDownMenuCell : FFDropDownMenuBasedCell

/** 底部分割线 */
@property (nonatomic, weak) UIView *separaterView;

/** 图片 */
@property (weak, nonatomic) UIImageView *customImageView;

/** 标题 */
@property (weak, nonatomic) UILabel *customTitleLabel;


/** 默认菜单样式 的字体颜色 */
@property (nonatomic, assign) UIColor *titleColor;

/** 默认菜单样式 的字体大小 */
@property (nonatomic, assign) NSInteger titleFontSize;

/** 默认菜单样式 要显示的图片的size */
@property (nonatomic, assign) CGSize iconSize;

/** 默认菜单样式 图片的左边距 */
@property (nonatomic, assign) CGFloat iconLeftMargin;

/** 默认菜单样式 图片的右边距(也就是和标题之间的边距) */
@property (nonatomic, assign) CGFloat iconRightMargin;


@end

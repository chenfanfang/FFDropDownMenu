//
//  FFDropDownMenuCell.h
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  下拉菜单cell
 */
@interface FFDropDownMenuCell : UITableViewCell


/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *customTitleLabel;

@end

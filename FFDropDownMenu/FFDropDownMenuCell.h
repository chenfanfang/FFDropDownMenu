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

#warning 我为了方便将控件暴露在了.h文件，严谨的做法是不暴露在.h文件

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *customTitleLabel;

@end

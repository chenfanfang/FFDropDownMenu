//
//  FFDropDownMenuCell.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuCell.h"

//model
#import "FFDropDownMenuModel.h"

@interface FFDropDownMenuCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *customTitleLabel;

@end

@implementation FFDropDownMenuCell

- (void)setMenuModel:(FFDropDownMenuModel *)menuModel {
    _menuModel = menuModel;
    
    self.customTitleLabel.text = menuModel.menuItemTitle;
    //给imageView赋值
    self.customImageView.image = [UIImage imageNamed:menuModel.menuItemIconName];
}

@end

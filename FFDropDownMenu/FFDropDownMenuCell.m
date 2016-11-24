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

//other
#import "FFDropDownMenu.h"

@interface FFDropDownMenuCell ()

@end

@implementation FFDropDownMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //初始化子控件
        UIImageView *customImageView = [[UIImageView alloc] init];
        customImageView.clipsToBounds = YES;
        customImageView.layer.masksToBounds = YES;
        customImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:customImageView];
        self.customImageView = customImageView;
        
        UILabel *customTitleLabel = [[UILabel alloc] init];
        customTitleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:customTitleLabel];
        self.customTitleLabel = customTitleLabel;
        
        UIView *separaterView = [[UIView alloc] init];
        separaterView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
        [self addSubview:separaterView];
        self.separaterView = separaterView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //frame的赋值
    CGFloat separaterHeight = 1; //底部分割线高度
    
    //图片 customImageView
    
    self.customImageView.frame = CGRectMake(self.iconLeftMargin, (self.frame.size.height - separaterHeight - self.iconSize.height) * 0.5 ,self.iconSize.width, self.iconSize.height);
    
    //标题
    CGFloat labelX = CGRectGetMaxX(self.customImageView.frame) + self.iconRightMargin;
    self.customTitleLabel.frame = CGRectMake(labelX, 0, self.frame.size.width - labelX, self.frame.size.height - separaterHeight);
    
    
    //分割线
    self.separaterView.frame = CGRectMake(0, self.frame.size.height - separaterHeight, self.frame.size.width, separaterHeight);
}


//=================================================================
//                            set方法
//=================================================================
#pragma mark - set方法

- (void)setMenuModel:(id)menuModel {
    _menuModel = menuModel;
    
    FFDropDownMenuModel *realMenuModel = (FFDropDownMenuModel *)menuModel;
    self.customTitleLabel.text = realMenuModel.menuItemTitle;
    
    //给imageView赋值
    if (realMenuModel.menuItemIconName.length) {
        self.customImageView.image = [UIImage imageNamed:realMenuModel.menuItemIconName];
        
    } else {
        FFLog(@"您传入的图片为空图片,框架内部默认不做任何处理。若您的确不想传入图片，则请忽略此处打印");
    }
    
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.customTitleLabel.textColor = titleColor;
}

- (void)setTitleFontSize:(NSInteger)titleFontSize {
    _titleFontSize = titleFontSize;
    
    self.customTitleLabel.font = [UIFont systemFontOfSize:titleFontSize];
}

@end

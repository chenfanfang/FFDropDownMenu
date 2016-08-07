//
//  FFDropDownMenuVC.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

//model
#import "FFDropDownMenuModel.h"


//宏
#define FFDefaultFloat -10.0
#define FFDefaultSize CGSizeMake(20, 10)
#define FFDefaultCell @"FFDropDownMenuCell"
#define FFDefaultColor [UIColor whiteColor]
#define FFDefaultMenuScaleType FFDropDownMenuViewScaleType_TopRight

/**
 *  菜单的伸缩类型
 */
typedef NS_ENUM(NSInteger, FFDropDownMenuViewScaleType) {
    /**
     *  以右上角为基点进行伸缩
     */
    FFDropDownMenuViewScaleType_TopRight = 0, //default
    /**
     *  以左上角为基点进行伸缩
     */
    FFDropDownMenuViewScaleType_TopLeft,
    /**
     *  以中点为基点进行伸缩
     */
    FFDropDownMenuViewScaleType_Middle
};

/**
 *  下拉菜单控制器
 */
@interface FFDropDownMenuView : UIView




///------------------------
///    创建下拉菜单方式1
/// 适用于使用默认的下拉菜单样式
///------------------------

/**
 *  快速实例化一个默认样式的下拉菜单
 *  >>>>注意:若还需要对个别属性进行赋值、可以再单独对个别属性进行赋值。但是最后一定要调用 setup方法
 *
 *
 *  @param menuModelsArray     下拉菜单模型数组,数组中存放着(FFDropDownMenuModel模型对象)
 *  @param menuWidth           菜单的宽度                ---- 若要使用默认宽度、传FFDefaultFloa
 *  @param eachItemHeight      每一个选项的高度           ---- 若要使用默认高度、传FFDefaultFloat
 *  @param menuRightMargin     菜单条离屏幕右边的间距      ---- 若要使用默认间距、传FFDefaultFloat
 *  @param triangleRightMargin 三角形距离屏幕右边的间距    ---- 若要使用默认间距、传FFDefaultFloat
 *
 *  @return 实例化的一个下拉菜单对象
*/

+ (instancetype)ff_DefaultStyleDropDownMenuWithMenuModelsArray:(NSArray<FFDropDownMenuModel *> *)menuModelsArray menuWidth:(CGFloat)menuWidth eachItemHeight:(CGFloat)eachItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin;




///------------------------------------------------------------------
///          创建下拉菜单方式2
///   适用于自定义下拉菜单样式，单个属性进行赋值
///   >>步骤:
///   1、 [FFDropDownMenuView alloc] init]
///   2、 对需要赋值的属性进行赋值
///       >>>>>若要使用默认值，可以不对属性进行赋值，或者赋值 FFDefault....
///
///   3、 调用 setup方法
///------------------------------------------------------------------




/** 1、下拉菜单模型数组(数组里面存放 FFDropDownMenuBasedModel的子类的对象) */
@property (nonatomic, strong) NSArray *menuModelsArray;

/** 2、cell的类名，必须是FFDropDownMenuBasedCell 或者是FFDropDownMenuBasedCell的子类
 *             若用框架自带的cell  直接传@"FFDropDownMenuCell"
 *             自定义的cell,就传自定义cell的类名,若cell是xib,则传@"类名.xib"
 *             如:@"FFDropDownMenuCell.xib"
 *             若不设置，默认为 @"FFDropDownMenuCell"
 */
@property (nonatomic, copy) NSString *cellClassName;

/** 3、菜单的宽度(若不设置，默认为 150) */
@property (nonatomic, assign) CGFloat menuWidth;

/** 4、菜单的圆角半径(若不设置，默认为5) */
@property (nonatomic, assign) CGFloat menuCornerRadius;

/** 5、每一个选项的高度(若不设置，默认为40) */
@property (nonatomic, assign) CGFloat eachMenuItemHeight;

/** 6、菜单条离屏幕右边的间距(若不设置，默认为10) */
@property (nonatomic, assign) CGFloat menuRightMargin;

/** 7、三角形颜色(若不设置，默认为白色) */
@property (nonatomic, strong) UIColor *triangleColor;

/** 8、三角形相对于keyWindow的y值,也就是相对于屏幕顶部的y值(若不设置，默认为64) */
@property (nonatomic, assign) CGFloat triangleY;

/** 9、三角形距离屏幕右边的间距(若不设置，默认为20) */
@property (nonatomic, assign) CGFloat triangleRightMargin;

/** 10、三角形的size  size.width:代表三角形底部边长，size.Height:代表三角形的高度(若不设置，默认为CGSizeMake(15, 10)) */
@property (nonatomic, assign) CGSize triangleSize;

/** 11、背景颜色开始时的透明度(还没展示menu的透明度)(若不设置，默认为0.02) */
@property (nonatomic, assign) CGFloat bgColorbeginAlpha;

/** 12、背景颜色结束的的透明度(menu完全展示的透明度)(若不设置，默认为0.2) */
@property (nonatomic, assign) CGFloat bgColorEndAlpha;

/** 13、动画效果时间(若不设置，默认为0.2) */
@property (nonatomic, assign) CGFloat animateDuration;

/** 14、菜单的伸缩类型 */
@property (nonatomic, assign) FFDropDownMenuViewScaleType menuScaleType;




/** 初始化(当所有属性调用完毕，一定要调用这个方法) */
- (void)setup;

/** 弹出菜单 */
- (void)showMenu;

@end

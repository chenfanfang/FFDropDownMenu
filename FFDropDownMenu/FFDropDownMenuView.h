//
//  FFDropDownMenuVC.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <UIKit/UIKit.h>

//model
#import "FFDropDownMenuBasedModel.h"
#import "FFDropDownMenuModel.h"

//cell
#import "FFDropDownMenuBasedCell.h"
#import "FFDropDownMenuCell.h"


//default value
#define FFDefaultFloat -10.0
#define FFDefaultSize CGSizeMake(18, 10)
#define FFDefaultCell @"FFDropDownMenuCell"
#define FFDefaultColor [UIColor whiteColor]
#define FFDefaultMenuScaleType FFDropDownMenuViewAnimateType_ScaleBasedTopRight

//rgb color  r-red 、  g-green  、  b-blue  、 a-alpha
#define FFColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/**
 *  dropdownMenu animationType.
 *  菜单展现的动画类型
 */
typedef NS_ENUM(NSInteger, FFDropDownMenuViewAnimateType) {
    /**
     *  scale based the point of upper right corner.
     *  以右上角为基点进行伸缩
     */
    FFDropDownMenuViewAnimateType_ScaleBasedTopRight = 0, //default
    /**
     *  scale based the point of upper left corner.
     *  以左上角为基点进行伸缩
     */
    FFDropDownMenuViewAnimateType_ScaleBasedTopLeft,
    /**
     *  scale based the middle point
     *  以中点为基点进行伸缩
     */
    FFDropDownMenuViewAnimateType_ScaleBasedMiddle,
    /**
     *  fade in fade out
     *  淡入淡出效果
     */
    FFDropDownMenuViewAnimateType_FadeInFadeOut,
    /**
     *  animate like RollerShutter
     *  卷帘效果
     */
    FFDropDownMenuViewAnimateType_RollerShutter,
    /**
     *  fall from top
     *  从上往下落下
     */
    FFDropDownMenuViewAnimateType_FallFromTop,
};

/**
 *  drop-down menu
 *  下拉菜单
 */
@interface FFDropDownMenuView : UIView




///=========================
///    创建下拉菜单方式1
/// 适用于使用默认的下拉菜单样式
///=========================

/**
 *  快速实例化一个默认样式的下拉菜单
 *  >>>>注意:若还需要对个别属性进行赋值、可以再单独对个别属性进行赋值。但是最后一定要调用 setup方法
 *
 *
 *  @param menuModelsArray     下拉菜单模型数组,数组中存放着(FFDropDownMenuModel模型对象)
 *  @param menuWidth           菜单的宽度                ---- 若要使用默认宽度、传FFDefaultFloat
 *  @param eachItemHeight      每一个选项的高度           ---- 若要使用默认高度、传FFDefaultFloat
 *  @param menuRightMargin     菜单条离屏幕右边的间距      ---- 若要使用默认间距、传FFDefaultFloat
 *  @param triangleRightMargin 三角形距离屏幕右边的间距    ---- 若要使用默认间距、传FFDefaultFloat
 *
 *  @return 实例化的一个下拉菜单对象
 */



///English description:
///============================================================
///         create a drop-down menu method one
///  Applicable to the use of the default drop-down menu style
///============================================================

/**
 *  fast instance a default style drop-down menu
 *  >>>>Note:If you need to assign the other attributes, you can assign the other attributes separately. But at the end of the setup method must be called.
 *
 *  @param menuModelsArray     drop-down menu models array. Array storage FFDropDownMenuModel instances
 *  @param menuWidth           drop-down menu's width                --- if want to use default width , pass FFDefaultFloat
 *  @param eachItemHeight      each item height                      --- if want to use default height, pass FFDefaultFloat
 *  @param menuRightMargin     drop-down menu from the right margin  --- if want to use default margin, pass FFDefaultFloat
 *  @param triangleRightMargin triangle from the right margin        --- if want to use default margin, pass FFDefaultFloat
 *
 *  @return An initialized drop-down menu
 */
+ (instancetype)ff_DefaultStyleDropDownMenuWithMenuModelsArray:(NSArray *)menuModelsArray menuWidth:(CGFloat)menuWidth eachItemHeight:(CGFloat)eachItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin;




///==================================================================
///                    创建下拉菜单方式2
///   适用于自定义下拉菜单样式，单个属性进行赋值
///   >>步骤:
///   1、 [FFDropDownMenuView alloc] init]
///   2、 对需要赋值的属性进行赋值
///       >>>>>若要使用默认值，可以不对属性进行赋值，或者赋值 FFDefault....
///
///   3、 调用 setup方法
///==================================================================

///English description:
///==================================================================
///               create a drop-down menu method two
///   Applicable to the use of the custom drop-down menu style
///   >>step:
///   1、 [FFDropDownMenuView alloc] init]
///   2、 Assign to the properties that need to be assigned.
///       >>>>>if want to use the default value，not assign or assign FFDefault....
///
///   3、 call setup method
///==================================================================




/** 1、下拉菜单模型数组(数组里面存放 FFDropDownMenuBasedModel的子类的对象) 
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     drop-down menu models array(Array storage FFDropDownMenuModel instances or the FFDropDownMenuModel's subclass instances )
 */
@property (nonatomic, strong) NSArray *menuModelsArray;

/** 2、cell的类名, 必须是FFDropDownMenuBasedCell的子类
 *               若用框架自带的cell,直接传@"FFDropDownMenuCell"
 *               若使用自定义的cell,就传自定义cell的类名,若cell是xib,则传@"类名.xib"
 *                     举例如下:
 *                            ----->非xibcell   举例:@"YourCustomMenuCell"
 *                            ----->xib的cell   举例:@"YourCustomMenuCell.xib"
 *
 *               若不设置，默认为 @"FFDropDownMenuCell"
 *
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     drop-down nemu cell's class name. Must be a subclass of FFDropDownMenuBasedCell
 *              If want to use this framework's drop-down nemu cell, direct pass @"FFDropDownMenuCell"
 *              If you use a custom cell, pass the custom cell class name, if cell is from Xib, then pass @"className.xib"
 *                  for example:
 *                              ----->cell is from code   pass @"YourCustomMenuCell"
 *                              ----->cell is from xib    pass @"YourCustomMenuCell.xib"
 */
@property (nonatomic, copy) NSString *cellClassName;

/** 3、菜单的宽度(若不设置，默认为 150.0)
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     menu's width (if not assign, default value is 150.0)
 */
@property (nonatomic, assign) CGFloat menuWidth;

/** 4、菜单的圆角半径(若不设置，默认为5.0)
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     menu's cornerRadius (if not assign, default value is 5.0)
 */
@property (nonatomic, assign) CGFloat menuCornerRadius;

/** 5、每一个选项的高度(若不设置，默认为40.0)
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     each menu item height (if not assign, default value is 40.0)
 */
@property (nonatomic, assign) CGFloat eachMenuItemHeight;

/** 6、菜单条离屏幕右边的间距(若不设置，默认为10.0)
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     drop-down menu from the right margin(if not assign, default value is 10.0)
 */
@property (nonatomic, assign) CGFloat menuRightMargin;

/** 7、菜单选项的背景颜色(若不设置，默认为白色、可以用FFColor(r, g, b, a) 设置带透明度的颜色) 
 *     若是自定义cell,如果在自定义cell中设置了cell中子控件的颜色，这个属性将不起作用
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     drop-down menu item background color (if not assign, default color is white color.)
 *            you can use FFColor(r, g, b, a) to set a color with alpha.
 *     if you use custom cell and you set cell's background color or 
 *            set cell's subview background color, this attribute will be affected
 */

@property (nonatomic, strong) UIColor *menuItemBackgroundColor;

/** 8、三角形颜色(若不设置，默认为白色、可以用FFColor(r, g, b, a) 设置带透明度的颜色) 
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     triangle color (if not assign, default color is white color) 
 *                    you can use FFColor(r, g, b, a) to set a color with alpha)
 */
@property (nonatomic, strong) UIColor *triangleColor;

/** 9、三角形相对于keyWindow的y值,也就是相对于屏幕顶部的y值(若不设置，默认为64.0)
 *          注意:整个下拉菜单距离屏幕顶部的距离是由triangleY来控制的
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     triangle's y relative screen's top  (if not assign, default value is 64.0)
 *          note:The drop-down menu's distance to screen'top is controlled by triangleY.
 */
@property (nonatomic, assign) CGFloat triangleY;

/** 10、三角形距离屏幕右边的间距(若不设置，默认为20.0)
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     triangle from the right margin  (if not assign, default value is 20.0)
 */
@property (nonatomic, assign) CGFloat triangleRightMargin;

/** 11、三角形的size  size.width:代表三角形底部边长，size.height:代表三角形的高度
 *      若不设置，默认为CGSizeMake(18, 10)
 *      若不需要显示三角形，设置方式如下三种,具体使用哪种，取决于你的需求
 *         <1>   CGSizeMake(0, 0)
 *         <2>   CGSizeMake(宽度, 0)
 *         <3>   CGSizeMake(0, 高度)
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     triangle size   size.width:triangle bottom width.   size.height:triangle height
 *          (if not assign, default value is CGSizeMake(18, 10)   )
 *     if you want to hidden triangle, there have three method
 *         <1>   CGSizeMake(0, 0)
 *         <2>   CGSizeMake(width, 0)
 *         <3>   CGSizeMake(0, height)
 */
@property (nonatomic, assign) CGSize triangleSize;

/** 12、背景颜色开始时的透明度(还没展示menu的透明度)(若不设置，默认为0.02) 
 *      背景颜色的透明度就是除去菜单外的灰色蒙板的透明度
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     mask begin color alpha .(Did not show the menu background clolor alpha)(color is black color)
 *          (if not assign, default value is 0.02)
 */
@property (nonatomic, assign) CGFloat bgColorbeginAlpha;

/** 13、背景颜色结束的的透明度(menu完全展示的透明度)(若不设置，默认为0.2) 
 *      背景颜色的透明度就是除去菜单外的灰色蒙板的透明度
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     mask end color alpha .(already show the menu background color alpha)(color is black color)
 *          (if not assign, default value is 0.2)
 */
@property (nonatomic, assign) CGFloat bgColorEndAlpha;

/** 14、动画效果时间(若不设置，默认为0.2) 
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     animate duration (if not assign, default value is 0.2)
 */
@property (nonatomic, assign) CGFloat animateDuration;

/** 15、菜单的弹出的动画效果类型 
 *     -----------------------------------------------------------
 *     English description:
 *     -----------------------------------------------------------
 *     show drop-down menu animate type. (if not assign, default value is FFDropDownMenuViewAnimateType_ScaleBasedTopRight)
 */
@property (nonatomic, assign) FFDropDownMenuViewAnimateType menuAnimateType;



/** 初始化(当所有属性调用完毕，一定要调用这个方法)
 */
- (void)setup;

/** 弹出菜单 */
- (void)showMenu;

@end

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
 *  快速实例化一个默认样式的下拉菜单(注：实例化完成，无需调用setup方法)
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




///------------------------
///    创建下拉菜单方式2
///  适用于自定义下拉菜单样式
///------------------------

/**
 *  实例化一个下拉菜单
 *         (注：实例化完成，可以重新对单独的属性重新赋值，然后调用setup方法
 *              若实例化完成，不重新对单独的属性重新赋值，无需调用setup方法)
 *
 *  @param menuModelsArray     下拉菜单模型数组<里面存放 FFDropDownMenuBasedModel的子类的对象>
 *  @param cellClassName       cell的类名，必须是 FFDropDownMenuBasedCell 的子类
 *                             自定义的cell,就传自定义cell的类名,若cell是xib,则传@"类名.xib" 
 *                             如:@"FFDropDownMenuCell.xib" 
 *                                                     ---- 若要使用默认cell、传FFDefaultCell
 *
 *  @param menuWidth           菜单的宽度               ---- 若要使用默认宽度、传FFDefaultFloat
 *  @param eachItemHeight     每一个选项的高度           ---- 若要使用默认高度、传FFDefaultFloat
 *  @param nemuRightMargin     菜单条离屏幕右边的间距      ---- 若要使用默认间距、传FFDefaultFloat
 *  @param triangleColor       三角形的颜色              ---- 若要使用默认颜色、传FFDefaultColor
 *  @param triangleY           三角形相对于keyWindow的y值,也就是相对于屏幕顶部的y值
 *                                                     ---- 若要使用默认y值、传FFDefaultFloat
 *
 *  @param triangleRightMargin 三角形距离屏幕右边的间距    ---- 若要使用默认间距、传FFDefaultFloat
 *
 *  @param triangleSize        三角形的size  size.width:代表三角形底部边长，size.Height:代表三角形的高度
 *                                                     ---- 若要使用默认size、传FFDefaultSize
 *
 *  @param bgColorBeginAlpha   背景颜色开始时的透明度(还没展示menu的透明度)
 *                                                     ---- 若要使用默认透明度、传FFDefaultFloat
 *
 *  @param bgColorEndAlpha     背景颜色结束的的透明度(menu完全展示的透明度)
 *                                                     ---- 若要使用默认透明度、传FFDefaultFloat
 *
 *  @param animateDuration     动画效果的时间            ---- 若要使用默认时间、传FFDefaultFloat
 *  @param menuScaleType       菜单的伸缩类型            ---- 若要使用默认伸缩类型、传FFDefaultMenuScaleType
 *
 *  @return 实例化的一个下拉菜单对象
 */
+ (instancetype)ff_DropDownMenuWithMenuModelsArray:(NSArray *)menuModelsArray cellClassName:(NSString *)cellClassName menuWidth:(CGFloat)menuWidth menuCornerRadius:(CGFloat)menuCornerRadius eachItemHeight:(CGFloat)eachItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleColor:(UIColor *)triangleColor triangleY:(CGFloat)triangleY triangleRightMargin:(CGFloat)triangleRightMargin triangleSize:(CGSize)triangleSize bgColorBeginAlpha:(CGFloat)bgColorBeginAlpha bgColorEndAlpha:(CGFloat)bgColorEndAlpha animateDuration:(CGFloat)animateDuration menuScaleType:(FFDropDownMenuViewScaleType)menuScaleType;


///-------------------------------------------------------------------
///          创建下拉菜单方式3
///   适用于自定义下拉菜单样式，单个属性进行赋值
///   >>步骤:
///   1、 [FFDropDownMenuView alloc] init]
///   2、 对需要赋值的属性进行赋值
///       >>>>>>>>若要使用默认值，可以不对属性进行赋值，或者赋值 FFDefault....
///
///   3、 调用 setup方法
///-------------------------------------------------------------------




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

//
//  FFDropDownMenuVC.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuView.h"

//view
#import "FFDropDownMenuTriangleView.h"

//other
#import "FFDropDownMenu.h"


@interface FFDropDownMenuView ()<UITableViewDataSource, UITableViewDelegate>

/**tableView*/
@property (nonatomic, weak)  UITableView *tableView;

@property (nonatomic, strong) FFDropDownMenuTriangleView *triangleView;

/** 真实的三角形的Y(这个属性是用于状态栏的改变) */
@property (nonatomic, assign) CGFloat realTriangleY;

/** 视图是否在显示*/
@property (nonatomic, assign) BOOL isShow;

/** cell是否是正确格式的cell */
@property (nonatomic, assign) BOOL isCellCorrect;

/** tableView的frame */
@property (nonatomic, assign) CGRect menuViewFrame;

/** 菜单view的容器 */
@property (nonatomic, strong) UIView *menuContentView;

@end

@implementation FFDropDownMenuView


//=================================================================
//                        生命周期<life circle>
//=================================================================
#pragma mark - 生命周期<life circle>

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.menuContentView = [[UIView alloc] init];
        self.menuContentView.backgroundColor = [UIColor clearColor];
        self.menuContentView.clipsToBounds = YES;
        [self addSubview:self.menuContentView];
        
        //默认属性的赋值<assign>
        self.cellClassName = @"FFDropDownMenuCell";
        self.menuWidth = 150;
        self.menuCornerRadius = 5;
        self.eachMenuItemHeight = 40;
        self.menuRightMargin = 10;
        self.menuItemBackgroundColor = [UIColor whiteColor];
        self.triangleColor = [UIColor whiteColor];
        self.triangleY = 64;
        self.realTriangleY = self.triangleY;
        self.triangleRightMargin = 20;
        self.triangleSize = FFDefaultSize;
        self.bgColorbeginAlpha = 0.02;
        self.bgColorEndAlpha = 0.2;
        self.animateDuration = 0.2;
        self.menuAnimateType = FFDropDownMenuViewAnimateType_ScaleBasedTopRight;
        
        self.isCellCorrect = NO;
        self.isShow = NO;
        
        //监听状态栏高度改变的通知<observe statusbar height change notification>
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarHeightChanged:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
        
        //监听状态栏的旋转<observe statusbar orientation change notification>
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//=================================================================
//                  快速实例化一个菜单对象<farst instance>
//=================================================================
#pragma mark - 快速实例化一个菜单对象<farst instance>

+ (instancetype)ff_DefaultStyleDropDownMenuWithMenuModelsArray:(NSArray *)menuModelsArray menuWidth:(CGFloat)menuWidth eachItemHeight:(CGFloat)eachItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin {
    
    FFDropDownMenuView *menuView = [FFDropDownMenuView new];
    
    menuView.menuModelsArray = menuModelsArray;
    menuView.menuWidth = menuWidth;
    menuView.eachMenuItemHeight = eachItemHeight;
    menuView.menuRightMargin = menuRightMargin;
    menuView.triangleRightMargin = triangleRightMargin;
    
    [menuView setup];
    return menuView;
}


//=================================================================
//                         初始化<setup>
//=================================================================
#pragma mark - 初始化<setup>

- (void)setup {
    [_tableView removeFromSuperview];
    _tableView = nil;
    
    //屏幕的size  <screen size>
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    //设置view的圆角、frame  <set view's cornerRadius and frame>
    self.frame = [UIScreen mainScreen].bounds;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorEndAlpha];
    
    //设置三角形的frame <set triangle frame>
    CGFloat horizonWidth = screenSize.width; //水平的宽度
    
    self.triangleView.frame = CGRectMake(horizonWidth - self.triangleRightMargin - self.triangleSize.width, self.realTriangleY, self.triangleSize.width, self.triangleSize.height);
    self.triangleView.triangleColor = self.triangleColor;
    
    //tableView的frame <set tableView frame>
    self.menuViewFrame = CGRectMake(horizonWidth - self.menuWidth - self.menuRightMargin, CGRectGetMaxY(self.triangleView.frame), self.menuWidth, self.eachMenuItemHeight * self.menuModelsArray.count);
    self.menuContentView.frame = self.menuViewFrame;
    self.tableView.frame = self.menuContentView.bounds;
    [self.tableView reloadData];
}


//=================================================================
//                    横竖屏适配<Screen adaptation>
//=================================================================
#pragma mark - 横竖屏适配<Screen adaptation>
/** 横竖屏的改变 */
- (void)statusBarOrientationChange:(NSNotification *)note {
    [self setup];
}

/** 状态栏frame的变化 */
- (void)statusBarHeightChanged:(NSNotification *)note {
    CGRect statusBarFrame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];

    //正常的状态栏高度是20
    CGFloat normalStatusBarHeight = 20;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    //FFLog(@"%@",NSStringFromCGRect(statusBarFrame));
    
    
    CGFloat screenWidth = 0;
    CGFloat screenHeight = 0;
    if (screenSize.height > screenSize.width) {
        screenWidth = screenSize.width;
        screenHeight = screenSize.height;
    }
    
    else {
        screenWidth = screenSize.height;
        screenHeight = screenSize.width;
    }
    
    
    //横屏
    if (statusBarFrame.origin.y >= screenWidth || //横屏: statusBarFrame = {{0, 375}, {0, 0}}
        statusBarFrame.size.width >= screenHeight || //横屏: statusBarFrame = {{0, 0}, {667, 20}}
        statusBarFrame.origin.x >= screenHeight) { //横屏:{{568, 0}, {0, 0}}
        self.realTriangleY = self.triangleY - (44 - 32) - normalStatusBarHeight; //竖屏导航栏44， 横屏:32
        
    } else { //竖屏
        if (statusBarFrame.size.height == 0) {
            self.realTriangleY = self.triangleY;
            
        } else {
            self.realTriangleY = self.triangleY + (statusBarFrame.size.height - normalStatusBarHeight);
        }
        
    }
    
    [self setup];
}




//=================================================================
//                         懒加载<lazy load>
//=================================================================
#pragma mark - 懒加载<lazy load>

static NSString *const CellID = @"CellID";

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor clearColor];
        [self.menuContentView addSubview:tableView];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.clipsToBounds = YES;
        tableView.layer.masksToBounds = YES;
        self.menuContentView.layer.cornerRadius = self.menuCornerRadius;
        tableView.layer.cornerRadius = self.menuCornerRadius;
        //锚点的设置 <set anchorPoint>
        switch (self.menuAnimateType) {
            case FFDropDownMenuViewAnimateType_ScaleBasedTopRight: //右上角
                tableView.layer.anchorPoint = CGPointMake(1, 0);
                break;
            case FFDropDownMenuViewAnimateType_ScaleBasedTopLeft: //左上角
                tableView.layer.anchorPoint = CGPointMake(0, 0);
                break;
            case FFDropDownMenuViewAnimateType_ScaleBasedMiddle: //中间
                break;
            case FFDropDownMenuViewAnimateType_FadeInFadeOut: //淡入淡出效果
                break;
            case FFDropDownMenuViewAnimateType_RollerShutter: //卷帘效果
                tableView.layer.anchorPoint = CGPointMake(0.5, 1);
                break;
            case FFDropDownMenuViewAnimateType_FallFromTop:
            break;
                
            default:
                break;
        }
        
        
        //注册cell <register cell>
        if ([self.cellClassName hasSuffix:@".xib"]) { //xib名称
            NSString *className = [self.cellClassName componentsSeparatedByString:@".xib"].firstObject;
            if (!NSClassFromString(className)) {
                FFLog(@"%@这个类不存在,请查看项目中是否有该类",className);
                return _tableView;
            }
            
            if (![NSClassFromString(className) isSubclassOfClass:[FFDropDownMenuBasedCell class]]) {
                FFLog(@"%@这个类不是FFDropDownMenuBasedCell的子类,请继承这个类",className);
                return _tableView;
            }
            
            self.isCellCorrect = YES;
            UINib *cellNib = [UINib nibWithNibName:className bundle:nil];
            [tableView registerNib:cellNib forCellReuseIdentifier:CellID];
            
        } else { //cell类名
            if (!NSClassFromString(self.cellClassName)) {
                FFLog(@"%@这个类不存在,请查看项目中是否有该类",self.cellClassName);
                return _tableView;
            }
            
            if (![NSClassFromString(self.cellClassName) isSubclassOfClass:[FFDropDownMenuBasedCell class]]) {
                FFLog(@"%@这个类不是FFDropDownMenuBasedCell的子类,请继承这个类",self.cellClassName);
                return _tableView;
            }
            
            self.isCellCorrect = YES;
            [tableView registerClass:NSClassFromString(self.cellClassName) forCellReuseIdentifier:CellID];
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

- (FFDropDownMenuTriangleView *)triangleView {
    if (_triangleView == nil) {
        FFDropDownMenuTriangleView *triangleView = [[FFDropDownMenuTriangleView alloc] init];
        [self addSubview:triangleView];
        triangleView.backgroundColor = [UIColor clearColor];
        _triangleView = triangleView;
    }
    return _triangleView;
}





//=================================================================
//                       UITableViewDataSource
//=================================================================
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuModelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isCellCorrect == NO) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    FFDropDownMenuBasedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.backgroundColor = self.menuItemBackgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FFDropDownMenuBasedModel *menuModel = self.menuModelsArray[indexPath.row];
    cell.menuModel = menuModel;
    return cell;
}



//=================================================================
//                       UITableViewDelegate
//=================================================================
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isShow == YES) {
        FFDropDownMenuBasedModel *menuModel = self.menuModelsArray[indexPath.row];
        if (menuModel.menuBlock) {
            menuModel.menuBlock();
        }
        //关闭菜单
        [self dismissMenuWithAnimation:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.eachMenuItemHeight;
}


//=================================================================
//                         事件处理<action>
//=================================================================
#pragma mark - 事件处理<action>

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /** 点击view退出菜单 */
    if (self.isShow == YES) {
        [self dismissMenuWithAnimation:YES];
    }
}

/**
 *  关闭菜单
 *
 *  @param animation 是否需要动画效果
 *  如果是点击cell  执行block里面的代码就无需动画
 *  如果死点击view的其他区域，没有执行block代码，则需要一个动画效果
 */
- (void)dismissMenuWithAnimation:(BOOL)animation {
    if (self.isShow == NO) return;
    
    self.isShow = NO;
    
    //================================
    //          需要动画效果
    //================================
    if (animation == YES) {
        
        __weak typeof(self) weakSelf = self;
        
        //=============
        //淡入淡出动画效果
        //=============
        
        if (self.menuAnimateType == FFDropDownMenuViewAnimateType_FadeInFadeOut) {
            [UIView animateWithDuration:self.animateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
                weakSelf.tableView.alpha = 0;
                weakSelf.triangleView.alpha = 0;
                
                
            } completion:^(BOOL finished) {
                [weakSelf removeFromSuperview];
            }];
        }
        
        //============
        //   卷帘效果
        //============
        
        else if (self.menuAnimateType == FFDropDownMenuViewAnimateType_RollerShutter) {
            [UIView animateWithDuration:self.animateDuration animations:^{
                CGRect frame = weakSelf.menuContentView.bounds;
                frame.size.height = 0;
                weakSelf.tableView.frame = frame;
                weakSelf.backgroundColor = FFColor(0, 0, 0, weakSelf.bgColorbeginAlpha);
            } completion:^(BOOL finished) {
                [weakSelf removeFromSuperview];
            }];
            
        }
        
        
        //============
        // 从上往下落下
        //============
        
        else if (self.menuAnimateType == FFDropDownMenuViewAnimateType_FallFromTop) {
            
            
            [UIView animateWithDuration:self.animateDuration animations:^{
                CGRect tableViewLayerFrame = self.menuContentView.bounds;
                tableViewLayerFrame.origin.y = -tableViewLayerFrame.size.height;
                weakSelf.tableView.layer.frame = tableViewLayerFrame;
                weakSelf.backgroundColor = FFColor(0, 0, 0, weakSelf.bgColorbeginAlpha);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
        
        //=============
        //伸缩动画效果
        //=============
        else {
            //动画效果:在0.2秒内 大小缩小到 0.1倍 ，背景颜色由深变浅(其实颜色都是黑色，只是通过alpha来控制颜色的深浅)
            [UIView animateWithDuration:self.animateDuration animations:^{
                [weakSelf.tableView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
                weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:weakSelf.bgColorbeginAlpha];
                weakSelf.tableView.alpha = 0;
                weakSelf.triangleView.alpha = 0;
                
            } completion:^(BOOL finished) {
                //动画结束:将控制器的view从父控件中移除(父控件就是 KeyWindow)
                [weakSelf removeFromSuperview];
            }];
        }
        
        
    }
    
    //================================
    //          不需要动画效果
    //================================
    
    
    else {
        //=============
        //淡入淡出动画效果
        //=============
        
        if (self.menuAnimateType == FFDropDownMenuViewAnimateType_FadeInFadeOut) {
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
            [self removeFromSuperview];
        }
        
        //=============
        //   卷帘效果
        //=============
        
        else if (self.menuAnimateType == FFDropDownMenuViewAnimateType_RollerShutter) {
            [self removeFromSuperview];
        }

        
        //=============
        //  从上往下落下
        //=============
        
        else if (self.menuAnimateType == FFDropDownMenuViewAnimateType_FallFromTop) {
            CGRect tableViewLayerFrame = self.menuContentView.bounds;
            tableViewLayerFrame.origin.y = -tableViewLayerFrame.size.height;
            self.tableView.layer.frame = tableViewLayerFrame;
            [self removeFromSuperview];
        }
        
        //=============
        //  伸缩动画效果
        //=============
        else {
            [self.tableView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
            [self removeFromSuperview];
        }
        
    }
}


/** 显示菜单 */
- (void)showMenu {
    
    self.isShow = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    //将背景颜色设置浅的背景颜色
    self.backgroundColor = FFColor(0, 0, 0, self.bgColorbeginAlpha);
    __weak typeof(self) weakSelf = self;
    
    
    
    //=============
    //  淡入淡出效果
    //=============
    
    if (self.menuAnimateType == FFDropDownMenuViewAnimateType_FadeInFadeOut) {
        self.tableView.alpha = 0;
        self.triangleView.alpha = 0;
        
        [UIView animateWithDuration:self.animateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.backgroundColor = FFColor(0, 0, 0, self.bgColorEndAlpha);
            weakSelf.tableView.alpha = 1;
            weakSelf.triangleView.alpha = 1;
        } completion:nil];
    }
    
    //=============
    //   卷帘效果
    //=============
    
    else if (self.menuAnimateType == FFDropDownMenuViewAnimateType_RollerShutter) {
        self.backgroundColor = FFColor(0, 0, 0, self.bgColorbeginAlpha);
        CGRect frame = self.menuContentView.bounds;
        frame.size.height = 0;
        self.tableView.frame = frame;
        [UIView animateWithDuration:self.animateDuration animations:^{
            weakSelf.tableView.frame = weakSelf.menuContentView.bounds;
            weakSelf.backgroundColor = FFColor(0, 0, 0, weakSelf.bgColorEndAlpha);
        }];
    }
    
    //============
    //  上往下落下
    //============
    
    else if (self.menuAnimateType == FFDropDownMenuViewAnimateType_FallFromTop) {
        CGRect tableViewLayerFrame = self.menuContentView.bounds;
        tableViewLayerFrame.origin.y = -tableViewLayerFrame.size.height;
        self.tableView.layer.frame = tableViewLayerFrame;

        [UIView animateWithDuration:self.animateDuration animations:^{
            weakSelf.tableView.layer.frame = weakSelf.menuContentView.bounds;
            weakSelf.backgroundColor = FFColor(0, 0, 0, weakSelf.bgColorEndAlpha);
        } completion:nil];

    }
    
    
    
    //============
    //  伸缩效果
    //============
    
    else {
        self.tableView.alpha = 0;
        self.triangleView.alpha = 0;
        //先将menu的tableView缩小
        [self.tableView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
        //执行动画：背景颜色 由浅到深,menu的tableView由小到大，回复到正常大小
        [UIView animateWithDuration:self.animateDuration animations:^{
            weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorEndAlpha];
            [weakSelf.tableView.layer setValue:@(1) forKeyPath:@"transform.scale"];
            weakSelf.tableView.alpha = 1;
            weakSelf.triangleView.alpha = 1;
        }];
    }
}


//=================================================================
//                   所有属性的set方法<set method>
//=================================================================
#pragma mark - 所有属性的set方法<set method>

- (void)setMenuModelsArray:(NSArray *)menuModelsArray {//1
    _menuModelsArray = menuModelsArray;
}

- (void)setCellClassName:(NSString *)cellClassName {//2
    _cellClassName = cellClassName;
}

- (void)setMenuWidth:(CGFloat)menuWidth {//3
    if (menuWidth != FFDefaultFloat) {
        _menuWidth = menuWidth;
    }
}

- (void)setMenuCornerRadius:(CGFloat)menuCornerRadius {//4
    if (menuCornerRadius != FFDefaultFloat) {
        _menuCornerRadius = menuCornerRadius;
    }
}

- (void)setEachMenuItemHeight:(CGFloat)eachMenuItemHeight {//5
    if (eachMenuItemHeight != FFDefaultFloat) {
        _eachMenuItemHeight = eachMenuItemHeight;
    }
}

- (void)setMenuRightMargin:(CGFloat)menuRightMargin {//6
    if (menuRightMargin != FFDefaultFloat) {
        _menuRightMargin = menuRightMargin;
    }
}

- (void)setMenuItemBackgroundColor:(UIColor *)menuItemBackgroundColor { //7
    _menuItemBackgroundColor = menuItemBackgroundColor;
    
}

- (void)setTriangleColor:(UIColor *)triangleColor {//8
    _triangleColor = triangleColor;
}

- (void)setTriangleY:(CGFloat)triangleY {//9
    if (triangleY != FFDefaultFloat) {
        _triangleY = triangleY;
        self.realTriangleY = _triangleY;
    }
}

- (void)setTriangleRightMargin:(CGFloat)triangleRightMargin {//10
    if (triangleRightMargin != FFDefaultFloat) {
        _triangleRightMargin = triangleRightMargin;
    }
}

- (void)setTriangleSize:(CGSize)triangleSize {//11
    _triangleSize = triangleSize;
}

- (void)setBgColorbeginAlpha:(CGFloat)bgColorbeginAlpha {//12
    if (bgColorbeginAlpha != FFDefaultFloat) {
        _bgColorbeginAlpha = bgColorbeginAlpha;
    }
}

- (void)setBgColorEndAlpha:(CGFloat)bgColorEndAlpha {//13
    if (bgColorEndAlpha != FFDefaultFloat) {
        _bgColorEndAlpha = bgColorEndAlpha;
    }
}

- (void)setAnimateDuration:(CGFloat)animateDuration {//14
    if (animateDuration != FFDefaultFloat) {
        _animateDuration = animateDuration;
    }
}

- (void)setMenuAnimateType:(FFDropDownMenuViewAnimateType)menuAnimateType { //15
    _menuAnimateType = menuAnimateType;
}


@end

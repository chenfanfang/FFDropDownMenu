//
//  FFDropDownMenuVC.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuView.h"

//cell
#import "FFDropDownMenuCell.h" //下拉菜单cell
//view
#import "FFDropDownMenuTriangleView.h" //下拉菜单的三角形




@interface FFDropDownMenuView ()<UITableViewDataSource, UITableViewDelegate>

/** 下拉菜单的模型数组 */
@property (nonatomic, strong) NSArray<FFDropDownMenuModel *> *menuModelsArray;

/**tableView*/
@property (nonatomic, weak)  UITableView *tableView;

/** 三角形 */
@property (nonatomic, strong) FFDropDownMenuTriangleView *triangleView;

/** 菜单条的宽度 */
@property (nonatomic, assign) CGFloat menuWidth;

/** 每个菜单选项的高度 */
@property (nonatomic, assign) CGFloat eatchMenuItemHeight;

/**整体菜单条距离屏幕右边的间距*/
@property (nonatomic, assign) CGFloat menuRightMargin;

/** 三角形距离屏幕右边的间距 */
@property (nonatomic, assign) CGFloat triangleRightMargin;

/** 三角形的size */
@property (nonatomic, assign) CGSize triangleSize;

/**完全显示的frame*/
@property (nonatomic, assign) CGRect endFrame;

/** 背景颜色开始时的透明度(还没展示menu的透明度) */
@property (nonatomic, assign) CGFloat bgColorbeginAlpha;

/** 背景颜色结束的的透明度(menu完全展示的透明度) */
@property (nonatomic, assign) CGFloat bgColorEndAlpha;

/** 动画效果时间 */
@property (nonatomic, assign) CGFloat animateDuration;

/** 视图是否在显示*/
@property (nonatomic, assign) BOOL isShow;

@end

@implementation FFDropDownMenuView


+ (instancetype)ff_DropDownMenuWithMenuModelsArray:(NSArray<FFDropDownMenuModel *> *)menuModelsArray menuWidth:(CGFloat)menuWidth eatchItemHeight:(CGFloat)eatchItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin triangleSize:(CGSize)triangleSize bgColorBeginAlpha:(CGFloat)bgColorBeginAlpha bgColorEndAlpha:(CGFloat)bgColorEndAlpha animateDuration:(CGFloat)animateDuration {
    
    FFDropDownMenuView *menuView = [FFDropDownMenuView new];
    //属性的赋值
    menuView.menuModelsArray = menuModelsArray;
    menuView.menuWidth = menuWidth;
    menuView.eatchMenuItemHeight = eatchItemHeight;
    menuView.menuRightMargin = menuRightMargin;
    menuView.triangleRightMargin = triangleRightMargin;
    menuView.triangleSize = triangleSize;
    menuView.bgColorbeginAlpha = bgColorBeginAlpha;
    menuView.bgColorEndAlpha = bgColorEndAlpha;
    menuView.animateDuration = animateDuration;
    //初始化
    [menuView setup];
    
    return menuView;
}



/***********************************懒加载***********************************/
#pragma mark - 懒加载
static NSString *const FFDropDownMenuCellID = @"FFDropDownMenuCell";

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.clipsToBounds = YES;
        tableView.layer.cornerRadius = 5;
        //锚点设置成右上角，进行frame的设置需要注意
        tableView.layer.anchorPoint = CGPointMake(1, 0);
        //注册
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FFDropDownMenuCell class]) bundle:nil] forCellReuseIdentifier:FFDropDownMenuCellID];
        
        [self addSubview:tableView];
        _tableView = tableView;
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



/***********************************初始化***********************************/
#pragma mark - 初始化

- (void)setup {
    
    //设置view的圆角、frame
    self.frame = [UIScreen mainScreen].bounds;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
    
    //设置三角形的frame (我定义了多个变量并且都有注释，方便大家的理解)
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width; //屏幕宽度
    CGFloat statusBarH = 20; //状态栏高度
    CGFloat navBarHeight = 44; //导航栏高度
    self.triangleView.frame = CGRectMake(screenWidth - self.triangleRightMargin - self.triangleSize.width, navBarHeight + statusBarH, self.triangleSize.width, self.triangleSize.height);
    
    
    self.endFrame = CGRectMake(screenWidth - self.menuWidth - self.menuRightMargin, CGRectGetMaxY(self.triangleView.frame), self.menuWidth, self.eatchMenuItemHeight * self.menuModelsArray.count);
}


/***********************************UITableViewDataSource***********************************/
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuModelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFDropDownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:FFDropDownMenuCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FFDropDownMenuModel *menuModel = self.menuModelsArray[indexPath.row];
    cell.menuModel = menuModel;
    return cell;
}

/***********************************UITableViewDelegate***********************************/
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isShow == YES) {
        FFDropDownMenuModel *menuModel = self.menuModelsArray[indexPath.row];
        if (menuModel.menuBlock) {
            menuModel.menuBlock();
        }
        //关闭菜单
        [self dismissMenuWithAnimation:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.eatchMenuItemHeight;
}

/***********************************事件处理***********************************/
#pragma mark - 事件处理

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
    self.isShow = NO;
    
    if (animation == YES) {
        //动画效果:在0.2秒内 大小缩小到 0.1倍 ，背景颜色由深变浅(其实颜色都是黑色，只是通过alpha来控制颜色的深浅)
        [UIView animateWithDuration:self.animateDuration animations:^{
            [self.tableView.layer setValue:@(0.3) forKeyPath:@"transform.scale"];
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
            
        } completion:^(BOOL finished) {
            //动画结束:将控制器的view从父控件中移除(父控件就是 KeyWindow)
            [self removeFromSuperview];
        }];
    }
    
    else {
        [self.tableView.layer setValue:@(0.3) forKeyPath:@"transform.scale"];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
        [self removeFromSuperview];
    }
    
    
}

/** 显示菜单 */
- (void)showMenu {
    self.isShow = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.tableView.frame = self.endFrame;
    
    //先将menu的tableView缩小
    [self.tableView.layer setValue:@(0.3) forKeyPath:@"transform.scale"];
    //将背景颜色设置浅的背景颜色
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
    
    //执行动画：背景颜色 由浅到深,menu的tableView由小到大，回复到正常大小
    [UIView animateWithDuration:self.animateDuration animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorEndAlpha];
        [self.tableView.layer setValue:@(1) forKeyPath:@"transform.scale"];
    }];
    
}



@end

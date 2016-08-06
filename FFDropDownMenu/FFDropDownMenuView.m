//
//  FFDropDownMenuVC.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuView.h"

//cell
#import "FFDropDownMenuBasedCell.h" //下拉菜单基类cell

//view
#import "FFDropDownMenuTriangleView.h" //下拉菜单的三角形

//model
#import "FFDropDownMenuBasedModel.h"




@interface FFDropDownMenuView ()<UITableViewDataSource, UITableViewDelegate>

/**tableView*/
@property (nonatomic, weak)  UITableView *tableView;

/** 三角形 */
@property (nonatomic, strong) FFDropDownMenuTriangleView *triangleView;

/** 真实的三角形的Y(这个属性是用于状态栏的改变) */
@property (nonatomic, assign) CGFloat realTriangleY;

/** 视图是否在显示*/
@property (nonatomic, assign) BOOL isShow;

/** cell是否是正确格式的cell */
@property (nonatomic, assign) BOOL isCellCorrect;

@end

@implementation FFDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //默认属性的赋值
        self.cellClassName = @"FFDropDownMenuCell";
        self.menuWidth = 150;
        self.menuCornerRadius = 5;
        self.eachMenuItemHeight = 40;
        self.menuRightMargin = 10;
        self.triangleColor = [UIColor whiteColor];
        self.triangleY = 64;
        self.realTriangleY = self.triangleY;
        self.triangleRightMargin = 20;
        self.triangleSize = CGSizeMake(20, 10);
        self.bgColorbeginAlpha = 0.02;
        self.bgColorEndAlpha = 0.2;
        self.animateDuration = 0.2;
        self.menuScaleType = FFDropDownMenuViewScaleType_TopRight;
        
        self.isCellCorrect = NO;
        self.isShow = NO;
        
        //监听状态栏高度改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarHeightChanged:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)statusBarHeightChanged:(NSNotification *)note {
    
    CGRect statusBarFrame = [note.userInfo[UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    CGFloat statusBarHeight = statusBarFrame.size.height;
    if (statusBarHeight == 20) {
        self.realTriangleY = self.triangleY;
        
    } else {
        self.realTriangleY = self.triangleY + 20;
    }
    
    [self setup];
}

+ (instancetype)ff_DefaultStyleDropDownMenuWithMenuModelsArray:(NSArray<FFDropDownMenuModel *> *)menuModelsArray menuWidth:(CGFloat)menuWidth eachItemHeight:(CGFloat)eachItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin {
    
    FFDropDownMenuView *menuView = [FFDropDownMenuView new];
    
    menuView.menuModelsArray = menuModelsArray;
    menuView.menuWidth = menuWidth == FFDefaultFloat ? menuView.menuWidth : menuWidth;
    menuView.eachMenuItemHeight = eachItemHeight == FFDefaultFloat ? menuView.eachMenuItemHeight : eachItemHeight;
    menuView.menuRightMargin = menuRightMargin == FFDefaultFloat ? menuView.menuRightMargin : menuRightMargin;
    menuView.triangleRightMargin = triangleRightMargin == FFDefaultFloat ? menuView.triangleRightMargin : triangleRightMargin;
    
    [menuView setup];
    return menuView;
}


+ (instancetype)ff_DropDownMenuWithMenuModelsArray:(NSArray *)menuModelsArray cellClassName:(NSString *)cellClassName menuWidth:(CGFloat)menuWidth menuCornerRadius:(CGFloat)menuCornerRadius eachItemHeight:(CGFloat)eachItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleColor:(UIColor *)triangleColor triangleY:(CGFloat)triangleY triangleRightMargin:(CGFloat)triangleRightMargin triangleSize:(CGSize)triangleSize bgColorBeginAlpha:(CGFloat)bgColorBeginAlpha bgColorEndAlpha:(CGFloat)bgColorEndAlpha animateDuration:(CGFloat)animateDuration menuScaleType:(FFDropDownMenuViewScaleType)menuScaleType {
    
    FFDropDownMenuView *menuView = [FFDropDownMenuView new];
    //属性的赋值
    menuView.menuModelsArray = menuModelsArray;
    menuView.cellClassName = cellClassName;
    menuView.menuWidth = menuWidth == FFDefaultFloat ? menuView.menuWidth : menuWidth;
    menuView.menuCornerRadius = menuCornerRadius == FFDefaultFloat ? menuView.menuCornerRadius : menuCornerRadius;
    menuView.eachMenuItemHeight = eachItemHeight == FFDefaultFloat ? menuView.eachMenuItemHeight : eachItemHeight;
    menuView.menuRightMargin = menuRightMargin == FFDefaultFloat ? menuView.menuRightMargin : menuRightMargin;
    menuView.triangleColor = triangleColor;
    menuView.triangleY = triangleY == FFDefaultFloat ? menuView.triangleY : triangleY;
    menuView.realTriangleY = menuView.triangleY;
    menuView.triangleRightMargin = triangleRightMargin == FFDefaultFloat ? menuView.triangleRightMargin : triangleRightMargin;
    menuView.triangleSize = triangleSize;
    menuView.bgColorbeginAlpha = bgColorBeginAlpha == FFDefaultFloat ? menuView.bgColorbeginAlpha : bgColorBeginAlpha;
    menuView.bgColorEndAlpha = bgColorEndAlpha == FFDefaultFloat ? menuView.bgColorEndAlpha : bgColorEndAlpha;
    menuView.animateDuration = animateDuration == FFDefaultFloat ? menuView.animateDuration : animateDuration;
    menuView.menuScaleType = menuScaleType;
    
    //初始化
    [menuView setup];
    
    return menuView;
}



/***********************************懒加载***********************************/
#pragma mark - 懒加载

static NSString *const CellID = @"CellID";

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        [self addSubview:tableView];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.clipsToBounds = YES;
        tableView.layer.cornerRadius = self.menuCornerRadius;
        //锚点设置成右上角，进行frame的设置需要注意
        switch (self.menuScaleType) {
            case FFDropDownMenuViewScaleType_TopRight: //右上角
                tableView.layer.anchorPoint = CGPointMake(1, 0);
                break;
            case FFDropDownMenuViewScaleType_TopLeft: //左上角
                tableView.layer.anchorPoint = CGPointMake(0, 0);
                break;
            case FFDropDownMenuViewScaleType_Middle: //中间
                break;
                
            default:
                break;
        }
        
        
        //注册cell
        if ([self.cellClassName hasSuffix:@".xib"]) { //xib名称
            NSString *className = [self.cellClassName componentsSeparatedByString:@".xib"].firstObject;
            if (!NSClassFromString(className)) {
                NSLog(@"%@这个类不存在,请查看项目中是否有该类",className);
                return _tableView;
            }
            
            if (![NSClassFromString(className) isSubclassOfClass:[FFDropDownMenuBasedCell class]]) {
                NSLog(@"%@这个类不是FFDropDownMenuBasedCell的子类,请继承这个类",className);
                return _tableView;
            }
            
            UINib *cellNib = [UINib nibWithNibName:className bundle:nil];
            [tableView registerNib:cellNib forCellReuseIdentifier:CellID];
            
        } else { //cell类名
            if (!NSClassFromString(self.cellClassName)) {
                NSLog(@"%@这个类不存在,请查看项目中是否有该类",self.cellClassName);
                return _tableView;
            }
            
            if (![NSClassFromString(self.cellClassName) isSubclassOfClass:[FFDropDownMenuBasedCell class]]) {
                NSLog(@"%@这个类不是FFDropDownMenuBasedCell的子类,请继承这个类",self.cellClassName);
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



/***********************************初始化***********************************/
#pragma mark - 初始化

- (void)setup {
    [_tableView removeFromSuperview];
    _tableView = nil;
    
    //设置view的圆角、frame
    self.frame = [UIScreen mainScreen].bounds;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorEndAlpha];
    
    //设置三角形的frame
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width; //屏幕宽度
    self.triangleView.frame = CGRectMake(screenWidth - self.triangleRightMargin - self.triangleSize.width, self.realTriangleY, self.triangleSize.width, self.triangleSize.height);
    self.triangleView.triangleColor = self.triangleColor;
    
    self.tableView.frame = CGRectMake(screenWidth - self.menuWidth - self.menuRightMargin, CGRectGetMaxY(self.triangleView.frame), self.menuWidth, self.eachMenuItemHeight * self.menuModelsArray.count);
    
}


/***********************************UITableViewDataSource***********************************/
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FFDropDownMenuBasedModel *menuModel = self.menuModelsArray[indexPath.row];
    cell.menuModel = menuModel;
    return cell;
}

/***********************************UITableViewDelegate***********************************/
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
        
        __weak typeof(self) weakSelf = self;
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
    
    else {
        [self.tableView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
        [self removeFromSuperview];
    }
}


/** 显示菜单 */
- (void)showMenu {
    self.isShow = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    //先将menu的tableView缩小
    [self.tableView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
    //将背景颜色设置浅的背景颜色
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
    
    self.tableView.alpha = 0;
    self.triangleView.alpha = 0;
    
    __weak typeof(self) weakSelf = self;
    //执行动画：背景颜色 由浅到深,menu的tableView由小到大，回复到正常大小
    [UIView animateWithDuration:self.animateDuration animations:^{
        weakSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorEndAlpha];
        [weakSelf.tableView.layer setValue:@(1) forKeyPath:@"transform.scale"];
        weakSelf.tableView.alpha = 1;
        weakSelf.triangleView.alpha = 1;
    }];
}



@end

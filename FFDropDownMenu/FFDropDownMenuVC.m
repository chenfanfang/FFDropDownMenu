//
//  FFDropDownMenuVC.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDropDownMenuVC.h"

//model
#import "FFDropDownMenuModel.h"//下拉菜单模型
//cell
#import "FFDropDownMenuCell.h" //下拉菜单cell
//view
#import "FFDropDownMenuTriangleView.h" //下拉菜单的三角形




@interface FFDropDownMenuVC ()<UITableViewDataSource, UITableViewDelegate>

/** 下拉菜单的模型 */
@property (nonatomic, strong) FFDropDownMenuModel *dropDownMenuModel;

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

/**完全显示的frame*/
@property (nonatomic, assign) CGRect endFrame;

/** 背景颜色开始时的透明度(还没展示menu的透明度) */
@property (nonatomic, assign) CGFloat bgColorbeginAlpha;

/** 背景颜色结束的的透明度(menu完全展示的透明度) */
@property (nonatomic, assign) CGFloat bgColorEndAlpha;


//-------
//-------
//-------

/** 视图是否在显示*/
@property (nonatomic, assign) BOOL isShow;

@end

@implementation FFDropDownMenuVC


+ (instancetype)dropDownMenuWithDropDownMenuModel:(FFDropDownMenuModel *)model menuWidth:(CGFloat)menuWidth eatchItemHeight:(CGFloat)eatchItemHeight menuRightMargin:(CGFloat)menuRightMargin triangleRightMargin:(CGFloat)triangleRightMargin bgColorBeginAlpha:(CGFloat)bgColorBeginAlpha bgColorEndAlpha:(CGFloat)bgColorEndAlpha {
    
    FFDropDownMenuVC *menuVC = [FFDropDownMenuVC new];
    //属性的赋值
    menuVC.dropDownMenuModel = model;
    menuVC.menuWidth = menuWidth;
    menuVC.eatchMenuItemHeight = eatchItemHeight;
    menuVC.menuRightMargin = menuRightMargin;
    menuVC.triangleRightMargin = triangleRightMargin;
    menuVC.bgColorbeginAlpha = bgColorBeginAlpha;
    menuVC.bgColorEndAlpha = bgColorEndAlpha;
    
    //初始化
    [menuVC setup];
    
    return menuVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
//        tableView.backgroundColor = DDGray_ShallowColor;
        tableView.clipsToBounds = YES;
        tableView.layer.cornerRadius = 5;
        //锚点设置成右上角，进行frame的设置需要注意
        tableView.layer.anchorPoint = CGPointMake(1, 0);
        //注册
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FFDropDownMenuCell class]) bundle:nil] forCellReuseIdentifier:FFDropDownMenuCellID];
        
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (FFDropDownMenuTriangleView *)triangleView {
    if (_triangleView == nil) {
        FFDropDownMenuTriangleView *triangleView = [[FFDropDownMenuTriangleView alloc] init];
        [self.view addSubview:triangleView];
        triangleView.backgroundColor = [UIColor clearColor];
        _triangleView = triangleView;
    }
    return _triangleView;
}



/***********************************初始化***********************************/
#pragma mark - 初始化

- (void)setup {
    
    //设置view的圆角、frame
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.layer.cornerRadius = 5;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
    
    //设置三角形的frame (我定义了多个变量并且都有注释，方便大家的理解)
    CGFloat triWidth = 15; //三角形的宽度
    CGFloat triHeight = 10; //三角形的高度
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width; //屏幕宽度
    CGFloat statusBarH = 20; //状态栏高度
    CGFloat navBarHeight = 44; //导航栏高度
    self.triangleView.frame = CGRectMake(screenWidth - self.triangleRightMargin - triWidth, navBarHeight + statusBarH, triWidth, triHeight);
    
    
    self.endFrame = CGRectMake(screenWidth - self.menuWidth - self.menuRightMargin, CGRectGetMaxY(self.triangleView.frame), self.menuWidth, self.eatchMenuItemHeight * self.dropDownMenuModel.titlesArray.count);
}


/***********************************UITableViewDataSource***********************************/
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dropDownMenuModel.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFDropDownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:FFDropDownMenuCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //给label赋值
    cell.customTitleLabel.text = self.dropDownMenuModel.titlesArray[indexPath.row];
    //给imageView赋值
    cell.customImageView.image = [UIImage imageNamed:self.dropDownMenuModel.imagesArray[indexPath.row]];
    return cell;
}

/***********************************UITableViewDelegate***********************************/
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    void (^callBackBlock)() = self.dropDownMenuModel.callBackBlocksArray[indexPath.row];
    if (self.isShow == YES) {
        if (callBackBlock) { //执行回调block
            callBackBlock();
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
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
            self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
            
        } completion:^(BOOL finished) {
            //动画结束:将控制器的view从父控件中移除(父控件就是 KeyWindow)
            [self.view removeFromSuperview];
        }];
    }
    
    else {
        [self.tableView.layer setValue:@(0.1) forKeyPath:@"transform.scale"];
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
        [self.view removeFromSuperview];
    }
    
    
}

/** 显示菜单 */
- (void)showMenu {
    self.isShow = YES;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self.view];
    self.tableView.frame = self.endFrame;
    
    //先将menu的tableView缩小
    [self.tableView.layer setValue:@(0) forKeyPath:@"transform.scale"];
    //将背景颜色设置浅的背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorbeginAlpha];
    
    //执行动画：背景颜色 由浅到深,menu的tableView由小到大，回复到正常大小
    [UIView animateWithDuration:0.2 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:self.bgColorEndAlpha];
        [self.tableView.layer setValue:@(1) forKeyPath:@"transform.scale"];
    }];
    
}



@end

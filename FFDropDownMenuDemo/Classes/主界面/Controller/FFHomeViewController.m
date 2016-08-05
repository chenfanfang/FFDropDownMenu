//
//  ViewController.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/8/5.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFHomeViewController.h"

#import "FFDropDownMenuView.h"



@interface FFHomeViewController ()

/** 下拉菜单 */
@property (nonatomic, strong) FFDropDownMenuView *dropdownMenu;

@end

@implementation FFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 初始化下拉菜单 */
    [self setupDropDownMenu];
    
    /** 进行基本的设置、搭建出手机QQ首页效果、读者可忽略setupBasedView 中的代码 */
    [self setupBasedView];
}


/** 进行基本的设置、搭建出手机QQ首页效果、读者可忽略setupBasedView 中的代码 */
- (void)setupBasedView {
    //导航栏的设置
    
    //导航栏背景图
    UIImage *backgroundImage = [self imageWithColor:[UIColor colorWithRed:67/255.0 green:135/255.0 blue:229/255.0 alpha:1] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)];
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //titleView
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"消息", @"电话"]];
    segmentedControl.frame = CGRectMake(0, 0, 130, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor whiteColor]; //设置选中状态的背景颜色
    self.navigationItem.titleView = segmentedControl;
    
    //左侧的头像
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    headerImageView.image = [UIImage imageNamed:@"QQIcon"];
    headerImageView.layer.cornerRadius = headerImageView.frame.size.height * 0.5;//设置圆角--》圆形头像
    headerImageView.clipsToBounds = YES;//超出控件外的部分进行裁剪
    UIBarButtonItem *headerIconItem = [[UIBarButtonItem alloc] initWithCustomView:headerImageView];
    self.navigationItem.leftBarButtonItem = headerIconItem;
    
    //手机QQ首页的图片
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat marign = 5;
    UIImageView *homeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marign, 15, size.width - 2 * marign, size.height)];
    homeImageView.image = [UIImage imageNamed:@"QQHomeBg"];
    [self.view addSubview:homeImageView];
    
}

/** 初始化下拉菜单 */
- (void)setupDropDownMenu {
    //右侧的菜单按钮
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [menuBtn addTarget:self action:@selector(showDropDownMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn setImage:[UIImage imageNamed:@"nemuItem"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}

/** 显示下拉菜单 */
- (void)showDropDownMenu {
    [self.dropdownMenu showMenu];
}

/***********************************懒加载***********************************/
#pragma mark - 懒加载
- (FFDropDownMenuView *)dropdownMenu {
    if (_dropdownMenu == nil) {
        __weak typeof(self) weakSelf = self;
        
        //菜单模型0
        FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"多人聊天" menuItemIconName:@"menu0" extra:nil menuBlock:^{
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor yellowColor];
            vc.navigationItem.title = @"多人聊天";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        //菜单模型1
        FFDropDownMenuModel *menuModel1 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"加好友" menuItemIconName:@"menu1" extra:nil menuBlock:^{
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor orangeColor];
            vc.navigationItem.title = @"加好友";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        //菜单模型2
        FFDropDownMenuModel *menuModel2 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"扫一扫" menuItemIconName:@"menu2" extra:nil menuBlock:^{
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor blueColor];
            vc.navigationItem.title = @"扫一扫";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        //菜单模型3
        FFDropDownMenuModel *menuModel3 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"发送到电脑" menuItemIconName:@"menu3" extra:nil menuBlock:^{
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor greenColor];
            vc.navigationItem.title = @"发送到电脑";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        //菜单模型4
        FFDropDownMenuModel *menuModel4 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"面对面快传" menuItemIconName:@"menu4" extra:nil menuBlock:^{
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor purpleColor];
            vc.navigationItem.title = @"面对面快传";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        //菜单模型5
        FFDropDownMenuModel *menuModel5 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"付款" menuItemIconName:@"menu5" extra:nil menuBlock:^{
            UIViewController *vc = [UIViewController new];
            vc.view.backgroundColor = [UIColor yellowColor];
            vc.navigationItem.title = @"付款";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    
        NSArray *menuModelArr = @[menuModel0, menuModel1, menuModel2, menuModel3, menuModel4, menuModel5];
        
        _dropdownMenu = [FFDropDownMenuView ff_DropDownMenuWithMenuModelsArray:menuModelArr menuWidth:145 eatchItemHeight:40 menuRightMargin:10 triangleRightMargin:20 triangleSize:CGSizeMake(15, 10) bgColorBeginAlpha:0.02 bgColorEndAlpha:0.2 animateDuration:0.2];
    }
    return _dropdownMenu;
}



/**根据颜色返回一张纯色的图片*/
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end

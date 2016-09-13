//
//  ViewController.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/8/5.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFHomeViewController.h"

//controller
#import "FFMenuViewController.h"


//view
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
    
    /** 进行基本的设置、读者可忽略setupBasedView 中的代码 */
    [self setupBasedView];
}



/** 初始化下拉菜单 */
- (void)setupDropDownMenu {
    NSArray *modelsArray = [self getMenuModelsArray];
    
    self.dropdownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:modelsArray menuWidth:FFDefaultFloat eachItemHeight:FFDefaultFloat menuRightMargin:FFDefaultFloat triangleRightMargin:FFDefaultFloat];
}



/** 获取菜单模型数组 */
- (NSArray *)getMenuModelsArray {
    __weak typeof(self) weakSelf = self;
    
    //菜单模型0
    FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"QQ" menuItemIconName:@"menu2"  menuBlock:^{
        FFMenuViewController *vc = [FFMenuViewController new];
        vc.backgroundImageName = @"menuBackground";
        vc.navigationItem.title = @"QQ";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    //菜单模型1
    FFDropDownMenuModel *menuModel1 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Line" menuItemIconName:@"menu1" menuBlock:^{
        FFMenuViewController *vc = [FFMenuViewController new];
        vc.backgroundImageName = @"menuBackground";
        vc.navigationItem.title = @"Line";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    //菜单模型2
    FFDropDownMenuModel *menuModel2 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Twitter" menuItemIconName:@"menu0" menuBlock:^{
        FFMenuViewController *vc = [FFMenuViewController new];
        vc.backgroundImageName = @"menuBackground";
        vc.navigationItem.title = @"Twitter";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    //菜单模型3
    FFDropDownMenuModel *menuModel3 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"QZone" menuItemIconName:@"menu3"  menuBlock:^{
        FFMenuViewController *vc = [FFMenuViewController new];
        vc.backgroundImageName = @"menuBackground";
        vc.navigationItem.title = @"QZone";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型4
    FFDropDownMenuModel *menuModel4 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"WeChat" menuItemIconName:@"menu4"  menuBlock:^{
        FFMenuViewController *vc = [FFMenuViewController new];
        vc.backgroundImageName = @"menuBackground";
        vc.navigationItem.title = @"WeChat";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型5
    FFDropDownMenuModel *menuModel5 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Facebook" menuItemIconName:@"menu5"  menuBlock:^{
        FFMenuViewController *vc = [FFMenuViewController new];
        vc.backgroundImageName = @"menuBackground";
        vc.navigationItem.title = @"Facebook";
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    NSArray *menuModelArr = @[menuModel0, menuModel1, menuModel2, menuModel3, menuModel4, menuModel5];
    return menuModelArr;
}

/** 显示下拉菜单 */
- (void)showDropDownMenu {
    [self.dropdownMenu showMenu];
}


/** 进行基本的设置、搭建出手机QQ首页效果、读者可忽略setupBasedView 中的代码 */
- (void)setupBasedView {
    //右侧的菜单按钮
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [menuBtn addTarget:self action:@selector(showDropDownMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn setImage:[UIImage imageNamed:@"nemuItem"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
    //导航栏的设置
    
    //导航栏背景图
    UIImage *bgImage = [self imageWithColor:[UIColor colorWithRed:25 / 255.0 green:168 / 255.0 blue:243 / 255.0 alpha:1] size:CGSizeMake(1000, 100)];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //titleView
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"消息", @"电话"]];
    segmentedControl.frame = CGRectMake(0, 0, 130, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = [UIColor whiteColor]; //设置选中状态的背景颜色
    self.navigationItem.titleView = segmentedControl;
    
    //左侧的头像
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    headerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderIcon)];
    [headerImageView addGestureRecognizer:tapGes];
    headerImageView.image = [UIImage imageNamed:@"QQIcon"];
    headerImageView.layer.cornerRadius = headerImageView.frame.size.height * 0.5;//设置圆角--》圆形头像
    headerImageView.clipsToBounds = YES;//超出控件外的部分进行裁剪
    UIBarButtonItem *headerIconItem = [[UIBarButtonItem alloc] initWithCustomView:headerImageView];
    self.navigationItem.leftBarButtonItem = headerIconItem;
    
    
}

/** 点击导航栏左边的头像*/
- (void)clickHeaderIcon {
    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com/users/80fadb71940d/latest_articles"];
    [[UIApplication sharedApplication] openURL:url];
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

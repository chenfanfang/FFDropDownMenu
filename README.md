FFDropDownMenu
===
- 下拉菜单框架 (drop-down menu framework)
- 自由度高，可以自定义菜单的样式 (High degree of freedom, you can custom the menu style that you want）

---
---

####默认样式 (Default menu style)
![default menu style](https://raw.githubusercontent.com/chenfanfang/FFDropDownMenu/a5cc6c53c7cddeaaad92cff1528708646c797a91/FFDropDownMenuDemo/Resources/%E4%B8%8B%E6%8B%89%E8%8F%9C%E5%8D%95%E5%9F%BA%E6%9C%AC%E4%BD%BF%E7%94%A8%E7%9A%84%E6%95%88%E6%9E%9C%E5%9B%BE/basicUsage2.gif)

####自定义菜单样式 (Custom menu style)

![custom  menu style](https://raw.githubusercontent.com/chenfanfang/FFDropDownMenu/d94a201d7125d757a5c058855fc5d1521d6528a3/FFDropDownMenuDemo/Resources/%E5%AE%9E%E6%88%98_%E8%87%AA%E5%AE%9A%E4%B9%89%E8%8F%9C%E5%8D%95%E6%A0%B7%E5%BC%8F/customMenuStyle.gif)


###你可以自定义你想要的菜单样式 (you can suctom the menu style that you want)


- [更多的使用方法demo  (more usage demo address)](https://github.com/chenfanfang/CollectionsOfExample)

- [更多的使用方法的博客地址 (more usage blog address)](http://www.jianshu.com/notebooks/5552428/latest)


---
---



FFDropDownMenu的基本使用(based usage)
---


####先浏览下效果图(Browsing the effect picture first)


![仿手机QQ下拉菜单.gif](https://raw.githubusercontent.com/chenfanfang/FFDropDownMenu/a5cc6c53c7cddeaaad92cff1528708646c797a91/FFDropDownMenuDemo/Resources/%E4%B8%8B%E6%8B%89%E8%8F%9C%E5%8D%95%E5%9F%BA%E6%9C%AC%E4%BD%BF%E7%94%A8%E7%9A%84%E6%95%88%E6%9E%9C%E5%9B%BE/basicUsage2.gif)


![仿手机QQ下拉菜单.png](https://raw.githubusercontent.com/chenfanfang/FFDropDownMenu/d0c70565712fe4d5b28842517ef55fcc9a50a140/FFDropDownMenuDemo/Resources/%E4%B8%8B%E6%8B%89%E8%8F%9C%E5%8D%95%E5%9F%BA%E6%9C%AC%E4%BD%BF%E7%94%A8%E7%9A%84%E6%95%88%E6%9E%9C%E5%9B%BE/basicUsage1.png)



## Installation【安装】

### From CocoaPods【使用CocoaPods】

```ruby
pod  FFDropDownMenu
```

### Manually【手动导入】
- Drag all source files under floder `FFDropDownMenu` to your project.【将`FFDropDownMenu`文件夹中的所有源代码拽入项目中】

- FFDropDownMenu文件夹里面的文件有

```objc
FFDropDownMenu.h
FFDropDownMenuBasedCell.h        FFDropDownMenuBasedCell.m
FFDropDownMenuBasedModel.h       FFDropDownMenuBasedModel.m
FFDropDownMenuCell.h             FFDropDownMenuCell.m
FFDropDownMenuModel.h            FFDropDownMenuModel.m
FFDropDownMenuTriangleView.h     FFDropDownMenuTriangleView.m
FFDropDownMenuView.h             FFDropDownMenuView.m


```

##【基本的使用】

先导入头文件
```objc
//若使用CocoaPods
#import <FFDropDownMenuView.h>

//若使用手动导入
#import "FFDropDownMenuView.h"

```

创建一个strong的下拉菜单属性
```
/** 下拉菜单 */
@property (nonatomic, strong) FFDropDownMenuView *dropDownMenu;
```

创建菜单模型数组
```objc
//FFDropDownMenuModel.h


/**
 *  快速实例化一个下拉菜单模型
 *
 *  @param menuItemTitle    菜单选项的标题
 *  @param menuItemIconName 菜单选项的图标名称
 *  @param menuBlock        点击的回调block
 *
 *  @return 实例化的菜单模型
 */
+ (instancetype)ff_DropDownMenuModelWithMenuItemTitle:(NSString *)menuItemTitle menuItemIconName:(NSString *)menuItemIconName menuBlock:(FFMenuBlock)menuBlock;
```

```objc

/** 获取下拉菜单模型数组 */
- (NSArray *)getDropDownMenuModelsArray {
    __weak typeof(self)weakSelf = self;
    //菜单模型0
    FFDropDownMenuModel *menuModel0 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Twitter" menuItemIconName:@"menu0" menuBlock:^{

        UIViewController *vc = [UIViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    //菜单模型1
    FFDropDownMenuModel *menuModel1 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"Line" menuItemIconName:@"menu1" menuBlock:^{
        //Do Something
    }];
    //菜单模型2
    FFDropDownMenuModel *menuModel2 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"QQ" menuItemIconName:@"menu2"  menuBlock:^{
       //Do Something
    }];
    //菜单模型3
    FFDropDownMenuModel *menuModel3 = [FFDropDownMenuModel ff_DropDownMenuModelWithMenuItemTitle:@"QZone" menuItemIconName:@"menu3"  menuBlock:^{
        //Do Something
    }];
    //菜单模型4
    //...................
    
    NSArray *menuModelArr = @[menuModel0, menuModel1, menuModel2, menuModel3......];
    
    return menuModelArr;
}
```


创建下拉菜单方式1
```objc
/** 创建下拉菜单方式1 */
- (void)createDropdownMenuMethodOne {
    

    //若使用默认CGFloat值     请使用 FFDefaultFloat
    //若使用默认CGSize值      请使用 FFDefaultSize
    //若使用默认Cell值        请使用 FFDefaultCell
    //若使用默认Color值       请使用 FFDefaultColor
    //若使用默认ScaleType值   请使用 FFDefaultMenuScaleType
    
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    self.dropDownMenu = [FFDropDownMenuView ff_DefaultStyleDropDownMenuWithMenuModelsArray:menuModelsArr menuWidth:145 eachItemHeight:40 menuRightMargin:10 triangleRightMargin:20];
    

    //若还需要对别的属性进行赋值，则可以再对别的属性进行赋值，最后一定要调用setup方法。如下

    /*
    self.dropDownMenu.menuScaleType = FFDropDownMenuViewScaleType_TopRight;
    self.dropDownMenu...... = ......;
    [self.dropDownMenu setup];
     */
}
```

创建下拉菜单方式2

```objc
/** 创建下拉菜单方式2 */
- (void)createDropdownMenuMethodTwo {
    NSArray *menuModelsArr = [self getDropDownMenuModelsArray];
    self.dropDownMenu = [FFDropDownMenuView new];
    
    //进行属性的赋值
    
    //若使用默认CGFloat值     请使用 FFDefaultFloat          、或者无需进行赋值
    //若使用默认CGSize值      请使用 FFDefaultSize           、或者无需进行赋值
    //若使用默认Cell值        请使用 FFDefaultCell           、或者无需进行赋值
    //若使用默认Color值       请使用 FFDefaultColor          、或者无需进行赋值
    //若使用默认ScaleType值   请使用 FFDefaultMenuScaleType  、或者无需进行赋值
    
    
    /** 下拉菜单模型数组 */
    self.dropDownMenu.menuModelsArray = menuModelsArr;
    /** cell的类名 */
    self.dropDownMenu.cellClassName = FFDefaultCell;
    /** 菜单的宽度(若不设置，默认为 150) */
    self.dropDownMenu.menuWidth = 145;
    /** 菜单的圆角半径(若不设置，默认为5) */
    self.dropDownMenu.menuCornerRadius = FFDefaultFloat;
    /** 每一个选项的高度(若不设置，默认为40) */
    self.dropDownMenu.eachMenuItemHeight = 40;
    /** 菜单条离屏幕右边的间距(若不设置，默认为10) */
    self.dropDownMenu.menuRightMargin = 10;
    /** 三角形颜色(若不设置，默认为白色) */
    self.dropDownMenu.triangleColor = [UIColor whiteColor];
    /** 三角形相对于keyWindow的y值,也就是相对于屏幕顶部的y值(若不设置，默认为64) */
    self.dropDownMenu.triangleY = FFDefaultFloat;
    /** 三角形距离屏幕右边的间距(若不设置，默认为20) */
    self.dropDownMenu.triangleRightMargin = FFDefaultFloat;
    /** 三角形的size  size.width:代表三角形底部边长，size.Height:代表三角形的高度(若不设置，默认为CGSizeMake(15, 10)) */
    self.dropDownMenu.triangleSize = FFDefaultSize;
    /** 背景颜色开始时的透明度(还没展示menu的透明度)(若不设置，默认为0.02) */
    self.dropDownMenu.bgColorbeginAlpha = 0;
    /** 背景颜色结束的的透明度(menu完全展示的透明度)(若不设置，默认为0.2) */
    self.dropDownMenu.bgColorEndAlpha = 0.4;
    /** 动画效果时间(若不设置，默认为0.2) */
    self.dropDownMenu.animateDuration = FFDefaultFloat;
    /** 菜单的伸缩类型 */
    self.dropDownMenu.menuScaleType = FFDefaultMenuScaleType;
    
    
    //所有属性赋值完 一定要调用 setup
    [self.dropDownMenu setup];
    
}
```

显示菜单
```objc
    [self.dropDownMenu showMenu];
```

---
---

若觉得框架自带的菜单样式不是自己喜欢的，或者需要给菜单选项添加更多的子控件，可以通过自定义菜单选项来实现，具体使用方式，点击下面两个链接查看即可。(If you don't like the default menu style ,or need add more view in menu item, you can custom the menu style.The links below will guide you to custom menu style.)
===

###[自定义菜单选项 -- xib方式(custom menu style by xib)](http://www.jianshu.com/p/6a42a35ae2db)
-  

![仿手机QQ下拉菜单.png](https://raw.githubusercontent.com/chenfanfang/FFDropDownMenu/35d221a5f6ecd4a0956bd4d7652f91495beee5ea/FFDropDownMenuDemo/Resources/%E8%87%AA%E5%AE%9A%E4%B9%89%E8%8F%9C%E5%8D%95%E6%A0%B7%E5%BC%8F(xib)/customMenuStyleXib.png)




---
---
###[自定义菜单选项 -- 非xib方式(suctom menu style by code)](http://www.jianshu.com/p/eead6fe4d59f)
- 

![仿手机QQ下拉菜单.png](https://raw.githubusercontent.com/chenfanfang/FFDropDownMenu/35d221a5f6ecd4a0956bd4d7652f91495beee5ea/FFDropDownMenuDemo/Resources/%E8%87%AA%E5%AE%9A%E4%B9%89%E8%8F%9C%E5%8D%95%E6%A0%B7%E5%BC%8F(%E9%9D%9Exib)/customMenuStyle.png)


---
---

版本更新
===
###2016-11-13
- 增加了几个代理方法

```objc
/** 若是自定义cell样式的，可以在这个代理方法中稍微小修改cell的样式，比如是否需要下划线之类的 */

- (void)ffDropDownMenuView:(FFDropDownMenuView *)menuView WillAppearMenuCell:(FFDropDownMenuBasedCell *)menuCell index:(NSInteger)index;

- (void)ffDropDownMenuViewWillAppear;

- (void)ffDropDownMenuViewWDidAppear;

- (void)ffDropDownMenuViewWillDisappear;

- (void)ffDropDownMenuViewWDidDisappear;
```


---
---



## 期待
* 如果在使用过程中遇到BUG，希望你能在 简书私信我，或者在我简书专题的博客进行评论。谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能在 简书私信我，或者在我简书专题的博客进行评论。我非常想为这个框架增加更多好用的功能，谢谢
* 如果你想和我一起完善FFDropDownMenu，请Pull Requests我

##[About me](http://www.jianshu.com/users/80fadb71940d/latest_articles)


//
//  FFMenuViewController.m
//  FFDropDownMenuDemo
//
//  Created by mac on 16/8/7.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFMenuViewController.h"

@interface FFMenuViewController ()

/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation FFMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.backgroundImageView.image = [UIImage imageNamed:self.backgroundImageName];
}





@end

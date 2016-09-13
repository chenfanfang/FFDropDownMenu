//
//  FFDropDownMenu.h
//  FFDropDownMenuDemo
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//
#import "FFDropDownMenuBasedCell.h"
#import "FFDropDownMenuBasedModel.h"


#ifdef DEBUG

#define FFLog(...) NSLog(@"\n\n--------------------------------------------------\n%s方法中的第  %d  行打印: \n%@\n--------------------------------------------------\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else

#define FFLog(...)

#endif
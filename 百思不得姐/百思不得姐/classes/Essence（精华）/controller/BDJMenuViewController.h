//
//  BDJMenuViewController.h
//  百思不得姐
//
//  Created by qianfeng on 2016/11/23.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import "BaseViewController.h"
/******精华和最新界面公共的界面*******/
@interface BDJMenuViewController : BaseViewController
//标题列表数据
@property(nonatomic,strong)NSArray *subMenus;

//右边的图片
@property(nonatomic,copy)NSString *rightImageName;
//右边按钮的高亮图片
@property(nonatomic,copy)NSString *rightHLImageName;
//右边按钮的点击事件
@property(nonatomic,strong)void(^rightBtnclickBlock)(void);
@end

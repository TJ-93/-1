//
//  BDJMenuView.h
//  百思不得姐
//
//  Created by qianfeng on 2016/11/24.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDJMenuView;
typedef NS_ENUM(NSInteger,MenuType){
    MenuTypeEssence=1<<0, //精华
    MenuTypeNews=1<<1 //最新
};

@protocol BDJMenuViewDelegate <NSObject>

-(void)menuView:(BDJMenuView *)menuView didClickBtnAtIndex:(NSInteger)index;
-(void)menuView:(BDJMenuView *)menuView didClickRightBtn:(MenuType)type;
@end
@class BDJSubMenu;
@interface BDJMenuView : UIView
@property(nonatomic,assign)MenuType type;
@property(nonatomic,weak)id<BDJMenuViewDelegate> delegate;
-(instancetype)initWithItems:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName;
//当前选中的按钮
@property (nonatomic,assign)NSInteger selectIndex;
//数据的属性

@end
//菜单按钮
@interface BDJMenuButton:UIControl
-(instancetype)initWithTitle:(NSString *)title;

//是否选中
@property(nonatomic,assign)BOOL clicked;
@property(nonatomic,assign)NSInteger btnIndex;
@end

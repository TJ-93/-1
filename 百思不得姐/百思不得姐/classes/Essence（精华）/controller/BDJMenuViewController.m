//
//  BDJMenuViewController.m
//  百思不得姐
//
//  Created by qianfeng on 2016/11/23.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import "BDJMenuViewController.h"
#import "BDJTableViewController.h"
#import "BDJMenu.h"
#import "BDJMenuView.h"
@interface BDJMenuViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,BDJMenuViewDelegate>
@property(nonatomic,strong)NSMutableArray *ctrlArray;
//当前显示的视图控制器的序号
@property(nonatomic,assign)NSInteger curPageIndex;
//分页视图控制器
@property(nonatomic,strong) UIPageViewController *pageCtrl;
@property(nonatomic,strong)BDJMenuView *menuView;
@end

@implementation BDJMenuViewController
-(NSMutableArray *)ctrlArray{
    if(nil==_ctrlArray){
        _ctrlArray=[NSMutableArray array];
    }
    return _ctrlArray;
}

-(void)setSubMenus:(NSArray *)subMenus{
    _subMenus=subMenus;
    //循环创建tableView
    for(BDJSubMenu *subMenu in subMenus){
        BDJTableViewController *ctrl=[[BDJTableViewController alloc]init];
        ctrl.url=subMenu.url;
        ctrl.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f];
        [self.ctrlArray addObject:ctrl];
        
    }
    [self createPageCtrl];
    //创建导航
    [self createMenu];
}
-(void)createMenu{
    BDJMenuView *menuView=[[BDJMenuView alloc]initWithItems:self.subMenus rightIcon:_rightImageName rightSelectIcon:_rightHLImageName];
    self.menuView=menuView;
    menuView.delegate=self;
    self.navigationItem.titleView=menuView;
    //约束
    [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.navigationController.view);
        make.top.equalTo(self.navigationController.view).offset(20);
        make.height.mas_equalTo(44);
    }];
    
}
//创建分页控制器
-(void)createPageCtrl{
    UIPageViewController *pageCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageCtrl.delegate=self;
    pageCtrl.dataSource=self;
    [pageCtrl setViewControllers:@[[self.ctrlArray firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.view addSubview:pageCtrl.view];
    self.pageCtrl=pageCtrl;
    [pageCtrl.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 49, 0));
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIpageview
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //当前的序号
    NSInteger curIndex=[self.ctrlArray indexOfObject:viewController];
    //获取后面的视图控制器
    if(curIndex +1 >= self.ctrlArray.count){
        return nil;
    }else{
        return self.ctrlArray[curIndex+1];
    }
}
//返回向前滑动时显示的视图控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger curIndex=[self.ctrlArray indexOfObject:viewController];
    if(curIndex -1<0){
        return nil;
    }else{
        return self.ctrlArray[curIndex-1];
    }
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    UIViewController *toCtrl=[pendingViewControllers lastObject];
    NSInteger index=[self.ctrlArray indexOfObject:toCtrl];
    
    self.curPageIndex=index;
}
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    self.menuView.selectIndex=self.curPageIndex;
   }
#pragma mark-BDJMenuView代理
-(void)menuView:(BDJMenuView *)menuView didClickBtnAtIndex:(NSInteger)index{
    //获取视图控制器
    UIViewController *vc=self.ctrlArray[index];
    //向右滑
    UIPageViewControllerNavigationDirection dir=UIPageViewControllerNavigationDirectionForward;
    if(index<self.curPageIndex){
        //向左滑
        dir=UIPageViewControllerNavigationDirectionReverse;
    }
    self.curPageIndex=index;
    [self.pageCtrl setViewControllers:@[vc] direction:dir animated:YES completion:nil];
}
-(void)menuView:(BDJMenuView *)menuView didClickRightBtn:(MenuType)type{
    
}
@end

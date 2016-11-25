//
//  BDJTabBar.m
//  百思不得姐
//
//  Created by qianfeng on 2016/11/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import "BDJTabBar.h"

@implementation BDJTabBar
-(instancetype)init{
    if(self=[super init]){
        UIButton *btn=[UIButton createBtnTitle:nil bgImageName:@"tabBar_publish_icon" highlightBgImageName:@"tabBar_publish_click_icon" target:self action:@selector(publishAction)];
       
        [self addSubview:btn];
    }
    return self;
}

-(void)publishAction{
    NSLog(@"111");
}
//在当前对象的子视图重新布局的时候调用
/*在什么时候子视图会重新布局
 1.视图显示到父视图上面的时候
 2.手动调用了视图对象的layoutIfNeed方法
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnW=KScreenWidth/5;
    
    NSInteger index=0;
    for(UIView *tmpView in self.subviews){
        if([tmpView isKindOfClass:[UIButton class]]){
//             tmpView.frame=CGRectMake(btnW*2, 4, btnW, 40);
            tmpView.center=CGPointMake(KScreenWidth/2.0f, 49.0f/2);
            tmpView.size=CGSizeMake(40, 40);
        }else if([tmpView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            tmpView.width=btnW;
            if (index>=2){
                tmpView.x=(index+1)*btnW;
            }else{
                tmpView.x=index*btnW;
            }
            
            
            index++;
        }
        
    }
}
@end

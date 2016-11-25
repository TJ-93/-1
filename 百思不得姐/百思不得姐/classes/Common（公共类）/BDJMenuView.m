//
//  BDJMenuView.m
//  百思不得姐
//
//  Created by qianfeng on 2016/11/24.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import "BDJMenuView.h"
#import "UILabel+Util.h"
#import "BDJMenu.h"
#define kContainerViewTag 100
@interface BDJMenuView()
//滚动视图
@property (nonatomic,strong)UIScrollView *scrollView;
//下滑线
@property(nonatomic,strong)UIView *lineView;
@end
@implementation BDJMenuView
-(instancetype)initWithItems:(NSArray *)array rightIcon:(NSString *)iconName rightSelectIcon:(NSString *)selectIconName{
    if(self=[super init]){
        //左边的滚动视图
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        [self addSubview:scrollView];
        self.scrollView=scrollView;
        scrollView.showsHorizontalScrollIndicator=NO;
        //约束
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 60));
        }];
        //容器视图
        UIView *containerView=[[UIView alloc]init];
        containerView.tag=kContainerViewTag;
        [scrollView addSubview:containerView];
        //约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.height.equalTo(scrollView);
        }];
        CGFloat btnW=60;
        //按钮
        UIView *lastView=nil;
        NSInteger i=0;
        for(BDJSubMenu *subMenu in array){
            BDJMenuButton *btn=[[BDJMenuButton alloc]initWithTitle:subMenu.name];
            btn.btnIndex=i++;
            if (btn.btnIndex==0){
                btn.clicked=YES;
            }
            [containerView addSubview:btn];
            //点击事件
            [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
            
            //约束
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.width.mas_equalTo(btnW);
                if(lastView==nil){
                    make.left.equalTo(containerView);
                }else{
                    make.left.equalTo(lastView.mas_right);
                }
            }];
            lastView=btn;
            
            
        }
        //更新日期的约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView);
        }];
        //右边的按钮
        UIButton *rightBtn=[UIButton createBtnTitle:nil bgImageName:iconName highlightBgImageName:selectIconName target:self action:@selector(clickRight)];
        [self addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(4);
            make.right.equalTo(self).offset(-10);
//            make.right.equalTo(self);
            make.width.mas_equalTo(36);
            make.height.mas_equalTo(36);
        }];
        
        self.lineView=[[UIView alloc]init];
        self.lineView.backgroundColor=[UIColor redColor];
        [self.scrollView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView);
            make.bottom.equalTo(self.scrollView);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(2);
        }];
    }
    return self;
}
//切换按钮的选中状态
-(void)setSelectIndex:(NSInteger)selectIndex{
    if(_selectIndex!=selectIndex){
        BDJMenuButton *lastBtn=nil;
        BDJMenuButton *curBtn=nil;
        UIView *containerView=[self.scrollView viewWithTag:kContainerViewTag];
        for(BDJMenuButton *tmpBtn in containerView.subviews){
            if (tmpBtn.btnIndex ==selectIndex){
                curBtn=tmpBtn;
            }else if (tmpBtn.btnIndex==_selectIndex){
                lastBtn=tmpBtn;
            }
        }
    //1.取消之前选中的按钮
        lastBtn.clicked=NO;
    //2.选中当前的按钮
        curBtn.clicked=YES;
    //3.修改下划线的位置
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(curBtn);
            make.bottom.equalTo(self.scrollView);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(2);
        }];
        
        //4.将当前选中的按钮尽可能显示在中间
      
        CGFloat x=CGRectGetMidX(curBtn.frame)-self.scrollView.bounds.size.width/2;
        if(x<0){
            x=0;
        }
        if(x>self.scrollView.contentSize.width-self.scrollView.bounds.size.width){
            x=self.scrollView.contentSize.width-self.scrollView.bounds.size.width;
        }
        self.scrollView.contentOffset=CGPointMake(x, 0);
        _selectIndex=selectIndex;
}
}
-(void)clickMenu:(BDJMenuButton *)btn{
    //1.切换按钮的选中状态
    self.selectIndex=btn.btnIndex;
    
    //2.切换对应的界面
    [self.delegate menuView:self didClickBtnAtIndex:self.selectIndex];
}
-(void)clickRight{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@implementation BDJMenuButton{
    UILabel *_titleLabel;
}
-(instancetype)initWithTitle:(NSString *)title{
    if(self=[super init]){
        _titleLabel=[UILabel createLabel:title textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:20]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            
        }];
    }
    return self;
}

//切换选中状态
-(void)setClicked:(BOOL)clicked{
    _clicked=clicked;
    if(_clicked){
        _titleLabel.textColor=[UIColor redColor];
    }else{
        _titleLabel.textColor=[UIColor grayColor];
    }
}
@end





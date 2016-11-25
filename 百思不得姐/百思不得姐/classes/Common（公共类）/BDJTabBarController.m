//
//  BDJTabBarController.m
//  百思不得姐
//
//  Created by qianfeng on 2016/11/21.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import "BDJTabBarController.h"
#import "EssenceViewController.h"
#import "BDJTabBar.h"
#import "BDJMenu.h"
#import "NewsViewController.h"
@interface BDJTabBarController ()

@end

@implementation BDJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tabBar.tintColor=[UIColor colorWithWhite:64.0f/255.0f alpha:1.0f];
    [UITabBar appearance].tintColor=[UIColor colorWithWhite:64.0f/255.0f alpha:1.0f];
    
//    创建自定义tabBar
    [self setValue:[[BDJTabBar alloc]init] forKey:@"tabBar"];
    [self createViewControllers];
    //获取本地菜单数据
    [self loadMeniData];
    
    
}
//获取菜单的数据
-(void)loadMeniData{
    NSString *filePath=[self menuFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]){
        NSData *data=[NSData dataWithContentsOfFile:filePath];
        BDJMenu *menu=[[BDJMenu alloc]initWithData:data error:nil];
        //显示
        [self showAllMenuData:menu];
    }
    //更新菜单的数据
    [self downloadMenuData];
}


-(void)downloadMenuData{
   //http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/
    [BDJDownloader downloadWithURLString:@"http://s.budejie.com/public/list-appbar/bs0315-iphone-4.3/" success:^(NSData *data) {
        
        BDJMenu *menu=[[BDJMenu alloc]initWithData:data error:nil];
         NSString *path=[self menuFilePath];
        
        
        
        if(![[NSFileManager defaultManager]fileExistsAtPath:path]){
            [self showAllMenuData:menu];
        }
        //存到本地
       
        [data writeToFile:path atomically:YES];
        
    } fail:^(NSError *error) {
        
    }];
}
//本地存储菜单数据的文件名
-(NSString *)menuFilePath {
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [docPath stringByAppendingPathComponent:@"menu.plist"];
}
-(void)showAllMenuData:(BDJMenu *)menu{
    //设置精华的界面的菜单数据
    UINavigationController *essenceNavCtrl=[self.viewControllers firstObject];
    EssenceViewController *essenceCtrl=[essenceNavCtrl.viewControllers firstObject];
    essenceCtrl.subMenus=[[menu.menus firstObject] submenus];
    
    //设置最新的界面的菜单数据
    if(self.viewControllers.count>=2){
        UINavigationController *newsNavCtrl=self.viewControllers[1];
        NewsViewController *newsCtrl=[newsNavCtrl.viewControllers firstObject];
        if(menu.menus.count>=2){
            newsCtrl.subMenus=[menu.menus[1] submenus];
        }
    }
}
-(void)createViewControllers{
    
//    1.精华
    [self addSubController:@"EssenceViewController" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon" title:@"精华"];
//    2.最新
    [self addSubController:@"NewsViewController" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon" title:@"最新"];
//    3.添加
    
//    4.关注
    [self addSubController:@"AttentionViewController" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon" title:@"关注"];
//    5.我的
    [self addSubController:@"ProfileViewController" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon" title:@"我的"];
}
-(void)addSubController:(NSString *)ctrlName imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName title:(NSString *)title{
    Class cls=NSClassFromString(ctrlName);
    UIViewController *tmpCtrl=[[cls alloc]init];
    
    tmpCtrl.tabBarItem.title=title;
    tmpCtrl.tabBarItem.image=[UIImage imageNamed:imageName];
    tmpCtrl.tabBarItem.selectedImage=[UIImage imageNamed:selectedImageName];
    
//    导航
    UINavigationController *navCtrl=[[UINavigationController alloc]initWithRootViewController:tmpCtrl];
    
    
    [self addChildViewController:navCtrl];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

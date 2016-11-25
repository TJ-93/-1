//
//  EssenceVideoCell.h
//  百思不得姐
//
//  Created by qianfeng on 2016/11/22.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDJEssenceDetail;
@interface EssenceVideoCell : UITableViewCell
@property(nonatomic,strong)BDJEssenceDetail *detailModel;
+ (EssenceVideoCell *)videoCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath WithModel:(BDJEssenceDetail *)detailModel;
@end

//
//  EssenceVideoCell.m
//  百思不得姐
//
//  Created by qianfeng on 2016/11/22.
//  Copyright © 2016年 陶杰. All rights reserved.
//

#import "EssenceVideoCell.h"
#import "BDJEssenceModel.h"
@interface EssenceVideoCell()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *passTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *palyNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHCons;
//评论视图的高度和top偏移量
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewHCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentViewYCons;

@end
@implementation EssenceVideoCell


//更多按钮
- (IBAction)btnAction:(UIButton *)sender {
    
}
//播放按钮
- (IBAction)playAction:(id)sender {
    
}

- (IBAction)dingAction:(id)sender {
}

- (IBAction)caiAction:(id)sender {
}
- (IBAction)shanreAction:(id)sender {
}

- (IBAction)commentAction:(id)sender {
}

+(EssenceVideoCell *)videoCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexpath WithModel:(BDJEssenceDetail *)detailModel{
    static NSString *cellId=@"videoCellId";
    EssenceVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(nil==cell){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"EssenceVideoCell" owner:nil options:nil]lastObject];
    }
    cell.detailModel=detailModel;
    return cell;
}
-(void)setDetailModel:(BDJEssenceDetail *)detailModel{
    _detailModel=detailModel;
       //用户标签 用户名 时间
    NSString *headerString=[detailModel.u.header firstObject];
    NSURL *url=[NSURL URLWithString:headerString];
    [self.userImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    
    self.userNamelabel.text=detailModel.u.name;
    
    self.passTimeLabel.text=detailModel.passtime;
    
    self.descLabel.text=detailModel.text;
    
    //图片
    NSString *videoString=[detailModel.video.thumbnail_small firstObject];
    NSURL *videoURL=[NSURL URLWithString:videoString];
    [self.videoImageView sd_setImageWithURL:videoURL placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
//    修改图片高度
    CGFloat imageH=(KScreenWidth-20)*detailModel.video.height.floatValue/detailModel.video.width.floatValue;
    self.imageHCons.constant=imageH;
    
    //播放次数
    self.palyNumLabel.text=detailModel.video.playcount.stringValue;
     //视频时间
    NSInteger min=0;
    NSInteger sec=detailModel.video.duration.integerValue;
    if(sec>=60){
        min=sec/60;
        sec=sec%60;
    }
    self.playTimeLabel.text=[NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    if(detailModel.top_comments.count>0){
        BDJEssenceComment *comment=[detailModel.top_comments firstObject];
        self.commentLabel.text=comment.content;
    }else{
        self.commentLabel.text=nil;
    }
    //强制cell布局一次
    [self layoutIfNeeded];
    
     //评论文字
    if(detailModel.top_comments.count>0){
       
        self.commentViewYCons.constant=10;
        self.commentViewHCons.constant=self.commentLabel.frame.size.height+20;
    }else{
        //没有评论部分
        self.commentViewHCons.constant=0;
        self.commentViewYCons.constant=0;
    }
    
    //标签
    NSMutableString *tagString=[NSMutableString string];
    for(NSInteger i=0;i<detailModel.tags.count;i++){
        BDJEssenceTag *tag=detailModel.tags[i];
        [tagString appendFormat:@"%@",tag.name];
    }
    self.tagLabel.text=tagString;
    
//  顶。踩。。。。
    [self.dingBtn setTitle:detailModel.up forState:UIControlStateNormal];
    [self.caiBtn setTitle:[detailModel.down stringValue] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[detailModel.forward stringValue] forState:UIControlStateNormal];
    [self.commentBtn setTitle:detailModel.comment forState:UIControlStateNormal];
    //强制刷新一次
    [self layoutIfNeeded];
    //基本类型转对象@()
   detailModel.cellHeight=@(CGRectGetMaxY(self.dingBtn.frame)+10+10);
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

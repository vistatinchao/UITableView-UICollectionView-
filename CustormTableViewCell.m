//
//  CustormTableViewCell.m
//  UITableView和UICollectionView联动
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "CustormTableViewCell.h"
@interface CustormTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *leftLineView;

@end
@implementation CustormTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.leftLineView.hidden = !selected;// 一定要去掉cell的选中状态不然显示不了
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end

//
//  CustormCollectionViewCell.m
//  UITableView和UICollectionView联动
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "CustormCollectionViewCell.h"
@interface CustormCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation CustormCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor purpleColor];
    // Initialization code
}

- (void)setTitle:(NSString *)title{
    self.nameLabel.text = title;
}

@end

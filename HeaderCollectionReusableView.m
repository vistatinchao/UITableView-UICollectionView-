//
//  HeaderCollectionReusableView.m
//  UITableView和UICollectionView联动
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
@interface HeaderCollectionReusableView()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end
@implementation HeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setHeaderTitle:(NSString *)headerTitle{
    self.headerLabel.text = headerTitle;
}
@end

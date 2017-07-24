//
//  CustormFlowLayout.m
//  UITableView和UICollectionView联动
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "CustormFlowLayout.h"

@implementation CustormFlowLayout
- (void)prepareLayout{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat inset = 10;
    self.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    self.minimumLineSpacing = inset;
    self.minimumInteritemSpacing = inset;
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 44);
}

@end

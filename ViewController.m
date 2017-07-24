//
//  ViewController.m
//  UITableView和UICollectionView联动
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 United Network Services Ltd. of Shenzhen City. All rights reserved.
//

#import "ViewController.h"
#import "CustormCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "CustormTableViewCell.h"
#import "CustormFlowLayout.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *rightCollectionView;
/**数据源*/
@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation ViewController
static NSString *const tableViewCellID = @"tableViewCellID";
static NSString *const collectionViewCellID = @"collectionViewCellID";
static NSString *const collectionViewHeaderID = @"header";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
}

#pragma mark - 注册cell
- (void)registerCell{
    //leftTableView
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustormTableViewCell class]) bundle:nil] forCellReuseIdentifier:tableViewCellID];
    self.leftTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];// 初始化选中第一行
    //rightCollectionView
    [self.rightCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustormCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:collectionViewCellID];
    [self.rightCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HeaderCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderID];
    // 布局rightCollectionView
    CustormFlowLayout *layout = [[CustormFlowLayout alloc]init];
    self.rightCollectionView.collectionViewLayout = layout;

}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   CustormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    cell.textLabel.text = self.dataSource[indexPath.row][@"title"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger index = indexPath.row;
    [self.rightCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    CGPoint offset = self.rightCollectionView.contentOffset;
    offset.y-=44;
    self.rightCollectionView.contentOffset = offset;
}

#pragma mark - collectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource[section][@"list"] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustormCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    cell.title = self.dataSource[indexPath.section][@"list"][indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderID forIndexPath:indexPath];
        headerView.headerTitle = self.dataSource[indexPath.section][@"title"];
        return headerView;

    }
    return nil;
}

#pragma mark - collectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat maxCow = 2;
    CGFloat inset = 10;
    CGFloat itemW = (self.rightCollectionView.frame.size.width-(maxCow+1)*inset)/maxCow;
    return CGSizeMake(itemW, 120);
}
/**
 记录collectionviewcell 滚动到哪个位置
 */
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger showIndex = indexPath.section;
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:showIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
}
#pragma mark - 数据源lazy
-(NSArray *)dataSource{

    if (!_dataSource) {

        _dataSource = @[@{@"title":@"龙虾",@"list":@[@"加拿大龙虾",@"美国龙虾",@"爱尔兰龙虾",@"西澳龙",@"南澳龙",@"南非油龙",@"巴基斯坦油龙",@"南非龙",@"南非玫瑰龙",@"葡萄牙玫瑰龙",@"琵琶龙虾"],@"imgs":@[@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong"]},
                        @{@"title":@"蟹类",@"list":@[@"加拿大珍宝蟹",@"美国珍宝蟹",@"英国面包蟹",@"爱尔兰面包蟹",@"美国面包蟹",@"澳大利亚皇帝蟹",@"美国白雪蟹",@"美国红雪蟹",@"阳澄湖大闸蟹",@"加拿大帝王蟹"],@"imgs":@[@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong"]},
                        @{@"title":@"贝类",@"list":@[@"法国生蚝",@"爱尔兰生蚝",@"新西兰生蚝",@"加拿大生蚝",@"澳洲生蚝",@"美国生蚝",@"中国生蚝",@"纳米比亚生蚝"],@"imgs":@[@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong"]},
                        @{@"title":@"其他活鲜",@"list":@[@"智利三文鱼",@"加拿大三文鱼",@"苏格兰三文鱼",@"法罗群岛三文鱼",@"牡丹虾",@"新西兰鳗鱼",@"中国鳗鱼",@"加拿大海胆",@"南非海胆",@"美国海胆"],@"imgs":@[@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong"]},
                        @{@"title":@"冻品",@"list":@[@"波虾",@"海鳌虾",@"红虾",@"油龙",@"小龙虾",@"白虾",@"蓝虾",@"小蜜蜂",@"玫瑰龙",@"南非龙",@"帝王蟹",@"面包蟹",@"三文鱼",@"金枪鱼",@"鳕鱼",@"鳗鱼",@"比目鱼",@"冻带鱼",@"文莱龙趸石斑",@"红斑鱼",@"金昌鱼",@"马头鱼",@"北极贝",@"青口贝",@"海螺",@"鲍鱼",@"生蚝",@"兰花蚌",@"日月贝",@"墨鱼仔",@"花枝卷",@"朝鲜蚌",@"牛扒",@"牛板腱",@"牛肉",@"穗香鸡",@"鱿鱼"],@"imgs":@[@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong",@"bolong"]}];
    }
    return _dataSource;
}



@end

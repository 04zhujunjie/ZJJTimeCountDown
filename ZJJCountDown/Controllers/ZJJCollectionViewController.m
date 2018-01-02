//
//  ZJJCollectionViewController.m
//  TableViewRefreshDemo
//
//  Created by xiaozhu on 2017/6/28.
//  Copyright © 2017年 xiaozhu. All rights reserved.
//

#import "ZJJCollectionViewController.h"
#import "JMWaterflowLayout.h"
#import "HomeGoodsHeader.h"
#import "ZJJTimeCountDown.h"
#import "TimeModel.h"
#import "ZJJTimeCountDownLabel.h"
#import "ZJJCollectionViewCell.h"
#import "WatchModel.h"
#import "ZJJTimeCountDownDateTool.h"
#define KHeaderGoodsIdentifier @"HomeGoodsHeader"
#define KFooterGoodsIdentifier @"FooterGoodsIdentifier"


static NSString * const kCollectionViewID = @"collectionView";

@interface ZJJCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,JMWaterflowLayoutDelegate,ZJJTimeCountDownDelegate>{

    ZJJTimeCountDown * _countDown;
}

@property (nonatomic ,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataList;

@end

@implementation ZJJCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _countDown = [[ZJJTimeCountDown alloc] initWithScrollView:self.collectionView dataList:self.dataList];
    _countDown.delegate = self;
    // Do any additional setup after loading the view.
}


#pragma mark - *** CollectionView *** -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    ZJJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJJCollectionViewCell class]) forIndexPath:indexPath];
    WatchModel *model = self.dataList[indexPath.row];

    [cell.timeLabel setupCellWithModel:model indexPath:indexPath];
    //在不设置为过时自动删除情况下 滑动过快的时候时间不会闪
    cell.timeLabel.attributedText = [_countDown countDownWithTimeLabel:cell.timeLabel];
    
    cell.watchImageView.image = [UIImage imageNamed:model.imageName];
   
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      
        HomeGoodsHeader *header  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHeaderGoodsIdentifier forIndexPath:indexPath];
            return header;
    }else{
    
        HomeGoodsHeader *footer  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterGoodsIdentifier forIndexPath:indexPath];
         footer.label.text = @"加载完毕";
        return footer;
    }
    return nil;
}




/**
设置表头高度
 */
- (CGFloat)heightForHeaderViewInWaterflowLayout:(JMWaterflowLayout *)layout{

    return 30;
}


/**
 设置表尾高度
 */
- (CGFloat)heightForFooterViewInWaterflowLayout:(JMWaterflowLayout *)layout{

    return 30;
}


#pragma mark - <XMGWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(JMWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{

    WatchModel *model = self.dataList[index];
    UIImage *image = [UIImage imageNamed:model.imageName];
    
    return itemWidth*image.size.height/image.size.width+34;
}

/**
 返回列数

 */
- (NSInteger)columnCountInWaterflowLayout:(JMWaterflowLayout *)waterflowLayout{

    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView{

    if (!_collectionView) {
        
         JMWaterflowLayout *layout = [[JMWaterflowLayout alloc] init];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJJCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ZJJCollectionViewCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:KHeaderGoodsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHeaderGoodsIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:KHeaderGoodsIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterGoodsIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}

- (void)dealloc {
    /// 2.销毁
    [_countDown destoryTimer];
}

- (NSMutableArray *)dataList{
    
    if (!_dataList) {
        
        _dataList = [NSMutableArray array];
        [self addData];
    }
    
    return _dataList;
}

- (void)addData{
    
    //    NSArray *arr = @[@"1496881149",@"1496881149",@"1496881149",@"1496881149",@"1496881149",@"1496881149",@"1591881249", @"1496881149",@"1596889949",@"1596881349",@"1596881449",@"1596881529",
    //                     @"1496881629",@"1486881729",@"1586991029",@"1586994829",@"1586990929",@"1581699702"
    //                     ];
//    //
//        NSArray *arr = @[@"2017-2-5 12:10:06",
//                          @"2017-3-5 12:10:06",
//                          @"2018-4-5 12:10:06",
//                          @"2017-5-5 12:10:06",
//                          @"2030-6-5 12:10:06",
//                          @"2017-7-10 18:6:16",
//                          @"2027-8-5 18:10:06",
//                          @"2017-9-5 18:10:06",
//                         @"2017-10-5 18:10:06",
//                         @"2017-7-10 18:6:16",
//                         @"2017-8-5 18:10:06",
//                         @"2017-9-5 18:10:06",
//                         @"2017-10-5 18:10:06",
//                         @"2017-7-10 18:6:16",
//                         @"2017-8-5 18:10:06",
//                         @"2017-9-5 18:10:06",
//                         @"2017-10-5 18:10:06",
//                         @"2017-4-5 12:10:06",
//                         @"2027-5-5 12:10:06",
//                         @"2017-6-5 12:10:06",
//                         @"2017-7-10 18:6:16",
//                         @"2017-7-10 18:6:16",
//                         @"2017-8-5 18:10:06",
//                         @"2017-9-5 18:10:06",
//                         @"2017-10-5 18:10:06",
//                         @"2017-4-5 12:10:06",
//                         @"2027-5-5 12:10:06",
//                         @"2017-6-5 12:10:06",
//                         @"2017-7-10 18:6:16"];
//    
//    
//    for (int i = 0; i < arr.count; i ++) {
//        
//        TimeModel *model = [TimeModel new];
//        model.endTime = arr[i];
//        [_dataList addObject:model];
//    }
    
    for (int i = 0; i < 100; i ++) {
        WatchModel *model = [WatchModel new];
        model.imageName = [NSString stringWithFormat:@"watch%d",arc4random()%5];
        model.startTime = [ZJJTimeCountDownDateTool dateByAddingSeconds:arc4random()%10000+60 timeStyle:_countDown.timeStyle];
        [self.dataList addObject:model];
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

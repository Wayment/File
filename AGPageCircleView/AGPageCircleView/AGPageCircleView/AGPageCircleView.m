//
//  AGPageCircleView.m
//  AGPageCircleView
//
//  Created by Huiming on 16/7/18.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import "AGPageCircleView.h"
#import "AGPageCircleViewCell.h"

@interface AGPageCircleView() <UICollectionViewDataSource, UICollectionViewDelegate>

/** 显示图片的collectionView */
@property (nonatomic, weak) UICollectionView *collectionView; //
/** 布局 */
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
/** 循环图片数组 */
@property (nonatomic, strong) NSMutableArray *circleArray;
/** 当前实际索引 */
@property (nonatomic, assign) NSInteger currentRealityIndex;
/** 当前逻辑索引 */
@property (nonatomic, assign) NSInteger currentLogicIndex;
/** 当前逻辑总页数 */
@property (nonatomic, assign) NSInteger logicCount;
/** 页码控制器 */
@property (nonatomic, strong) UIPageControl *pageControl;


@end

@implementation AGPageCircleView

static NSString *const PageCircleCellID = @"pageCircleCellID";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setupScrollView];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
    [self setupScrollView];
}

#pragma mark - setup
- (void)setup {
    self.circleArray = [NSMutableArray array];
    //默认时间
    self.pageTime = 2.0;
}

- (void)setupScrollView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.pagingEnabled = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:collectionView];
    [collectionView registerClass:[AGPageCircleViewCell class] forCellWithReuseIdentifier:PageCircleCellID];
    _collectionView = collectionView;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

#pragma mark - Action
- (void)automaticChangePage {
    self.currentRealityIndex = self.currentRealityIndex == self.circleArray.count - 1 ? 0 : self.currentRealityIndex + 1;
    NSLog(@"!!---> next Page currentRealityIndex:%zd", self.currentRealityIndex);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentRealityIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - Setter
- (void)setImageNameArray:(NSArray *)imageNameArray {
    _imageNameArray = imageNameArray;
    self.logicCount = imageNameArray.count;
    self.pageControl.numberOfPages = imageNameArray.count;
    if (imageNameArray.count > 1) {
        [self.circleArray addObject:[imageNameArray lastObject]];
        [self.circleArray addObjectsFromArray:imageNameArray];
        [self.circleArray addObject:[imageNameArray firstObject]];
        [self.collectionView reloadData];
        self.currentRealityIndex = 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [self startTimer];
    } else {
        self.collectionView.scrollEnabled = NO;
    }
}


//转换Index
- (void)setCurrentRealityIndex:(NSInteger)currentRealityIndex {
    if (_currentRealityIndex == currentRealityIndex) {
        return;
    }
    _currentRealityIndex = currentRealityIndex;
    if (currentRealityIndex == 0) {
        self.currentLogicIndex = self.logicCount - 1;
    } else if (currentRealityIndex == self.circleArray.count - 1) {
        self.currentLogicIndex = 0;
    } else {
        self.currentLogicIndex = currentRealityIndex - 1;
    }
//    NSLog(@"!!---> login index:%zd", self.currentLogicIndex);
}

- (void)setCurrentLogicIndex:(NSInteger)currentLogicIndex {
    _currentLogicIndex = currentLogicIndex;
    self.pageControl.currentPage = currentLogicIndex;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.circleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AGPageCircleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PageCircleCellID forIndexPath:indexPath];
    cell.imageName = self.circleArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"!!---> logic index:%zd", self.currentLogicIndex);
    if (self.clickOperationBlock) {
        self.clickOperationBlock(self.currentLogicIndex);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageCircleView:didClickIndex:)]) {
        [self.delegate pageCircleView:self didClickIndex:self.currentLogicIndex];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.currentRealityIndex = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentRealityIndex = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    NSLog(@"--!!---> currentRealityIndex:%zd", self.currentRealityIndex);
    if (self.currentRealityIndex == 0) { //偏移到最后一张
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.circleArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else if (self.currentRealityIndex == self.circleArray.count - 1) { //偏移到第一张
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.currentRealityIndex = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    NSLog(@"--!!--->end Animation currentRealityIndex:%zd", self.currentRealityIndex);
    if (self.currentRealityIndex == 0) { //偏移到最后一张
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.circleArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    } else if (self.currentRealityIndex == self.circleArray.count - 1) { //偏移到第一张
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

- (void)startTimer {
    if (self.circleArray.count <= 1) return;
    if (self.timer) [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.pageTime target:self selector:@selector(automaticChangePage) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - System
- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    _flowLayout.itemSize = self.bounds.size;
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 20, CGRectGetWidth(self.bounds), 20);
}

- (void)dealloc {
    [self stopTimer];
}

@end

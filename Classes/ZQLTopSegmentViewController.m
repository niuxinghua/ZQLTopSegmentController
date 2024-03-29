//
//  ZQLTopSegmentViewController.m
//  ZQLTopSegmentController
//
//  Created by 臧其龙 on 15/12/20.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "ZQLTopSegmentViewController.h"
#import "TopSegmentManager.h"
#import "ContentCollectionViewManager.h"
#import "Masonry.h"

typedef NS_ENUM(NSInteger, ZQLCollectionViewType) {
    ZQLCollectionViewTypeTop,
    ZQLCollectionViewTypeContent
};

static CGFloat const kTopSegmentBarHeight = 44.0f;
static CGFloat const kTopCollectionViewHeight = 42.0f;
static CGFloat const kHorizontalLineHeight = 2.0f;

@interface ZQLTopSegmentViewController ()<TopSegmentManagerDelegate>
{
    UICollectionView *topSegmentCollectionView;;
    UICollectionView *contentCollectionView;
    
    UICollectionViewFlowLayout *topCollectionViewLayout;
    UICollectionViewFlowLayout *contentCollectionViewLayout;
    
    UIView *topBarView;
    UIView *horizontalLineView;
    
    TopSegmentManager *topManager;
    ContentCollectionViewManager *contentManager;
    
    NSArray *_imageArray;
    NSArray *_viewControllerArray;
    
    CGFloat screenWidth;
    CGFloat lineWidth;
}

@end

@implementation ZQLTopSegmentViewController

#pragma mark - Life Cycle

- (id)initWithTopIcons:(NSArray<UIImage *> *)imageArray WithViewController:(NSArray<UIViewController *> *)controllerArray
{
    if (self = [super init]) {
        screenWidth = [UIScreen mainScreen].bounds.size.width;
        lineWidth = screenWidth/controllerArray.count;
        _imageArray = imageArray;
        _viewControllerArray = controllerArray;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化顶部collectionview
    topCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    topSegmentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:topCollectionViewLayout];
    topSegmentCollectionView.scrollEnabled = NO;
    topSegmentCollectionView.backgroundColor = [UIColor whiteColor];
    topManager = [[TopSegmentManager alloc] initWithImageArray:_imageArray withCollectionView:topSegmentCollectionView];
    topManager.delegate = self;
    
    contentCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    contentCollectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    contentCollectionViewLayout.minimumInteritemSpacing = 0;
    contentCollectionViewLayout.minimumLineSpacing = 0;
    
    contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:contentCollectionViewLayout];
    contentCollectionView.pagingEnabled = YES;
    
    contentCollectionView.backgroundColor = [UIColor blueColor];
    contentManager = [[ContentCollectionViewManager alloc] initWithImageArray:_viewControllerArray withCollectionView:contentCollectionView];
    
    topBarView = [UIView new];
    topBarView.backgroundColor = [UIColor whiteColor];
    horizontalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopSegmentBarHeight - kHorizontalLineHeight, lineWidth, kHorizontalLineHeight)];
    horizontalLineView.backgroundColor = [UIColor redColor];
    
    [topBarView addSubview:topSegmentCollectionView];
    [topBarView addSubview:horizontalLineView];
    [self.view addSubview:contentCollectionView];
    [self.view addSubview:topBarView];
    
    [self setupConstraint];
    
//    [topSegmentCollectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [contentCollectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [contentCollectionView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [topSegmentCollectionView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}

#pragma mark - Setup UI

- (void)setupConstraint
{
    [topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@(kTopSegmentBarHeight));
    }];
    
    [topSegmentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBarView.mas_top).with.offset(0);
        make.left.equalTo(topBarView.mas_left).with.offset(0);
        make.right.equalTo(topBarView.mas_right).with.offset(0);
        make.height.equalTo(@(kTopCollectionViewHeight));
    }];
    
    [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBarView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).with.offset(0);
    }];
    
}

#pragma mark - KVO for contentOffset

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == contentCollectionView && [keyPath isEqualToString:@"contentOffset"]) {
        CGFloat scrollDistance = contentCollectionView.contentOffset.x/screenWidth * lineWidth;
        horizontalLineView.frame = CGRectMake(scrollDistance, CGRectGetMinY(horizontalLineView.frame), lineWidth, kTopSegmentBarHeight - kTopCollectionViewHeight);
    }
}

#pragma mark - StatusBar Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - TopManager Delegate

- (void)segmentCollectionViewCellDidSelect:(NSInteger)itemIndex
{
    [contentCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
   // [self horizonalViewScrollToIndex:itemIndex];
}

#pragma mark - Private Method

- (void)horizonalViewScrollToIndex:(NSInteger)itemIndex
{
    
    [UIView animateWithDuration:0.25 animations:^{
        horizontalLineView.frame = CGRectMake(lineWidth * itemIndex, CGRectGetMinY(horizontalLineView.frame), lineWidth, kTopSegmentBarHeight - kTopCollectionViewHeight);
    }];
}

@end

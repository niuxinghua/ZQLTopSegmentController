//
//  ContentCollectionViewManager.m
//  ZQLTopSegmentController
//
//  Created by 臧其龙 on 15/12/21.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import "ContentCollectionViewManager.h"
#import "ContentCollectionViewCell.h"

static NSString * const kContentCollectionViewCellID = @"kContentCollectionViewCellID";

@interface ContentCollectionViewManager ()
{
    NSArray *_controllerArray;
    UICollectionView *_collectionView;
}


@end

@implementation ContentCollectionViewManager

- (id)initWithImageArray:(NSArray<UIViewController *> *)controllerArray
      withCollectionView:(UICollectionView *)collectionView
{
    if (self = [super init]) {
        _controllerArray = controllerArray;
        _collectionView = collectionView;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(ContentCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:kContentCollectionViewCellID];
        [_collectionView reloadData];
    }
    return self;
}

#pragma mark - CollectionView Delegate && DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _controllerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCollectionViewCellID forIndexPath:indexPath];
    
    UIViewController *vc = _controllerArray[indexPath.row];
    [cell.contentView addSubview:vc.view];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _collectionView.bounds.size;
}

@end

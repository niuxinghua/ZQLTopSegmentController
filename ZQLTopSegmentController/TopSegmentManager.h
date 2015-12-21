//
//  TopSegmentManager.h
//  ZQLTopSegmentController
//
//  Created by 臧其龙 on 15/12/20.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TopSegmentManagerDelegate <NSObject>

- (void)segmentCollectionViewCellDidSelect:(NSInteger)itemIndex;

@end

@interface TopSegmentManager : NSObject<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<TopSegmentManagerDelegate> delegate;

- (id)initWithImageArray:(NSArray<UIImage *> *)imageArray
      withCollectionView:(UICollectionView *)collectionView;

@end

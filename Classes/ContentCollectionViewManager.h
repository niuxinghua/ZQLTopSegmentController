//
//  ContentCollectionViewManager.h
//  ZQLTopSegmentController
//
//  Created by 臧其龙 on 15/12/21.
//  Copyright © 2015年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContentCollectionViewManager : NSObject<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (id)initWithImageArray:(NSArray<UIViewController *> *)controllerArray
      withCollectionView:(UICollectionView *)collectionView;

@end

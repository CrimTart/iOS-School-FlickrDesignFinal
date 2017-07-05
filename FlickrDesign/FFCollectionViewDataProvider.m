//
//  FFCollectionViewDataProvider.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFCollectionViewDataProvider.h"
#import "FFCollectionViewCell.h"

@interface FFCollectionViewDataProvider()

@property (nonatomic, weak, readonly) id<FFCollectionModelProtocol> model;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation FFCollectionViewDataProvider

-(instancetype) initWithCollectionView: (UICollectionView *)collectionView model: (id<FFCollectionModelProtocol>)model {
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _model = model;
    }
    return self;
}

-(UICollectionViewCell *) collectionView: (UICollectionView *)collectionView cellForItemAtIndexPath: (NSIndexPath *)indexPath {
    FFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FFCollectionViewCell class]) forIndexPath:indexPath];
    UIImage *image = [self.model imageForIndex:indexPath.item];
    if (!image) {
        cell.activityIndicator.hidden = NO;
        [cell.activityIndicator startAnimating];
        if (!self.collectionView.dragging && !self.collectionView.decelerating) {
            [self loadImageForIndexPath:indexPath];
        }
    }
    else {
        cell.imageView.image = image;
    }
    return cell;
}

-(NSInteger) numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView: (UICollectionView *)collectionView numberOfItemsInSection: (NSInteger)section {
    return [self.model numberOfItems];
}

-(void) loadImageForIndexPath: (NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    [self.model loadImageForIndex:indexPath.item withCompletionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            FFCollectionViewCell *cell = ((FFCollectionViewCell *)([self.collectionView cellForItemAtIndexPath:indexPath]));
            [cell.activityIndicator stopAnimating];
            UIImage *image = [strongSelf.model imageForIndex:indexPath.item];
            cell.imageView.image = image;
        });
    }];
}

@end

//
//  FFCollectionViewDataProvider.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "FFCollectionModelProtocol.h"

@class FFSearchResultsModel;

@interface FFCollectionViewDataProvider : NSObject <UICollectionViewDataSource, UIScrollViewDelegate>

-(instancetype) initWithCollectionView: (UICollectionView *)collectionView model: (id<FFCollectionModelProtocol>)model;
-(void) loadImageForIndexPath: (NSIndexPath *)indexPath;

@end

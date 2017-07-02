//
//  FFCollectionViewLayout.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFCollectionLayoutDelegate <NSObject>

-(NSUInteger) numberOfItems;

@end

@interface FFCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<FFCollectionLayoutDelegate> delegate;

+(instancetype) new NS_UNAVAILABLE;
-(instancetype) init NS_UNAVAILABLE;
-(instancetype) initWithDelegate: (id<FFCollectionLayoutDelegate>)delegate;

@end

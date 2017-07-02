//
//  FFCollectionViewCell.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *indexLabel;

@end

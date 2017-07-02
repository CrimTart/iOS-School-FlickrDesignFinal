//
//  FFCollectionViewCell.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFCollectionViewCell.h"

@implementation FFCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect frame = self.contentView.frame;
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        self.backgroundColor = [UIColor lightGrayColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2, 80, 40)];
        _indexLabel.textColor = [UIColor redColor];
        _indexLabel.font = [UIFont fontWithName:@"Helvetica" size:36];
        [self.contentView addSubview:_indexLabel];
        
        _activityIndicator = [UIActivityIndicatorView new];
        [self.contentView addSubview:_activityIndicator];
        _activityIndicator.hidesWhenStopped = YES;
        _activityIndicator.center = CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2);
        [_activityIndicator setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    }
    return self;
}

- (void)prepareForReuse {
    self.imageView.image = nil;
    self.activityIndicator.hidden = YES;
    self.activityIndicator.center = self.contentView.center;
    self.indexLabel.text = nil;
}

@end

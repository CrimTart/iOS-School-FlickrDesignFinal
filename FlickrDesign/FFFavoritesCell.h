//
//  FFFavoritesCell.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFFavoritesCell : UITableViewCell

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *descriptionText;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

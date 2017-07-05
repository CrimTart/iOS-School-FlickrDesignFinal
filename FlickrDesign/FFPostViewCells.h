//
//  FFPostViewCells.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FFCellsDelegate <NSObject>

-(void) showImageForCell: (UITableViewCell *)cell;

@end

@interface FFImageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *descriptionText;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, weak) id<FFCellsDelegate> delegate;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinch;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

-(void) addGestures;
-(void) removeGestures;

@end


@interface FFLikesCell : UITableViewCell

@property (nonatomic, strong) UIImageView *likesImageView;
@property (nonatomic, strong) UIImageView *commentsImageView;
@property (nonatomic, strong) UILabel *likesLabel;
@property (nonatomic, strong) UILabel *commentsLabel;

@end


@interface FFCommentsCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *eventLabel;

@end

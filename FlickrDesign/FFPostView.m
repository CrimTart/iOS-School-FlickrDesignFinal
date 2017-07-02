//
//  FFPostView.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFPostView.h"
#import "UIFont+FFFonts.h"
#import "Masonry.h"

@implementation FFPostView

+(UIView *) configureNavigationBar {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    UIImageView *avatarView = [UIImageView new];
    avatarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:170/255.0 alpha:0.5];
    avatarView.layer.cornerRadius = 16;
    avatarView.clipsToBounds = YES;
    [avatarView setAutoresizesSubviews:YES];
    [view addSubview:avatarView];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont sanFranciscoDisplayMedium14];
    [view addSubview:nameLabel];
    
    UIImageView *locationSign = [UIImageView new];
    locationSign.image = [UIImage imageNamed:@"location"];
    [view addSubview:locationSign];
    UILabel *locationLabel = [UILabel new];
    locationLabel.font = [UIFont sanFranciscoDisplayMedium13];
    locationLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    [view addSubview:locationLabel];
    
    nameLabel.text = @"Mario";
    locationLabel.text = @"Royal Castle, Mushroom Kingdom";
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.centerY.equalTo(view.mas_centerY);
        make.size.equalTo(@32);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarView.mas_right).with.offset(16);
        make.top.equalTo(avatarView.mas_top).with.offset(1);
        make.height.equalTo(@16);
    }];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avatarView.mas_right).with.offset(28);
        make.top.equalTo(nameLabel.mas_bottom).with.offset(3);
        make.height.equalTo(@15);
    }];
    [locationSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).with.offset(6);
        make.width.equalTo(@8);
        make.height.equalTo(@10);
    }];
    return view;
}

@end

//
//  FFPostView.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFPostView.h"
#import "Masonry.h"

@implementation FFPostView

+(instancetype) new {
    return [[FFPostView alloc] init];
}

-(instancetype) init {
    self = [super init];
    if (self) {
        [self configureNavigationBar];
    }
    return self;
}

-(FFPostView *) configureNavigationBar {
    self.avatarView = [UIImageView new];
    self.avatarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:170/255.0 alpha:0.5];
    self.avatarView.layer.cornerRadius = 16;
    self.avatarView.clipsToBounds = YES;
    [self.avatarView setAutoresizesSubviews:YES];
    [self addSubview:self.avatarView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.nameLabel];
    
    UIImageView *locationSign = [UIImageView new];
    locationSign.image = [UIImage imageNamed:@"location"];
    [self addSubview:locationSign];
    self.locationLabel = [UILabel new];
    self.locationLabel.font = [UIFont systemFontOfSize:13];
    self.locationLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    [self addSubview:self.locationLabel];
    
    self.nameLabel.text = @"";
    self.locationLabel.text = @"";
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
        make.size.equalTo(@32);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).with.offset(16);
        make.top.equalTo(self.avatarView.mas_top).with.offset(1);
        make.height.equalTo(@16);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).with.offset(28);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(3);
        make.height.equalTo(@15);
    }];
    [locationSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(6);
        make.width.equalTo(@8);
        make.height.equalTo(@10);
    }];
    return self;
}

@end

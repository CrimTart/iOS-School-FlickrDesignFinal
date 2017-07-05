//
//  FFFavoritesCell.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFFavoritesCell.h"
#import "Masonry.h"

@implementation FFFavoritesCell

+(BOOL) requiresConstraintBasedLayout {
    return YES;
}

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
        _photoView = [UIImageView new];
        [_photoView setAutoresizingMask:YES];
        _photoView.clipsToBounds = YES;
        _photoView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_photoView];
        
        _descriptionText = [UILabel new];
        [self.contentView addSubview:_descriptionText];
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.hidesWhenStopped = YES;
        [self.contentView addSubview:_spinner];
    }
    return self;
}

-(void) updateConstraints {
    UIView *contentView = self.contentView;
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top);
        make.left.equalTo(contentView.mas_left).with.offset(1);
        make.right.equalTo(contentView.mas_right).with.offset(-1);
        make.height.equalTo(@248);
    }];
    [_descriptionText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_photoView.mas_bottom).with.offset(12);
        make.left.equalTo(contentView.mas_left).with.offset(16);
        make.right.equalTo(contentView.mas_right).with.offset(-16);
        make.bottom.equalTo(contentView.mas_bottom).with.offset(-12);
    }];
    [_spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_photoView.mas_centerX);
        make.centerY.equalTo(_photoView.mas_centerY);
    }];
    [super updateConstraints];
}

-(void) prepareForReuse {
    self.photoView.image = nil;
    self.descriptionText.text = nil;
}

@end

//
//  FFPostViewCells.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFPostViewCells.h"
#import "Masonry.h"


#pragma mark - FFImageCell

@implementation FFImageCell

+(BOOL) requiresConstraintBasedLayout {
    return YES;
}

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
        _photoView = [UIImageView new];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        [_photoView setAutoresizingMask:YES];
        _photoView.clipsToBounds = YES;
        [self.contentView addSubview:_photoView];
        
        _descriptionText = [UILabel new];
        [self.contentView addSubview:_descriptionText];
        
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _spinner.hidesWhenStopped = YES;
        [self.contentView addSubview:_spinner];
        
        [self addGestures];
    }
    return self;
}

-(void) removeGestures {
    [self.contentView removeGestureRecognizer:self.pinch];
    [self.contentView removeGestureRecognizer:self.tap];
}

-(void) addGestures {
    self.contentView.userInteractionEnabled = YES;
    _pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.contentView addGestureRecognizer:_pinch];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    _tap.numberOfTapsRequired = 2;
    [self.contentView addGestureRecognizer:_tap];
}

-(IBAction) pinch: (UIGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded) {
        [self.delegate showImageForCell:self];
        [self removeGestures];
    }
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


#pragma mark - FFLikesFooter

@implementation FFLikesFooter

+(BOOL) requiresConstraintBasedLayout {
    return YES;
}

-(instancetype) initWithFrame: (CGRect)frame {
    self.opaque = YES;
    self = [super initWithFrame:frame];
    if (self) {
        _likesImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart"]];
        [self addSubview:_likesImageView];
        _likesLabel = [UILabel new];
        [self addSubview:_likesLabel];
        
        _commentsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment"]];
        [self addSubview:_commentsImageView];
        _commentsLabel = [UILabel new];
        [self addSubview:_commentsLabel];
    }
    return self;
}

-(void) updateConstraints {
    [_likesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(16);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_likesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_likesImageView.mas_right).with.offset(7.1);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_commentsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(122.3);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_commentsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_commentsImageView.mas_right).with.offset(6);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [super updateConstraints];
}

@end


#pragma mark - FFCommentsCell

@implementation FFCommentsCell

+(BOOL) requiresConstraintBasedLayout {
    return YES;
}

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
        _avatarImageView = [UIImageView new];
        _avatarImageView.backgroundColor = [UIColor blueColor];
        [_avatarImageView setAutoresizingMask:YES];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = 38 / 2;
        [self.contentView addSubview:_avatarImageView];
        
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:14];
        [self.contentView addSubview:_nameLabel];
        
        _eventLabel = [UILabel new];
        _eventLabel.textColor = [UIColor grayColor];
        _eventLabel.font = [UIFont fontWithName:@"SanFranciscoDisplay-Medium" size:13];
        [self.contentView addSubview:_eventLabel];
    }
    return self;
}

-(void) updateConstraints {
    UIView *contentView = self.contentView;
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(11);
        make.size.equalTo(@38);
        make.left.equalTo(contentView.mas_left).with.offset(16);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImageView.mas_right).with.offset(8);
        make.top.equalTo(contentView.mas_top).with.offset(14);
        make.right.equalTo(contentView.mas_right).with.offset(8);
    }];
    [_eventLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatarImageView.mas_right).with.offset(8);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(1);
        make.right.equalTo(contentView.mas_right).with.offset(8);
        make.height.equalTo(@16);
    }];
    
    [super updateConstraints];
}

-(void) prepareForReuse {
    
}

@end

//
//  FFPostDataProvider.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFPostDataProvider.h"
#import "FFPostViewCells.h"
#import "FFItem.h"
#import "Comment.h"
#import "Human.h"

@interface FFPostDataProvider ()

@property (nonatomic, weak, readonly) id<FFPostModelProtocol> model;
@property (nonatomic, weak, readonly) id<UITableViewDelegate, FFCellsDelegate> controller;

@end

@implementation FFPostDataProvider

-(instancetype) initWithModel: (id<FFPostModelProtocol>)model andController: (id<UITableViewDelegate, FFCellsDelegate>)controller {
    self = [super init];
    if (self) {
        _model = model;
        _controller = controller;
    }
    return self;
}

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    switch (section) {
        case 0: {
            return 1;
            break;
        }
        case 1: {
            FFItem *selectedItem = [self.model getSelectedItem];
            NSUInteger numberOfRows = selectedItem.comments.count;
            return numberOfRows;
            break;
        }
        default:
            return 1;
            break;
    }
}

-(UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    UITableViewCell *cell = [self configureCellForTableView:tableView atIndexPath:indexPath];
    return cell;
}

-(UITableViewCell *) configureCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) return [self imageCellForTableView:tableView atIndexPath:indexPath];
            if (indexPath.row == 1) return [self likesCellForTableView:tableView atIndexPath:indexPath];
            break;
        }
        case 1: {
            return [self commentsCellForTableView:tableView atIndexPath:indexPath];
            break;
        }
        default:
            break;
    }
    return nil;
}

-(FFImageCell *) imageCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath {
    FFImageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FFImageCell class])];
    cell.delegate = self.controller;
    FFItem *selectedItem = [self.model getSelectedItem];
    NSString *destinationPath = [NSHomeDirectory() stringByAppendingPathComponent:selectedItem.largePhoto];
    UIImage *image = [UIImage imageWithContentsOfFile:destinationPath];
    if (!image) {
        cell.spinner.hidden = NO;
        [cell.spinner startAnimating];
        __weak typeof(self) weakSelf = self;
        [self.model loadImageForItem:selectedItem withCompletionHandler:^{
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    FFImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                    NSString *destinationPath = [NSHomeDirectory() stringByAppendingPathComponent:selectedItem.largePhoto];
                    cell.photoView.image = [UIImage imageWithContentsOfFile:destinationPath];
                    [cell.spinner stopAnimating];
                });
            }
        }];
    }
    else {
        cell.photoView.image = image;
    }
    cell.descriptionText.text = selectedItem.text ? [NSString stringWithCString:[selectedItem.text cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] : @" ";
    return cell;
}

-(FFLikesCell *) likesCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath {
    FFLikesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FFLikesCell class])];
    FFItem *selectedItem = [self.model getSelectedItem];
    NSString *numberOfLikes = selectedItem.numberOfLikes;
    if (!numberOfLikes) numberOfLikes = @" ";
    cell.likesLabel.text = [NSString stringWithFormat:@"%@ лайков", numberOfLikes];
    NSString *numberOfComments = selectedItem.numberOfComments;
    if (!numberOfComments) numberOfComments = @" ";
    cell.commentsLabel.text = [NSString stringWithFormat:@"%@ комментариев", numberOfComments];
    return cell;
}

-(FFCommentsCell *) commentsCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath {
    FFCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FFCommentsCell class])];
    FFItem *item = [self.model getSelectedItem];
    Comment *currentComment = item.commentsArray[indexPath.row];
    Human *author = currentComment.author;
    cell.nameLabel.text = author.name ? [NSString stringWithCString:[author.name cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] : @" ";
    NSString *text = currentComment.text ? [NSString stringWithCString:[currentComment.text cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] : @" ";
    cell.eventLabel.attributedText = [self decorateText:text ofType:[currentComment.commentType integerValue]];
    UIImage *avatar = author.avatar;
    if (!avatar) {
        [author getAvatarWithNetworkService:self.model.networkManager storageService:self.model.storageService completionHandler:^(UIImage *avatar) {
            dispatch_async(dispatch_get_main_queue(), ^{
                FFCommentsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.avatarImageView.image = avatar;
            });
        }];
    } else {
        cell.avatarImageView.image = avatar;
    }
    [cell layoutIfNeeded];
    return cell;
}

-(NSAttributedString *) decorateText: (NSString *)text ofType: (FFCommentType)type {
    NSMutableAttributedString *attributedString;
    switch (type) {
        case FFCommentTypeComment: {
            NSString *introduction = @"прокоментировал фото:\n";
            NSUInteger introductionLength = [[introduction precomposedStringWithCanonicalMapping] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
            NSUInteger textLength = [[text precomposedStringWithCanonicalMapping] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
            NSString *textWithIntroduction = [introduction stringByAppendingString:text];
            attributedString = [[NSMutableAttributedString alloc] initWithString:textWithIntroduction];
            NSRange coloredRange = NSMakeRange(introductionLength, textLength);
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:40.0f / 255.0f green:171.0f / 255.0f blue:236.0f / 255.0f alpha:1.0f] range:coloredRange];
            break;
        }
        case FFCommentTypeLike: {
            attributedString = [[NSMutableAttributedString alloc] initWithString:text];
            if (text.length > 6) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f / 255.0f green:38.0f / 255.0f blue:70.0f / 255.0f alpha:1.0f] range:NSMakeRange(0, 6)];
            }
            break;
        }
    }
    return attributedString;
}

@end

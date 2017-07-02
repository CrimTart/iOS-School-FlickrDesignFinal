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

#pragma mark - TableView

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return 2;
}

-(NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    switch (section) {
        case 0: {
            return 1;
            break;
        } case 1: {
            return 3;
            break;
        } default:
            return 1;
            break;
    }
}

#pragma mark - cellForRowAtIndexPath

-(UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    UITableViewCell *cell = [self configureCellForTableView:tableView atIndexPath:indexPath];
    return cell;
}

-(UITableViewCell *) configureCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            return [self imageCellForTableView:tableView atIndexPath:indexPath];
            break;
        } case 1: {
            FFCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentsCell"];
            cell.nameLabel.text = @"Mario";
            cell.eventLabel.text = @"liked photo";
            return cell;
            break;
        } default:
            break;
    }
    return nil;
}

-(FFImageCell *) imageCellForTableView: (UITableView *)tableView atIndexPath: (NSIndexPath *)indexPath {
    FFImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
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
    } else {
        cell.photoView.image = image;
    }
    cell.descriptionText.text = selectedItem.text;
    return cell;
}

@end

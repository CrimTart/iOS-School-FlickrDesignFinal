//
//  FFPostController.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFPostController.h"
#import "FFPostDataProvider.h"
#import "FFPostViewCells.h"
#import "FFItem.h"
#import "FFCollectionModel.h"
#import "FFPostView.h"
#import "Masonry.h"

@interface FFPostController () <UITableViewDelegate, FFCellsDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong, readonly) id<FFPostModelProtocol> model;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIScrollView *zoomedImageView;
@property (nonatomic, weak) FFImageCell *imageCell;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) FFPostDataProvider *provider;

@end

@implementation FFPostController

-(instancetype) initWithModel: (id<FFPostModelProtocol>)model {
    self = [super init];
    if (self) {
        _model = model;
        _provider = [[FFPostDataProvider alloc] initWithModel:model andController:self];
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithCustomView:[FFPostView configureNavigationBar]];
    [self.navigationItem setLeftBarButtonItem:bbi];
    self.navigationItem.leftItemsSupplementBackButton = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToFavorites:)];
    
    CGRect frame = self.view.frame;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    self.tableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
    self.tableView.separatorColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[FFImageCell class] forCellReuseIdentifier:@"imageCell"];
    [self.tableView registerClass:[FFCommentsCell class] forCellReuseIdentifier:@"commentsCell"];
    self.tableView.allowsSelection = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self.provider;
}

-(UIView *) tableView: (UITableView *)tableView viewForFooterInSection: (NSInteger)section {
    if (section == 0) {
        FFLikesFooter *footer = [FFLikesFooter new];
        NSUInteger likes = 16; NSUInteger comments = 5;
        footer.likesLabel.text = [NSString stringWithFormat:@"%lu лайков", likes];
        footer.commentsLabel.text = [NSString stringWithFormat:@"%lu комментариев", comments];
        return footer;
    }
    return [UITableViewHeaderFooterView new];
}

-(void) tableView: (UITableView *)tableView willDisplayFooterView: (UIView *)view forSection: (NSInteger)section {
    view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
}

-(CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 312;
    } else {
        return 60;
    }
}

-(CGFloat) tableView: (UITableView *)tableView heightForFooterInSection: (NSInteger)section {
    if (section == 0) {
        return 60;
    } else {
        return 0;
    }
}

-(IBAction) addToFavorites: (id)sender {
    [self.model makeFavorite:YES];
}

#pragma mark - FFCellsDelegate

-(void) showImageForCell: (FFImageCell *)cell {
    self.imageCell = cell;
    self.imageView = [[UIImageView alloc] initWithImage:cell.photoView.image];
    self.zoomedImageView = [[UIScrollView alloc] initWithFrame:self.tableView.frame];
    self.zoomedImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [self.zoomedImageView addSubview:self.imageView];
    self.imageView.center = self.zoomedImageView.center;
    [self.view addSubview:self.zoomedImageView];
    self.zoomedImageView.scrollEnabled = YES;
    self.zoomedImageView.userInteractionEnabled = YES;
    self.zoomedImageView.delegate = self;
    self.zoomedImageView.maximumZoomScale = 4;
    self.zoomedImageView.minimumZoomScale = 0.5;
    [self.zoomedImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)]];
}

-(UIView *) viewForZoomingInScrollView: (UIScrollView *)scrollView {
    return self.imageView;
}

-(IBAction) zoomIn: (id)sender {
    self.zoomedImageView.zoomScale = 2;
}

-(IBAction) hideImage: (id)sender {
    self.zoomedImageView.layer.opacity = 0;
    self.zoomedImageView.hidden = YES;
    [self.imageCell addGestures];
}

@end

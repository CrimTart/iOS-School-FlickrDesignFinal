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
#import "Human.h"
#import "Comment.h"
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
@property (nonatomic, strong) FFPostView *postView;

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

/*-(void) viewDidLoad {
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
}*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    [self configureLeftBarButtonItem];
    [self configureTableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToFavorites:)];
}

-(void) viewWillAppear: (BOOL)animated {
    [super viewWillAppear:animated];
    FFItem *selectedItem = [self.model getSelectedItem];
    if (!selectedItem.author) {
        __weak typeof(self)weakSelf = self;
        [self.model getMetadataForSelectedItemWithCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf configureLeftBarButtonItem];
                [weakSelf.tableView reloadData];
            });
        }];
    } else {
        [self.tableView reloadData];
    }
}

-(void) configureLeftBarButtonItem {
    self.postView = [FFPostView new];
    FFItem *selectedItem = [self.model getSelectedItem];
    Human *author = selectedItem.author;
    UIImage *avatar = author.avatar;
    if (!avatar) {
        __weak typeof(self)weakSelf = self;
        [author getAvatarWithNetworkService:self.model.networkManager storageService:self.model.storageService completionHandler:^(UIImage *avatar) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf configureLeftBarButtonItem];
                [self.tableView reloadData];
            });
        }];
    }
    else {
        self.postView.avatarView.image = avatar;
    }
    self.postView.nameLabel.text = selectedItem.author.name ? [NSString stringWithCString:[selectedItem.author.name cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding] : @" ";
    if (selectedItem.location) self.postView.locationLabel.text = [NSString stringWithCString:[selectedItem.location cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.postView];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    self.navigationItem.leftItemsSupplementBackButton = YES;
}

-(void) configureTableView {
    CGRect frame = self.view.frame;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    self.tableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
    self.tableView.separatorColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    [self.tableView registerClass:[FFImageCell class] forCellReuseIdentifier:NSStringFromClass([FFImageCell class])];
    [self.tableView registerClass:[FFCommentsCell class] forCellReuseIdentifier:NSStringFromClass([FFCommentsCell class])];
    [self.tableView registerClass:[FFLikesCell class] forCellReuseIdentifier:NSStringFromClass([FFLikesCell class])];
    self.tableView.allowsSelection = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self.provider;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
}

-(CGFloat) tableView: (UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 313.0;
        }
        else return 57.5;
    }
    else return 76.0;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
        view.backgroundColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
        view.layer.borderWidth = 0;
        view.layer.borderColor = view.backgroundColor.CGColor;
        return view;
    } else {
        return nil;
    }
}

-(CGFloat) tableView: (UITableView *)tableView  heightForFooterInSection: (NSInteger)section {
    if (section == 0) return 0.5;
    else return 0;
}

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

-(IBAction) addToFavorites: (id)sender {
    [self.model makeFavorite:YES];
}

@end

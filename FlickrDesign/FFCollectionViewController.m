//
//  FFCollectionViewController.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFCollectionViewController.h"
#import "FFCollectionViewDataProvider.h"
#import "FFCollectionNavigationBar.h"
#import "FFCollectionViewCell.h"
#import "FFCollectionViewLayout.h"

#import "FFSettingsViewController.h"
#import "FFPostController.h"
#import "FFPostModel.h"

@interface FFCollectionViewController () <UISearchBarDelegate, UICollectionViewDelegate, FFCollectionLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) FFCollectionViewDataProvider *dataProvider;
@property (nonatomic, strong, readonly) id<FFCollectionModelProtocol> model;
@property (nonatomic, strong) FFCollectionViewLayout *layout;
@property (nonatomic, strong) FFCollectionNavigationBar *navBar;

@end

@implementation FFCollectionViewController

-(instancetype) initWithModel: (id<FFCollectionModelProtocol>)model {
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"icFeed"];
    UITabBarItem *tab = [[UITabBarItem alloc] initWithTitle:@"Лента" image:image tag:0];
    self.tabBarItem = tab;
    
    [self createCollectionView];
    self.dataProvider = [[FFCollectionViewDataProvider alloc] initWithCollectionView:self.collectionView model:self.model];
    self.collectionView.dataSource = self.dataProvider;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
    self.navBar = [[FFCollectionNavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44)];
    self.navigationItem.titleView = self.navBar;
    self.navBar.searchBar.delegate = self;
    [self.navBar.settingsButton addTarget:self action:@selector(gotoSettings:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) viewWillAppear: (BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

-(void) viewDidAppear: (BOOL)animated {
    [super viewDidAppear:YES];
    [self firstStart];
}

-(void) viewWillDisappear: (BOOL)animated {
    [super viewWillDisappear:animated];
    [self.model pauseDownloads];
}

-(void) createCollectionView {
    self.layout = [[FFCollectionViewLayout alloc] initWithDelegate:self];
    CGRect frame = self.view.frame;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
    [self.collectionView registerClass:[FFCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FFCollectionViewCell class])];
    [self.view addSubview:_collectionView];
    self.collectionView.delegate = self;
}

-(void) firstStart {
    NSString *searchRequest = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchRequest"];
    if (searchRequest) {
        self.navBar.searchBar.text = searchRequest;
        [self.model firstStart:searchRequest withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }];
    }
    else {
        [self.navBar.searchBar becomeFirstResponder];
    }
}

-(void) searchBarSearchButtonClicked: (UISearchBar *)searchBar {
    [self.model clearModel];
    [self performSearch:searchBar];
}

-(void) performSearch: (UISearchBar *)searchBar {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"searchRequest"];
    NSString *searchRequest = searchBar.text;
    [[NSUserDefaults standardUserDefaults] setObject:searchRequest forKey:@"searchRequest"];
    [searchBar endEditing:YES];
    if (searchRequest) {
        __weak typeof(self) weakself = self;
        [self.model getItemsForRequest:searchRequest withCompletionHandler:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.collectionView reloadData];
            });
        }];
    }
}

-(void) collectionView: (UICollectionView *)collectionView didSelectItemAtIndexPath: (NSIndexPath *)indexPath {
    FFPostModel *postModel = [[FFPostModel alloc] initWithNetworkManager:self.model.networkManager storageService:self.model.storageService];
    FFItem *selectedItem = [self.model itemForIndex:indexPath.row];
    [postModel passSelectedItem:selectedItem];
    FFPostController *postViewController = [[FFPostController alloc] initWithModel:postModel];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:newBackButton];
    [self.navigationController pushViewController:postViewController animated:YES];
}

-(void) collectionView: (UICollectionView *)collectionView willDisplayCell: (UICollectionViewCell *)cell forItemAtIndexPath: (NSIndexPath *)indexPath {
    if (indexPath.item + 5 == [self.model numberOfItems]) {
        __weak typeof(self) weakself = self;
        [self.model getItemsForRequest:nil withCompletionHandler:^{
            [weakself.collectionView reloadData];
        }];
    }
}

-(NSUInteger) numberOfItems {
    return [self.model numberOfItems];
}

-(void) scrollViewDidEndDecelerating: (UIScrollView *)scrollView {
    [self loadImageForVisibleCells];
}

-(void) scrollViewDidEndDragging: (UIScrollView *)scrollView willDecelerate: (BOOL)decelerate {
    if (!decelerate) {
        [self loadImageForVisibleCells];
    }
}

-(void) loadImageForVisibleCells {
    NSArray *visibleCellsIndexPath = self.collectionView.indexPathsForVisibleItems;
    for (NSIndexPath *indexPath in visibleCellsIndexPath) {
        [self.dataProvider loadImageForIndexPath:indexPath];
    }
}

-(void) scrollViewWillBeginDragging: (UIScrollView *)scrollView {
    [self.model pauseDownloads];
}

-(IBAction) gotoSettings: (id)sender {
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:newBackButton];
    FFSettingsViewController *settingsViewController = [[FFSettingsViewController alloc] initWithStorage:self.model.storageService];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end

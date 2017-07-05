//
//  FFFavoritesViewController.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFFavoritesViewController.h"
#import "FFFavoritesCell.h"
#import "FFItem.h"
#import "FFFavoritesModel.h"

@interface FFFavoritesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong, readonly) FFFavoritesModel *model;

@end

@implementation FFFavoritesViewController

static NSString * const reuseID = @"favoritesCell";

-(instancetype) initWithModel: (FFFavoritesModel *)model {
    self = [super init];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"icLikes"];
        self.tabBarItem.title = @"Избранное";
        _model = model;
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Избранное";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 312;
    [self.tableView registerClass:[FFFavoritesCell class] forCellReuseIdentifier:reuseID];
}

-(void) viewWillAppear: (BOOL)animated {
    [super viewWillAppear:animated];
    [self.model getFavoriteItemsWithCompletionHandler:^(void) {
        [self.tableView reloadData];
    }];
}

-(UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    FFFavoritesCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    FFItem *currentItem = [self.model itemForIndex:indexPath.item];
    NSString *destinationPath = [NSHomeDirectory() stringByAppendingPathComponent:currentItem.largePhoto];
    UIImage *image = [UIImage imageWithContentsOfFile:destinationPath];
    cell.photoView.image = image;
    cell.descriptionText.text = currentItem.text;
    return cell;
}

-(NSInteger) numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return [self.model numberOfItems];
}

@end

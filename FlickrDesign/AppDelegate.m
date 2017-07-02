//
//  AppDelegate.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "AppDelegate.h"
#import "FFCollectionViewController.h"
#import "FFCollectionModel.h"
#import "FFFavoritesViewController.h"
#import "FFFavoritesModel.h"
#import "FFFacade.h"
#import "FFStorageService.h"
#import "FFNetworkManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FFFacade *facade = [[FFFacade alloc] initWithNetworkManager:[FFNetworkManager new] storageService:[FFStorageService new]];
    FFCollectionModel *collectionModel = [[FFCollectionModel alloc] initWithFacade:facade];
    FFCollectionViewController *collectionViewController = [[FFCollectionViewController alloc] initWithModel:collectionModel];
    FFFavoritesModel *favoritesModel = [[FFFavoritesModel alloc] initWithFacade:facade];
    FFFavoritesViewController *favoritesViewController = [[FFFavoritesViewController alloc] initWithModel:favoritesModel];
    
    UINavigationController *ncCollection = [[UINavigationController alloc] initWithRootViewController:collectionViewController];
    UINavigationController *ncFavourites = [[UINavigationController alloc] initWithRootViewController:favoritesViewController];
    
    UITabBarController *tabbarController = [UITabBarController new];
    tabbarController.viewControllers = @[ncCollection, ncFavourites];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end

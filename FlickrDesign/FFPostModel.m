//
//  FFPostModel.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFPostModel.h"
#import "FFItem.h"
#import "Human.h"
#import "Comment.h"
#import "FFImageDownloader.h"
#import "FFMetadataLoadOperation.h"
@import UIKit;

static NSString *const kItemEntity = @"FFItem";

@interface FFPostModel ()

@property (nonatomic, strong) FFItem *selectedItem;
@property (nonatomic, strong) FFImageDownloader *imageDownloader;

@end

@implementation FFPostModel

-(instancetype) initWithNetworkManager: (id<FFNetworkProtocol>)networkManager storageService: (id<FFStorageProtocol>)storageService {
    self = [super init];
    if (self) {
        _storageService = storageService;
        _networkManager = networkManager;
        _imageDownloader = [[FFImageDownloader alloc] initWithNetworkManager:_networkManager storageService:_storageService];
    }
    return self;
}

-(void) passSelectedItem: (FFItem *)selectedItem {
    self.selectedItem = selectedItem;
}

-(FFItem *) getSelectedItem {
    return self.selectedItem;
}

-(void) makeFavorite: (BOOL)favorite {
    self.selectedItem.isFavorite = favorite;
    [self.storageService save];
}

-(void) loadImageForItem: (FFItem *)item withCompletionHandler: (void (^)(void))completionHandler {
    [self.imageDownloader loadImageForEntity:kItemEntity withIdentifier:item.identifier forURL:item.largePhotoURL forAttribute:@"largePhoto" withCompletionHandler:completionHandler];
}

-(void) getMetadataForSelectedItemWithCompletionHandler:(voidBlock)completionHandler {
    FFMetadataLoadOperation *loadOperation = [[FFMetadataLoadOperation alloc] initWithItem:self.selectedItem storageService:self.storageService networkManager:self.networkManager];
    loadOperation.completionBlock = completionHandler;
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.qualityOfService = QOS_CLASS_DEFAULT;
    [queue addOperation:loadOperation];
}

@end

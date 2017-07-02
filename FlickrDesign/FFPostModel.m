//
//  FFPostModel.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

//Facade --- Both (loadimgforentity)

#import "FFPostModel.h"
#import "FFItem.h"
#import "FFStorageProtocol.h"
#import "FFNetworkProtocol.h"
#import "FFFacade.h"
@import UIKit;

static NSString *const kItemEntity = @"FFItem";

@interface FFPostModel ()

@property (nonatomic, strong, readonly) FFFacade *facade;
@property (nonatomic, strong) FFItem *selectedItem;
@property (nonatomic, strong, readonly) id<FFStorageProtocol> storageService;
@property (nonatomic, strong, readonly) id<FFNetworkProtocol> networkManager;

@end

@implementation FFPostModel

-(instancetype) initWithFacade: (FFFacade *)facade {
    self = [super init];
    if (self) {
        _facade = facade;
        _storageService = facade.storageService;
        _networkManager = facade.networkManager;
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
    [self.facade loadImageForEntity:kItemEntity withIdentifier:item.identifier forURL:item.largePhotoURL forAttribute:@"largePhoto" withCompletionHandler:completionHandler];
}

@end

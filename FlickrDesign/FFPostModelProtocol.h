//
//  FFPostModelProtocol.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFStorageProtocol.h"
#import "FFNetworkProtocol.h"

@class UIImage;
@class FFItem;
@class Human;

typedef void (^voidBlock)(void);

@protocol FFPostModelProtocol <NSObject>

@property (nonatomic, strong, readonly) id<FFStorageProtocol> storageService;
@property (nonatomic, strong, readonly) id<FFNetworkProtocol> networkManager;

-(void) makeFavorite: (BOOL)favorite;

-(void) passSelectedItem: (FFItem *)selectedItem;

-(FFItem *) getSelectedItem;

-(void) loadImageForItem: (FFItem *)item withCompletionHandler: (voidBlock)completionHandler;

-(void) getMetadataForSelectedItemWithCompletionHandler: (voidBlock)completionHandler;

@end

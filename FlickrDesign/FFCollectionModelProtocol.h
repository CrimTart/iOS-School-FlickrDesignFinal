//
//  FFCollectionModelProtocol.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFNetworkProtocol.h"
#import "FFStorageProtocol.h"

@class UIImage;
@class FFItem;

typedef void (^voidBlock)(void);

@protocol FFCollectionModelProtocol <NSObject>

-(NSUInteger) numberOfItems;

-(FFItem *) itemForIndex: (NSUInteger)index;

-(UIImage *)imageForIndex:(NSUInteger)index;

-(void) loadImageForIndex: (NSUInteger)index withCompletionHandler: (voidBlock)completionHandler;

-(void) getItemsForRequest: (NSString *)request withCompletionHandler: (voidBlock)completionHandler;

-(void) clearModel;

-(id<FFNetworkProtocol>) getNetworkManager;

-(id<FFStorageProtocol>) getStorageService;

-(void) pauseDownloads;

-(void) firstStart: (NSString *)searchRequest withCompletionHandler: (voidBlock)completionHandler;

@end

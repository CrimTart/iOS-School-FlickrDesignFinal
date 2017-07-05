//
//  FFCollectionModel.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFCollectionModelProtocol.h"
#import "FFStorageProtocol.h"
#import "FFNetworkProtocol.h"

@class FFItem;
@class NSManagedObjectContext;

@interface FFCollectionModel : NSObject <FFCollectionModelProtocol>

@property (nonatomic, strong, readonly) id<FFStorageProtocol> storageService;
@property (nonatomic, strong, readonly) id<FFNetworkProtocol> networkManager;

+(instancetype) new NS_UNAVAILABLE;
-(instancetype) init NS_UNAVAILABLE;
-(instancetype) initWithNetworkManager: (id<FFNetworkProtocol>)networkManager storageService: (id<FFStorageProtocol>)storageService;

@end

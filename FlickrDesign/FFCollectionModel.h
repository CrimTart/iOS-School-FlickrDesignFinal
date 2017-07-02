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

@class FFItem;
@class FFFacade;
@class NSManagedObjectContext;

@interface FFCollectionModel : NSObject <FFCollectionModelProtocol>

+(instancetype) new NS_UNAVAILABLE;
-(instancetype) init NS_UNAVAILABLE;
-(instancetype) initWithNetworkManager: (id<FFNetworkProtocol> *)networkManager AndStorageService: (id<FFStorageProtocol>)storageService;

@end

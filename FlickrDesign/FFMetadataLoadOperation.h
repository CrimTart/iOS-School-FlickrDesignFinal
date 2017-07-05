//
//  FFMetadataLoadOperation.h
//  FlickrDesign
//
//  Created by Admin on 05.07.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFStorageProtocol.h"
#import "FFNetworkProtocol.h"

@class FFItem;

@interface FFMetadataLoadOperation : NSOperation

-(instancetype) initWithItem: (FFItem *)item storageService: (id<FFStorageProtocol>)storageService networkManager: (id<FFNetworkProtocol>)networkManager;

@end

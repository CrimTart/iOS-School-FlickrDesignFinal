//
//  FFImageDownloader.h
//  FlickrDesign
//
//  Created by Admin on 05.07.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFNetworkProtocol.h"
#import "FFStorageProtocol.h"

@interface FFImageDownloader : NSObject

@property (nonatomic, strong) id<FFNetworkProtocol> networkManager;
@property (nonatomic, strong) id<FFStorageProtocol> storageService;

+(instancetype) new NS_UNAVAILABLE;
-(instancetype) init NS_UNAVAILABLE;
-(instancetype) initWithNetworkManager: (id<FFNetworkProtocol>)networkManager storageService: (id<FFStorageProtocol>)storageService;

-(void) cancelOperations;

-(void) loadImageForEntity: (NSString *)entityName withIdentifier: (NSString *)identifier forURL: (NSString *)url forAttribute: (NSString *)attribute withCompletionHandler: (void (^)(void))completionHandler;

@end

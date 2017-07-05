//
//  FFImageDownloadOperation.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFNetworkProtocol.h"
#import "FFStorageProtocol.h"

@class FFItem;
@class FFNetworkManager;

@interface FFImageDownloadOperation : NSOperation

+(instancetype) new NS_UNAVAILABLE;
-(instancetype) init NS_UNAVAILABLE;

-(instancetype) initWithNetworkManager:(id<FFNetworkProtocol>)networkManager storageService:(id<FFStorageProtocol>)storageService entity:(NSString *)entityName key:(NSString *)key url:(NSString *)url attribute:(NSString *)attribute completion:(void (^)(void))completion;

-(void) pause;

@end

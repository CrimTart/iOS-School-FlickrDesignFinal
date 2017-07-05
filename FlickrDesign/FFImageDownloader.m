//
//  FFImageDownloader.m
//  FlickrDesign
//
//  Created by Admin on 05.07.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFImageDownloader.h"
#import "FFImageDownloadOperation.h"

@interface FFImageDownloader ()

@property (nonatomic, strong) NSOperationQueue *imageDownloadQueue;

@end

@implementation FFImageDownloader

-(instancetype) initWithNetworkManager: (id<FFNetworkProtocol>)networkManager storageService: (id<FFStorageProtocol>)storageService {
    self = [super init];
    if (self) {
        _networkManager = networkManager;
        _storageService = storageService;
        _imageDownloadQueue = [NSOperationQueue new];
        _imageDownloadQueue.qualityOfService = QOS_CLASS_DEFAULT;
    }
    return self;
}

-(void) cancelOperations {
    for (FFImageDownloadOperation *operation in self.imageDownloadQueue.operations) {
        [operation pause];
    }
}

-(void) loadImageForEntity:(NSString *)entityName withIdentifier:(NSString *)identifier forURL:(NSString *)url forAttribute:(NSString *)attribute withCompletionHandler:(void (^)(void))completionHandler {
    FFImageDownloadOperation *imageDownloadOperation = [[FFImageDownloadOperation alloc] initWithNetworkManager:self.networkManager storageService:self.storageService entity:entityName key:identifier url:url attribute:attribute completion:^{
        completionHandler();
    }];
    [self.imageDownloadQueue addOperation:imageDownloadOperation];
}

@end

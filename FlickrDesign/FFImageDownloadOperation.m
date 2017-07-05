//
//  FFImageDownloadOperation.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFImageDownloadOperation.h"

@interface FFImageDownloadOperation()

@property (nonatomic, strong) id<FFNetworkProtocol> networkManager;
@property (nonatomic, strong) id<FFStorageProtocol> storageService;

@property (nonatomic, strong) __block NSString *downloadedImageURL;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) NSString *entityName;
@property (nonatomic, copy, nullable) void(^completion)(void);
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@end

@implementation FFImageDownloadOperation

-(instancetype) initWithNetworkManager: (id<FFNetworkProtocol>)networkManager storageService: (id<FFStorageProtocol>)storageService entity: (NSString *)entityName key: (NSString *)key url: (NSString *)url attribute: (NSString *)attribute completion: (void (^)(void))completion {
    self = [super init];
    if (self) {
        _storageService = storageService;
        _networkManager = networkManager;
        _entityName = entityName;
        _key = key;
        _url = url;
        _attribute = attribute;
        _completion = completion;
    }
    return self;
}

-(void) main {
    self.downloadTask = [self.networkManager downloadImageFromURL:[NSURL URLWithString:self.url] withCompletionHandler:^(NSString *dataURL) {
        self.downloadedImageURL = dataURL;
        [self saveImage];
    }];
}

-(void) saveImage {
    __weak typeof(self) weakSelf = self;
    [self.storageService saveObject:self.downloadedImageURL forEntity:self.entityName forAttribute:self.attribute forKey:self.key withCompletionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf.isCancelled) {
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.completion();
            });
        }
    }];
}

-(void) pause {
    [self.downloadTask suspend];
    [self cancel];
}

@end

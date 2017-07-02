//
//  FFFacade.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFFacade.h"
#import "FFImageDownloadOperation.h"

@interface FFFacade ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, FFImageDownloadOperation *> *imageOperations;
@property (nonatomic, strong) NSOperationQueue *imagesQueue;

@end

@implementation FFFacade

#pragma mark - Lifecycle

-(instancetype) initWithNetworkManager: (id<FFNetworkProtocol>)networkManager storageService: (id<FFStorageProtocol>) storageService {
    self = [super init];
    if (self) {
        _networkManager = networkManager;
        _storageService = storageService;
        _imageOperations = [NSMutableDictionary new];
        _imagesQueue = [NSOperationQueue new];
        _imagesQueue.qualityOfService = QOS_CLASS_DEFAULT;
    }
    return self;
}

#pragma mark - Operations

-(void) pauseOperations {
    [self.imageOperations enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id object, BOOL *stop) {
        FFImageDownloadOperation *operation = (FFImageDownloadOperation *)object;
        if (operation.isExecuting) {
            [operation pause];
        }
    }];
}

-(void) clearOperations {
    [self.imageOperations removeAllObjects];
}

#pragma mark - Network

-(void) loadImageForEntity: (NSString *)entityName withIdentifier: (NSString *)identifier forURL: (NSString *)url forAttribute: (NSString *)attribute withCompletionHandler: (void (^)(void))completionHandler {
    if (self.imageOperations[identifier].status == FFImageStatusCancelled) {
        [self.imageOperations[identifier] resume];
    } else  {
        FFImageDownloadOperation *imageDownloadOperation = [[FFImageDownloadOperation alloc] initWithFacade:self entity:entityName key:identifier url:url attribute:attribute];
        imageDownloadOperation.completionBlock = ^{
            completionHandler();
        };
        [self.imageOperations setObject:imageDownloadOperation forKey:identifier];
        [self.imagesQueue addOperation:imageDownloadOperation];
    }
}

#pragma mark - Storage

-(void) destroyEverything {
    [self.storageService deleteEntities:@"FFItem" withPredicate:nil];
    [self.storageService deleteEntities:@"Human" withPredicate:nil];
    [self.storageService deleteEntities:@"Comment" withPredicate:nil];
}

@end

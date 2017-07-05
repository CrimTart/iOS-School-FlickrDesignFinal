//
//  FFNetworkManager.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFNetworkManager.h"
#import <UIKit/UIKit.h>

@interface FFNetworkManager ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation FFNetworkManager

-(instancetype) init {
    self = [super init];
    if (self) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

-(void) getJSONFromURL: (NSURL *)url withCompletionHandler: (void (^)(NSDictionary *json))completionHandler {
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSError *jsonError = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (!jsonError) {
                completionHandler(json);
            } else {
                NSLog(@"ERROR PARSING JSON %@",error.userInfo);
            }
        } else if (error) {
            NSLog(@"error while downloading data %@",error.userInfo);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }];
    task.priority = NSURLSessionTaskPriorityHigh;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    [task resume];
}

-(void) getDataFromURL: (NSURL *)url withCompletionHandler: (void (^)(NSData *data))completionHandler {
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            completionHandler(data);
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        }
    }];
    task.priority = NSURLSessionTaskPriorityHigh;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    [task resume];
}

-(NSURLSessionDownloadTask *) downloadImageFromURL: (NSURL *)url withCompletionHandler: (void (^)(NSString *dataURL))completionHandler {
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode != 200) {
            NSLog(@"nsurlTask statusCode == %ld", httpResponse.statusCode);
        }
        if (error) {
            NSLog(@"error when downloading image %@", error.localizedDescription);
        } else {
            NSString *newUrl = [self moveToDocumentsFromLocation:location lastPathComponent:[url lastPathComponent]];
            completionHandler(newUrl);
        }
    }];
    [task resume];
    return task;
}

-(NSString *) moveToDocumentsFromLocation: (NSURL *)location lastPathComponent: (NSString *)lastPathComponent {
    NSString *relativePath = [NSString stringWithFormat:@"Documents/%@", lastPathComponent];
    NSString *destinationPath = [@"file://" stringByAppendingString:[NSHomeDirectory() stringByAppendingPathComponent:relativePath]];
    NSURL *destinationURL = [NSURL URLWithString:destinationPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtURL:destinationURL error:NULL];
    [fileManager copyItemAtURL:location toURL:destinationURL error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    error = nil;
    [destinationURL setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    return relativePath;
}

@end

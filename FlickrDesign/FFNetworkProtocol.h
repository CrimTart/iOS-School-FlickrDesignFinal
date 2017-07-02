//
//  FFNetworkProtocol.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FFNetworkProtocol <NSObject>

-(void) getModelFromURL: (NSURL *)url withCompletionHandler: (void (^)(NSDictionary *json)) completionHandler;
-(NSURLSessionTask *) downloadImageFromURL: (NSURL *)url withCompletionHandler: (void (^)(NSString *dataURL))completionHandler;

@end

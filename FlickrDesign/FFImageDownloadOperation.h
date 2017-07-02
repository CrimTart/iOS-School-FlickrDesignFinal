//
//  FFImageDownloadOperation.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFFacade.h"
@import UIKit;

@class FFItem;
@class FFNetworkManager;

typedef NS_ENUM(NSInteger, FFImageStatus) {
    FFImageStatusDownloading,
    FFImageStatusDownloaded,
    FFImageStatusFiltered,
    FFImageStatusCropped,
    FFImageStatusCancelled,
    FFImageStatusNone
};

@interface FFImageDownloadOperation : NSOperation

@property (nonatomic, assign) FFImageStatus status;

+(instancetype) new NS_UNAVAILABLE;
-(instancetype) init NS_UNAVAILABLE;

-(instancetype) initWithFacade: (FFFacade *)facade entity: (NSString *)entityName key: (NSString *)key url: (NSString *)url attribute: (NSString *)attribute;

-(void) pause;
-(void) resume;

@end

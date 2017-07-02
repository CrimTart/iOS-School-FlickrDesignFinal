//
//  FFItem.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FFStorageProtocol.h"

@class UIImage;

@interface FFItem : NSManagedObject

@property (nonatomic, assign) BOOL isFavorite;
@property (nonatomic, assign) uint16_t numberOfLikes;
@property (nonatomic, assign) uint16_t numberOfComments;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, copy) NSString *largePhotoURL;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *largePhoto;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *searchRequest;

+(NSString *) identifierForItemWithDictionary: (NSDictionary *)dict storage: (id<FFStorageProtocol>)storage forRequest: (NSString *)request;


@end

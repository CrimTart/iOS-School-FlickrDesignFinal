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
@class Comment;
@class Human;

@interface FFItem : NSManagedObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *largePhoto;
@property (nonatomic, copy) NSString *largePhotoURL;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *numberOfComments;
@property (nonatomic, copy) NSString *numberOfLikes;
@property (nonatomic, copy) NSString *photoID;
@property (nonatomic, copy) NSString *photoSecret;
@property (nonatomic, copy) NSString *searchRequest;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *thumbnailURL;
@property (nonatomic, assign) BOOL isFavorite;

@property (nonatomic, strong) Human *author;
@property (nonatomic, strong) NSSet<Comment *> *comments;

@property (nonatomic, copy) NSArray<Comment *> *commentsArray;

+(NSString *) identifierForItemWithDictionary: (NSDictionary *)dict storage: (id<FFStorageProtocol>)storage forRequest: (NSString *)request;

-(void) addComments: (NSSet<Comment *> *)comments;

@end

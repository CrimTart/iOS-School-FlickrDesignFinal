//
//  Comment.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FFStorageService.h"

@class Human;
@class FFItem;

typedef NS_ENUM(NSUInteger, FFCommentType) {
    FFCommentTypeComment,
    FFCommentTypeLike
};

@interface Comment : NSManagedObject

@property (nonatomic, strong) NSNumber *commentType;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) Human *author;
@property (nonatomic, strong) FFItem *item;

+(Comment *) commentWithDictionary: (NSDictionary *)dict type: (FFCommentType)type storage: (id<FFStorageProtocol>) storage;

@end

//
//  Human.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FFStorageService.h"
#import "FFNetworkProtocol.h"

@class UIImage;
@class Comment;
@class FFItem;

@interface Human : NSManagedObject

@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *avatar;

@property (nonatomic, strong) NSSet<Comment *> *comment;
@property (nonatomic, strong) NSSet<FFItem *> *item;

+(Human *) humanWithDictionary: (NSDictionary *)dict storage: (id<FFStorageProtocol>)storage;

-(void) getAvatarWithNetworkService: (id<FFNetworkProtocol>)networkService storageService: (id<FFStorageProtocol>)storageService completionHandler: (void (^)(UIImage *))completionHandler;

@end

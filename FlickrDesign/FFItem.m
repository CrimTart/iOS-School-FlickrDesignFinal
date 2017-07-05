//
//  FFItem.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFItem.h"

@implementation FFItem

@dynamic numberOfLikes;
@dynamic numberOfComments;
@dynamic location;
@dynamic photoID;
@dynamic photoSecret;
@dynamic isFavorite;
@dynamic largePhotoURL;
@dynamic thumbnailURL;
@dynamic text;
@dynamic largePhoto;
@dynamic thumbnail;
@dynamic identifier;
@dynamic searchRequest;

@dynamic author;
@dynamic comments;

@synthesize commentsArray = _commentsArray;

+(NSString *) identifierForItemWithDictionary: (NSDictionary *)dict storage: (id<FFStorageProtocol>)storage forRequest: (NSString *)request {
    NSString *base = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                      dict[@"farm"], dict[@"server"], dict[@"id"], dict[@"secret"]];
    NSString *thumbnailUrl = [base stringByAppendingString:@""];
    NSString *imageUrl = [base stringByAppendingString:@""];
    NSString *identifier = thumbnailUrl;
    
    FFItem *item = (FFItem *)[storage fetchEntity:NSStringFromClass([self class]) forKey:identifier];
    
    if (!item) {
        NSString *escapedEmojiText = dict[@"title"] ? [NSString stringWithCString:[dict[@"title"] cStringUsingEncoding:NSNonLossyASCIIStringEncoding] encoding:NSUTF8StringEncoding] : @" ";
        [storage insertNewObjectForEntityForName:NSStringFromClass([self class]) withDictionary:@{
                                                                                                  @"thumbnailURL":thumbnailUrl,
                                                                                                  @"largePhotoURL":imageUrl,
                                                                                                  @"text":escapedEmojiText,
                                                                                                  @"identifier":thumbnailUrl,
                                                                                                  @"searchRequest":request,
                                                                                                  @"photoID":dict[@"id"],
                                                                                                  @"photoSecret":dict[@"secret"]
                                                                                                  }];
    }
    return identifier;
}

-(void) addComments: (NSSet<Comment *> *)comments {
    __weak typeof(self)weakSelf = self;
    dispatch_barrier_sync(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        __strong typeof(self)strongSelf = weakSelf;
        strongSelf.comments = [strongSelf.comments setByAddingObjectsFromSet:comments];
        strongSelf.commentsArray = strongSelf.comments.allObjects;
    });
}

-(NSArray<Comment *> *) commentsArray {
    if (!_commentsArray) {
        return self.comments.allObjects;
    } else {
        return _commentsArray;
    }
}

@end

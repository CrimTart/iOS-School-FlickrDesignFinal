//
//  FFItem.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFItem.h"
#import "FFStorageProtocol.h"

static NSString *const entityName = @"FFItem";

@implementation FFItem

@dynamic isFavorite;
@dynamic numberOfLikes;
@dynamic numberOfComments;
@dynamic latitude;
@dynamic longitude;
@dynamic largePhotoURL;
@dynamic thumbnailURL;
@dynamic text;
@dynamic largePhoto;
@dynamic thumbnail;
@dynamic identifier;
@dynamic searchRequest;

+(NSString *) identifierForItemWithDictionary: (NSDictionary *)dict storage: (id<FFStorageProtocol>)storage forRequest: (NSString *)request {
    NSString *base = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                      dict[@"farm"], dict[@"server"], dict[@"id"], dict[@"secret"]];
    NSString *thumbnailUrl = [base stringByAppendingString:@""]; //_s//_n
    NSString *imageUrl = [base stringByAppendingString:@""]; //z
    NSString *identifier = thumbnailUrl;
    
    FFItem *item = (FFItem *)[storage fetchEntity:entityName forKey:identifier];
    
    if (!item) {
        [storage insertNewObjectForEntityForName:entityName withDictionary:@{
                                                                             @"thumbnailURL":thumbnailUrl,
                                                                             @"largePhotoURL":imageUrl,
                                                                             @"text":dict[@"title"],
                                                                             @"identifier":thumbnailUrl,
                                                                             @"searchRequest":request
                                                                             }];
    }
    return identifier;
}

@end

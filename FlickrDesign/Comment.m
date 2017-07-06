//
//  Comment.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "Comment.h"
#import "Human.h"

@implementation Comment

@synthesize commentType;
@dynamic text;
@dynamic author;
@dynamic item;

+(Comment *) commentWithDictionary: (NSDictionary *)dict type: (FFCommentType)type storage: (id<FFStorageProtocol>)storage {
    Comment *comment = nil;
    comment = [storage insertNewObjectForEntity:NSStringFromClass([self class])];
    switch (type) {
        case FFCommentTypeComment: {
            comment.text = dict[@"_content"] ? [NSString stringWithCString:[dict[@"_content"] cStringUsingEncoding:NSNonLossyASCIIStringEncoding] encoding:NSUTF8StringEncoding] : @" ";
            comment.commentType = @0;
            break;
        }
        case FFCommentTypeLike: {
            comment.text = [NSString stringWithCString:[@"оценил ваше фото." cStringUsingEncoding:NSNonLossyASCIIStringEncoding] encoding:NSUTF8StringEncoding];
            comment.commentType = @1;
        }
    }
    Human *author = [Human humanWithDictionary:dict storage:storage];
    comment.author = author;
    return comment;
}

-(FFCommentType) getCommentType {
    switch ([self.commentType integerValue]) {
        case 0: {
            return FFCommentTypeComment;
            break;
        } case 1: {
            return FFCommentTypeLike;
            break;
        }
    }
    return FFCommentTypeComment;
}

@end

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

@dynamic comment;
@dynamic url;
@dynamic author;

+(Comment *) commentWithDictionary: (NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext *)moc {
    Comment *comment = nil;
    comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:moc];
    comment.author = dict[@"author"];
    comment.url = dict[@"url"];
    comment.comment = dict[@"comment"];
    
    return comment;
}

@end

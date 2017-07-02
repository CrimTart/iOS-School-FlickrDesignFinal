//
//  Human.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "Human.h"

@implementation Human

@dynamic avatarURL;
@dynamic name;
@dynamic url;
@dynamic avatar;

+(Human *) humanWithDictionary: (NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext *)moc {
    Human *human = nil;
    human = [NSEntityDescription insertNewObjectForEntityForName:@"Human" inManagedObjectContext:moc];
    human.avatarURL = dict[@"avatarURL"];
    human.name = dict[@"name"];
    human.url = dict[@"url"];
    human.avatar = dict[@"avatar"];
    
    return human;
}


@end

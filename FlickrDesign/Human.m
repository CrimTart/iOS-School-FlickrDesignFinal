//
//  Human.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "Human.h"
@import UIKit;

@implementation Human

@dynamic avatarURL;
@dynamic name;
@dynamic avatar;
@dynamic item;
@dynamic comment;

+(Human *) humanWithDictionary: (NSDictionary *)dict storage: (id<FFStorageProtocol>)storage {
    NSString *iconFarm = dict[@"iconfarm"];
    NSString *iconServer = dict[@"iconserver"];
    NSString *nsid;
    if (dict[@"nsid"]) {
        nsid = dict[@"nsid"];
    }
    else if (dict[@"author"]) {
        nsid = dict[@"author"];
    }
    else {
        abort();
    }
    NSString *avatarURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/buddyicons/%@.jpg", iconFarm, iconServer, nsid];
    
    Human *human = nil;
    human = [storage insertNewObjectForEntity:NSStringFromClass([self class])];
    NSString *name;
    if (dict[@"username"]) {
        name = [NSString stringWithCString:[dict[@"username"] cStringUsingEncoding:NSNonLossyASCIIStringEncoding] encoding:NSUTF8StringEncoding];
    }
    else if (dict[@"authorname"]) {
        name = [NSString stringWithCString:[dict[@"authorname"] cStringUsingEncoding:NSNonLossyASCIIStringEncoding] encoding:NSUTF8StringEncoding];
    }
    else {
        abort();
    }
    human.name = name;
    human.avatarURL = avatarURL;
    
    return human;
}

-(void) getAvatarWithNetworkService: (id<FFNetworkProtocol>)networkService storageService: (id<FFStorageProtocol>)storageService completionHandler: (void (^)(UIImage *))completionHandler {
    NSURL *url = [NSURL URLWithString:self.avatarURL];
    __weak typeof(self)weakSelf = self;
    [networkService getDataFromURL:url withCompletionHandler:^(NSData *data) {
        __strong typeof(self)strongSelf = weakSelf;
        UIImage *avatar = [UIImage imageWithData:data];
        strongSelf.avatar = avatar;
        [storageService save];
        completionHandler(avatar);
    }];
}


@end

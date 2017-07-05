//
//  FFFavoritesModel.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFFavoritesModel.h"
#import "FFItem.h"
@import UIKit;

static NSString *const kItemEntity = @"FFItem";

@interface FFFavoritesModel ()

@property (nonatomic, strong) NSDictionary <NSNumber *, FFItem *> *items;
@property (nonatomic, strong, readonly) id<FFStorageProtocol> storageService;

@end

@implementation FFFavoritesModel

-(instancetype) initWithStorageService: (id<FFStorageProtocol>)storageService {
    self = [super init];
    if (self) {
        _storageService = storageService;
        _items = [NSDictionary new];
    }
    return self;
}

-(FFItem *) itemForIndex: (NSUInteger)index {
    return self.items[@(index)];
}

-(void) getFavoriteItemsWithCompletionHandler: (void (^)(void))completionHandler {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isFavorite == YES"];
    NSArray *result = [self.storageService fetchEntities:kItemEntity withPredicate:predicate];
    NSUInteger index = 0;
    NSMutableDictionary *newItems = [NSMutableDictionary new];
    for (FFItem *item in result) {
        newItems[@(index)] = item;
        ++index;
    }
    self.items = [newItems copy];
    completionHandler();
}

-(NSUInteger) numberOfItems {
    return self.items.count;
}

@end

//
//  FFFavoritesModel.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFStorageProtocol.h"

@class FFItem;

@interface FFFavoritesModel : NSObject

-(instancetype) initWithStorageService: (id<FFStorageProtocol>)storageService;

-(void) getFavoriteItemsWithCompletionHandler: (void (^)(void))completionHandler;

-(FFItem *) itemForIndex: (NSUInteger)index;

-(NSUInteger) numberOfItems;

@end

//
//  FFStorageProtocol.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^voidBlock)(void);

@protocol FFStorageProtocol <NSObject>

-(id) fetchEntity: (NSString *)entity forKey: (NSString *)key;

-(NSArray *) fetchEntities: (NSString *)entity withPredicate: (NSPredicate *)predicate;

-(void) save;

-(void) deleteEntities: (NSString *)entity withPredicate: (NSPredicate *)predicate;

-(void) performBlockAsynchronously: (voidBlock)block withCompletion: (voidBlock)completion;

-(void) saveObject: (id)object forEntity: (NSString *)entity forAttribute: (NSString *)attribute forKey: (NSString *)key withCompletionHandler: (voidBlock)completionHandler;

-(void) insertNewObjectForEntityForName: (NSString *)name withDictionary: (NSDictionary<NSString *, id> *)attributes;

-(id) insertNewObjectForEntity: (NSString *)name;

@end

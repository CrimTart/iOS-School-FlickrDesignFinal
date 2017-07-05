//
//  FFCoreDataStack.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface FFCoreDataStack : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext *mainContext;

-(instancetype) init NS_UNAVAILABLE;
+(instancetype) new NS_UNAVAILABLE;

-(instancetype) initStack NS_DESIGNATED_INITIALIZER;
+(instancetype) stack;

-(NSManagedObjectContext *) setupPrivateContext;

@end

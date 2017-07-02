//
//  FFCoreDataStack.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFCoreDataStack.h"

@interface FFCoreDataStack ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *mainContext;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *privateContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coreDataPSC;

@end

@implementation FFCoreDataStack

-(instancetype) initStack {
    self = [super init];
    
    [self setupCoreData];
    
    return self;
}

+(instancetype) stack {
    return [[FFCoreDataStack alloc] initStack];
}

-(void) setupCoreData {
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *coreDataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:path];
    
    self.coreDataPSC = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:coreDataModel];
    NSError *err = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationSupportFolder = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
    
    if (![fileManager fileExistsAtPath:applicationSupportFolder.path]) {
        [fileManager createDirectoryAtPath:applicationSupportFolder.path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSURL *url = [applicationSupportFolder URLByAppendingPathComponent:@"db.sqlite"];
    [self.coreDataPSC addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&err];
    
    self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainContext.persistentStoreCoordinator = self.coreDataPSC;
    self.mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    
    self.privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [self.privateContext setParentContext:self.mainContext];
}

@end

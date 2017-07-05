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
@property (nonatomic, strong) NSPersistentStoreCoordinator *coreDataPSC;

@end

@implementation FFCoreDataStack

-(instancetype) initStack {
    self = [super init];
    if (self) {
        [self setupCoreData];
    }
    return self;
}

+(instancetype) stack {
    return [[FFCoreDataStack alloc] initStack];
}

-(void) setupCoreData {
    [self setupPSC];
    [self setupMainContext];
}

- (void)setupPSC {
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"Model1" withExtension:@"momd"];
    NSManagedObjectModel *coreDataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:path];
    
    self.coreDataPSC = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:coreDataModel];
    NSError *err = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationSupportFolder = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
    
    if (![fileManager fileExistsAtPath:applicationSupportFolder.path]) {
        [fileManager createDirectoryAtPath:applicationSupportFolder.path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSURL *url = [applicationSupportFolder URLByAppendingPathComponent:@"db1.sqlite"];
    [self.coreDataPSC addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&err];
}

-(void) setupMainContext {
    self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainContext.persistentStoreCoordinator = self.coreDataPSC;
    self.mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
}

-(NSManagedObjectContext *) setupPrivateContext {
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [privateContext setParentContext:self.mainContext];
    return privateContext;
}

@end

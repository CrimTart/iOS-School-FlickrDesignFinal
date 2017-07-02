//
//  Comment.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <CoreData/CoreData.h>
@class Human;

@interface Comment : NSManagedObject

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) Human *author;

+(Comment *) commentWithDictionary: (NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext *)moc;

@end

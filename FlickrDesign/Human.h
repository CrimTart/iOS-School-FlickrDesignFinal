//
//  Human.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <CoreData/CoreData.h>
@class UIImage;

@interface Human : NSManagedObject

@property (nonatomic, strong) NSURL *avatarURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *avatar;

+(Human *) humanWithDictionary: (NSDictionary *)dict inManagedObjectContext: (NSManagedObjectContext *)moc;

@end

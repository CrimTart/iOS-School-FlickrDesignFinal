//
//  FFPostModel.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFPostModelProtocol.h"

@class FFFacade;

@interface FFPostModel : NSObject <FFPostModelProtocol>

+(instancetype) new NS_UNAVAILABLE;
-(instancetype) init NS_UNAVAILABLE;
-(instancetype) initWithFacade: (FFFacade *)facade;

@end

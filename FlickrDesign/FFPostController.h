//
//  FFPostController.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFPostModelProtocol.h"

@interface FFPostController : UIViewController

-(instancetype) initWithModel: (id<FFPostModelProtocol>)model;

@end

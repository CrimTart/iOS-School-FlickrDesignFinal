//
//  FFCollectionViewController.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFCollectionModelProtocol.h"

extern NSString * const ffCollectionReuseIdentifier;

@interface FFCollectionViewController : UIViewController

-(instancetype) initWithModel: (id<FFCollectionModelProtocol>)model;

@end

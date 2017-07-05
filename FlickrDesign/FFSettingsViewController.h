//
//  FFSettingsViewController.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFStorageProtocol.h"

@interface FFSettingsViewController : UIViewController

-(instancetype) initWithStorage: (id<FFStorageProtocol>)storage;

@end

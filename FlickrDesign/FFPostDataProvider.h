//
//  FFPostDataProvider.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFPostModelProtocol.h"
#import "FFPostViewCells.h"
@import UIKit;

@interface FFPostDataProvider : NSObject <UITableViewDataSource>

-(instancetype) initWithModel: (id<FFPostModelProtocol>)model andController: (id<UITableViewDelegate, FFCellsDelegate>)controller;
@end

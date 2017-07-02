//
//  FFPostModelProtocol.h
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFFacade.h"

@class UIImage;
@class FFItem;

@protocol FFPostModelProtocol <NSObject>

-(void) makeFavorite: (BOOL)favorite;

-(void) passSelectedItem: (FFItem *)selectedItem;

-(FFItem *) getSelectedItem;

-(void) loadImageForItem: (FFItem *)item withCompletionHandler: (void (^)(void))completionHandler;

@end

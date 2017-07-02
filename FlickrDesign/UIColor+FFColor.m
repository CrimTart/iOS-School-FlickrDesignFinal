//
//  UIColor+FFColor.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "UIColor+FFColor.h"

@implementation UIColor (FFColor)

+(UIColor *) myGray {
    UIColor *myGray = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:0.9];
    return myGray;
}

+(UIColor *) myOpaqueGray {
    UIColor *myGray = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    return myGray;
}

+(UIColor *) separatorColor {
    return [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
}

@end

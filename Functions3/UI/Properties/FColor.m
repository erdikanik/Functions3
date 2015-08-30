//
//  FColor.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FColor.h"

@implementation FColor

+ (UIColor*)fNumberColor
{
    return _RGBA(194,174,165,1.0);
}

+ (UIColor*)fNumberTextColor
{
    return _RGBA(99, 91, 82, 1.0);
}

+ (NSArray*)fNumberColorArray
{
    return [NSArray arrayWithObjects:[UIColor yellowColor],[UIColor redColor],[UIColor greenColor],[UIColor purpleColor],[UIColor whiteColor],[UIColor cyanColor],[UIColor magentaColor],nil];
}
@end

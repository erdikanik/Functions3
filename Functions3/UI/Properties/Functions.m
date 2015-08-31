//
//  Functions.m
//  Functions3
//
//  Created by erdikanik on 31.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "Functions.h"



@implementation Functions

+ (NSArray*)getFunctions
{
    NSArray *functionsArray = [[NSArray alloc] initWithObjects:
    @"x",
    @"x-2",
    @"x+1",
    @"x^2-x-21",
    @"x^2-5x+2",
    @"x^2-51",
    @"-x^2+x+20",
    @"x3-400",
    @"x3-500",
    @"x3-600",nil];

    return functionsArray;
}

@end

//
//  Functions.m
//  Functions3
//
//  Created by erdikanik on 31.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "Functions.h"
#import "FMath.h"


@implementation Functions

+ (NSArray*)getFunctions
{
    NSArray *functionsArray = [[NSArray alloc] initWithObjects:
    @"x",
    @"-x",
    @"x-2",
    @"x+1",
    @"x^2-x-21",
    @"x^2-5x+2",
    @"x^2-51",
    @"-x^2+x+20",
    @"x^3-400",
    @"x^3-500",
    @"x^3-600",nil];

    return functionsArray;
}

+ (Polynomal*)getRandomFunction
{
    NSArray *functionArray = [self getFunctions];
    NSInteger num = [FMath getRandomGeneratorGivenRange:0 withSecond:functionArray.count];
    Polynomal *polynomal = [[Polynomal alloc] initWithPolynomalString:[functionArray objectAtIndex:num]];
    return polynomal;
}

@end

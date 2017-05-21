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

+ (NSArray<NSString *> *)getFunctions
{
    NSArray *functionsArray = [[NSArray alloc] initWithObjects:
    @"x",
    @"-x",
    @"x-2",
    @"x+1",
    @"x^3",
    @"-x^2",
    @"-x^3",
    @"-2x",
    @"2x",
    @"x-5",
    @"x+2",
    @"-x+5",
    nil];

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

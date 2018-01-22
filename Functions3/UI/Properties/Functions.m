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
    @"1x",
    @"-1x",
    @"1x+-3",
    @"-1x+2",
    @"1x+3",
    @"-1x+3",
    @"2x+-8",
    @"-2x+8",
    @"-2x",
    @"2x+-5",
    @"-2x+5",
    @"1x+-5",
    @"3x+-20",
    @"-3x+20",
    @"-1x+5",
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

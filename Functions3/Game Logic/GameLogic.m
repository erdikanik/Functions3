//
//  GameLogic.m
//  Functions3
//
//  Created by erdikanik on 30.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "GameLogic.h"
#import "FMath.h"

@implementation GameLogic

+ (FNumber*)getNumberFromLogic
{
    CGFloat num = [FMath getRandomGeneratorGivenRange:0 withSecond:1000];
    
    if (num < 900)
    {
        FNumber *number = [[FNumber alloc] initWithNumber:[self getRandomNumber]];
        return number;
    }
    else if (num < 990)
    {
        FNumber *number = [[FNumber alloc] initBombTypeWithNumber:[self getRandomNumber]];
        return number;
    }
    else if (num < 980)
    {
        CGFloat num1 = [GameLogic getRandomNumber];
        CGFloat num2 = [GameLogic getRandomNumber];
        CGFloat num3 = [GameLogic getRandomNumber];
        NSArray *numberArray = [NSArray arrayWithObjects:_N(num1),_N(num2),_N(num3),nil];
        FNumber *number = [[FNumber alloc] initWithNumberArray:numberArray];
        return number;
    }
    else if (num < 990)
    {
        FNumber *number = [[FNumber alloc] initBombTypeWithNumber:[self getRandomNumber]];
        return number;
    }
    else
    {
        FNumber *number = [[FNumber alloc] initInvisibleNumber:[self getRandomNumber]];
        return number;
    }
    
}

+ (CGFloat)getRandomNumber
{
    return [FMath getRandomGeneratorGivenRange:-10 withSecond:9];
}

@end

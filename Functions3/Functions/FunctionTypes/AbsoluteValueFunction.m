//
//  AbsoluteValueFunction.m
//  Functions3
//
//  Created by erdikanik on 13.12.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "AbsoluteValueFunction.h"

@implementation AbsoluteValueFunction


- (CGFloat)getAbsoluteValue:(CGFloat)value
{
    return fabs(value);
}

- (CGFloat)resultValue:(CGFloat)numberValue
{
    return [self getAbsoluteValue:numberValue];
}

- (NSString*)description
{
    return @"|x|";
}

@end

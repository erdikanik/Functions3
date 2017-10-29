//
//  FColor.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FStyle.h"
#import "FMath.h"

@implementation FStyle

+ (UIColor*)fNumberColor
{
    return _RGBA(194,174,165,1.0);
}

+ (UIColor*)fBoardColor
{
    return _RGBA(204,204,204,1.0);
}

+ (UIColor*)fNumberTextColor
{
    return _RGBA(99, 91, 82, 1.0);
}

+ (UIColor*)fMainColor
{
    return _RGBA(233,221,209,1);
}

+ (UIColor*)fMainDarkColor
{
    return _RGBA(245,221,209,1);
}

+ (NSArray*)fNumberColorArray
{
    return [NSArray arrayWithObjects:
            [UIColor orangeColor],
            [UIColor redColor],
            [UIColor greenColor],
            [UIColor purpleColor],
            [UIColor cyanColor],
            [UIColor magentaColor],
            [UIColor purpleColor],
            [UIColor brownColor],
            [UIColor lightGrayColor],
            nil];
}

+ (UIColor*)getRandomColor
{
    NSInteger num = [FMath getRandomGeneratorGivenRange:0 withSecond:[FStyle fNumberColorArray].count];
    return [[FStyle fNumberColorArray] objectAtIndex:num];
}

+ (NSString*)fMainFont
{
    return @"Copperplate";
}

+ (NSString*)fMainFont2
{
    return @"Helti SC";
}

+ (UIColor*)fTriangleColor
{
    return _RGBA(252,4,40,1);
}

+ (UIColor*)fSquareColor
{
    return _RGBA(4,10,252,1);
}

+ (UIColor*)fCircleColor
{
    return _RGBA(162,252,4,1);
}


@end

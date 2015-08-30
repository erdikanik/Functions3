//
//  FMath.m
//  Functions
//
//  Created by Erdi Kanık on 17/11/14.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import "FMath.h"

static FMath *fmath = nil;

@implementation FMath

// y must be bigger than x otherwise will return wrong result
// example; -100,-5
+ (CGFloat) getRandomGeneratorGivenRange: (CGFloat) x withSecond:(CGFloat) y {
    if (x < 0 && y < 0) {
        CGFloat diff = fabs(x) - fabs(y);
        CGFloat randm = (CGFloat)(arc4random() % ((int)diff));
        return (fabs(y) + randm) * -1;
    } else if (x < 0 && y > 0) {
        float diff = fabs(x) + y;
        float randm = (float)(arc4random() % ((int)diff));
        return randm > y ? -1 * (randm - y) : randm;
    } else {
        float diff = y - x;
        float randm = (float)(arc4random() % ((int)diff));
        return x + randm;
    }
}

+ (CGFloat) getBinaryRandomBinaryGenerator {
    return [self getRandomGeneratorGivenRange:0 withSecond:2];
}

+ (Fraction*) getPositiveFractionalGenerator {
    float denumerator = [self getRandomGeneratorGivenRange:2 withSecond:1000];
    float numerator = [self getRandomGeneratorGivenRange:1 withSecond:denumerator];
    Fraction *fraction = [[Fraction alloc] initWithNumerator:numerator withDenumerator:denumerator];
    return fraction;
}

+ (Fraction*) getNegativeFractionalGenerator {
    float denumerator = [self getRandomGeneratorGivenRange:2 withSecond:1000];
    float numerator = [self getRandomGeneratorGivenRange:1 withSecond:denumerator];
    Fraction *fraction = [[Fraction alloc] initWithNumerator:-numerator withDenumerator:denumerator];
    return fraction;
}

+ (Irrational*) getIrrationalGeneratorSquare {
    float num = [self getRandomGeneratorGivenRange:1 withSecond:1000];
    Irrational* irr = [[Irrational alloc] initWithRoot:num withDegree:IrrationalTypeSquare];
    return irr;
}

+ (Irrational*) getIrrationalGeneratorCube {
    float num = [self getRandomGeneratorGivenRange:1 withSecond:1000];
    Irrational* irr = [[Irrational alloc] initWithRoot:num withDegree:IrrationalTypeCube];
    return irr;
}

+ (CGFloat) getPositiveFloatNumber {
    return [[FMath getPositiveFractionalGenerator] floatValue];
}

+ (CGFloat) getNegativeFloatNumber {
    return [[FMath getNegativeFractionalGenerator] floatValue];
}

@end

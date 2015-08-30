//
//  FMath.h
//  Functions
//
//  Created by Erdi Kanık on 17/11/14.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
#import "Irrational.h"

@interface FMath : NSObject

+ (CGFloat) getRandomGeneratorGivenRange: (CGFloat) x withSecond:(CGFloat) y;
+ (CGFloat) getBinaryRandomBinaryGenerator;
+ (Fraction*) getPositiveFractionalGenerator;
+ (Fraction*) getNegativeFractionalGenerator;
+ (Irrational*) getIrrationalGeneratorSquare;
+ (Irrational*) getIrrationalGeneratorCube;
+ (CGFloat) getPositiveFloatNumber;
+ (CGFloat) getNegativeFloatNumber;

@end

//
//  Polynomal.m
//  Functions
//
//  Created by Erdi Kanık on 18/11/14.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import "Polynomal.h"

@interface Polynomal()
@property (nonatomic,copy) NSString *polyString;
@property (nonatomic, assign) CGFloat number;
@end

// example x^5+2x^3+7
@implementation Polynomal

- (id) initWithPolynomalString:(NSString*) polyString {
    if (self = [super init]) {
        self.polyString = polyString;
        self.ftype = FunctionTypePolynomal;
    }
    return self;
}

/*
 get value from given 2x^3+x^2+5 polynomal string
 */
- (CGFloat) getPolynomalValue:(CGFloat) value
{
    CGFloat returnVal = 0;
    NSString *trimmedString = [self.polyString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *parsedString = [trimmedString componentsSeparatedByString:@"+"];
    
    for (int i=0;i<parsedString.count;++i)
    {
        NSString *str = parsedString[i];
        if ([str containsString:@"^"]) {
            NSArray *strarr = [str componentsSeparatedByString:@"^"];
            CGFloat cross = 1;
            NSString *xstr = strarr[0];
            if (xstr.length > 1) {
                NSString* str = strarr[0]; // must 2x
                NSString* substr = [str substringToIndex:str.length -1 ]; // 2
                cross = [substr floatValue];
            }
            CGFloat pwr = [strarr[strarr.count - 1] floatValue]; // power
            returnVal += cross * pow(value,pwr); // b*x^a
        }
        else if ([str containsString:@"-x"])
        {
            returnVal += value * -1;
        }
        else if ([str containsString:@"x"])
        {
            float cross = 1;
            if (str.length > 1) {
                NSString *sbstr = [str substringToIndex:str.length - 1];
                cross = [sbstr floatValue];
            }
            returnVal += cross * value;
        }
        else
        {
            returnVal += [str floatValue];
        }
    }
    return returnVal;
}

- (CGFloat)resultValue:(CGFloat)numberValue
{
    _number = numberValue;
    return [self getPolynomalValue:numberValue];
}

// override getValue
- (NSArray*)getValue:(NSArray *)valueArray
{
    NSNumber *number = [valueArray objectAtIndex:0];
    CGFloat input = [number floatValue];
    CGFloat answer = [self getPolynomalValue:input];
    NSNumber *resultNumber = [NSNumber numberWithFloat:answer];
    NSArray *resultArray = [[NSArray alloc] initWithObjects:resultNumber, nil];
    return resultArray;
}

- (BOOL)isResultPositive
{
    return [self resultValue:_number];
}

- (NSString*)description
{
    NSString *mString = self.polyString;
    mString = [mString stringByReplacingOccurrencesOfString:@"^0" withString:@"⁰"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^1" withString:@"ⁱ"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^2" withString:@"²"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^3" withString:@"³"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^4" withString:@"⁴"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^5" withString:@"⁵"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^6" withString:@"⁶"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^7" withString:@"⁷"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^8" withString:@"⁸"];
    mString = [mString stringByReplacingOccurrencesOfString:@"^9" withString:@"⁹"];
    mString = [mString stringByReplacingOccurrencesOfString:@"1x" withString:@"x"];
    mString = [mString stringByReplacingOccurrencesOfString:@"+-" withString:@"-"];
    return mString;
}

- (NSString*)getPowCharacterFromEquation:(NSString*)number
{
    NSArray *charArray = [[NSArray alloc] initWithObjects:@"⁰",@"ⁱ",@"²",@"³",@"⁴",@"⁵",@"⁶",@"⁷",@"⁸",@"⁹",nil];
    NSInteger num = [number intValue];
    return charArray[num];
}

@end

//
//  Producer.m
//  Functions
//
//  Created by Erdi Kanık on 17/11/14.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

/*
 rand(x,y) produces number x among y
 
 */

#import "Producer.h"

@interface Producer()
@property (assign, nonatomic) FunctionType ftype;
@property (nonatomic,copy) NSString *produceName;

@end

@implementation Producer

- (id)initWithProduceName:(NSString*)produceName
{
    if (self = [super init]) {
        self.produceName = produceName;
    }
    return self;
}


- (CGFloat)parseFunctionFromName
{
    if ([self.produceName containsString:@"rand"]) {
        self.ftype = FunctionTypeRandom;
        NSArray *numbers = [self tupleParser:[self.produceName stringByReplacingOccurrencesOfString:@"rand" withString:@""]];
        CGFloat x1 = [[numbers objectAtIndex:0] floatValue];
        CGFloat x2 = [[numbers objectAtIndex:1] floatValue];
        return [FMath getRandomGeneratorGivenRange:x1 withSecond:x2];
    } else if ([self.produceName containsString:@"binary"]) {
        self.ftype = FunctionTypeBinary;
        return [FMath getBinaryRandomBinaryGenerator];
    } else if ([self.produceName containsString:@"fractional"]) {
        self.ftype = FunctionTypeFractional;
        
    } else {
        NSLog(@"ERR : Function not recognize!!!");
    }
    return 0;
}

// parse (4,2) etc...
- (NSArray*)tupleParser:(NSString *)tuple {
    NSString *removedString = [tuple stringByReplacingOccurrencesOfString:@"(" withString:@""];
    NSString *removedString2 = [removedString stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSArray *numbers = [removedString2 componentsSeparatedByString:@","];
    return numbers;
}

@end

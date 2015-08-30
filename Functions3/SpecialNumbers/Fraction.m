//
//  Fraction.m
//  Functions
//
//  Created by Erdi Kanık on 17/11/14.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import "Fraction.h"

@interface Fraction()
@property (assign, nonatomic) NSInteger a;
@property (assign, nonatomic) NSInteger b;
@end

@implementation Fraction
- (id) initWithNumerator:(float) num withDenumerator:(float) denum {
    if (self = [super init]) {
        _a = num;
        _b = denum;
    }

    return self;
}


- (NSString*) description {
    return [NSString stringWithFormat:@"%ld/%ld",(long)self.a,(long)self.b];
}

- (float) floatValue {
    return (float)self.a/self.b;
}

@end

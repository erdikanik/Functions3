//
//  Irrational.m
//  Functions
//
//  Created by erdikanik on 17.11.2014.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import "Irrational.h"

@interface Irrational()
    @property (assign, nonatomic) CGFloat root;
    @property (assign, nonatomic) IrrationalType degree;
@end

@implementation Irrational

- (id) initWithRoot:(CGFloat) r withDegree:(IrrationalType) d {
    if (self = [super init]) {
        self.root = r;
        self.degree = d;
    }
    return self;
}

- (NSString*) description {
    if (self.degree == IrrationalTypeSquare) {
        return [NSString stringWithFormat:@"√%ld",(long)self.root];
    } else {
        return [NSString stringWithFormat:@"∛%ld",(long)self.root];
    }
}

- (float) irrationalValue {
    if (self.degree == IrrationalTypeSquare) {
        return sqrtf(self.root);
    } else {
        return powf(self.root, 3);
    }
}


@end

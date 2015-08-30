//
//  Irrational.h
//  Functions
//
//  Created by erdikanik on 17.11.2014.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IrrationalType) {
    IrrationalTypeSquare,
    IrrationalTypeCube
};

@interface Irrational : NSObject
- (id) initWithRoot:(CGFloat) r withDegree:(IrrationalType) d;
- (float) irrationalValue;
@end

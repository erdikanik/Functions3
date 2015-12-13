//
//  AbsoluteValueFunction.h
//  Functions3
//
//  Created by erdikanik on 13.12.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "AbstractFunction.h"

@interface AbsoluteValueFunction : AbstractFunction


- (CGFloat)getAbsoluteValue:(CGFloat)value;
- (NSString*)description;

@end

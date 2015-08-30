//
//  Polynomal.h
//  Functions
//
//  Created by Erdi Kanık on 18/11/14.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractFunction.h"

@interface Polynomal : AbstractFunction

- (id)initWithPolynomalString:(NSString*)polyString;
- (CGFloat)getPolynomalValue:(CGFloat)value;
@end

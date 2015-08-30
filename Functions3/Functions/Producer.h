//
//  Producer.h
//  Functions
//
//  Created by Erdi Kanık on 17/11/14.
//  Copyright (c) 2014 erdikanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMath.h"
#import "Util.h"
#import "AbstractFunction.h"




@interface Producer : NSObject

- (id) initWithProduceName:(NSString*) produceName;
- (CGFloat) parseFunctionFromName;
- (NSArray*) tupleParser: (NSString *) tuple;

@end

//
//  AbstractFunction.h
//  Functions
//
//  Created by Erdi Kanık on 12/01/15.
//  Copyright (c) 2015 erdikanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"

typedef NS_ENUM(NSUInteger, FunctionType)
{
    FunctionTypeRandom,
    FunctionTypeBinary,
    FunctionTypeFractional,
    FunctionTypePolynomal,
    FunctionTypeAbs
};

@interface AbstractFunction : NSObject

@property (assign, nonatomic) FunctionType ftype;
- (NSArray*) getValue:(NSArray*) valueArray;
- (CGFloat)resultValue:(CGFloat)numberValue;
- (BOOL)isResultPositive;

@end

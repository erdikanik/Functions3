//
//  FunctionBoxHolder.h
//  Functions3
//
//  Created by erdikanik on 8.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FSpriteNodeBase.h"
#import "AbstractFunction.h"

@interface FunctionBoxHolder : FSpriteNodeBase

@property (nonatomic, strong) AbstractFunction *currentFunction;
@property (nonatomic, assign) CGFloat functionSquareMargin;

- (instancetype)initWithFunctionSquareArray:(NSArray*)functionSquares withMargin:(CGFloat)functionSquareMargin;


@end

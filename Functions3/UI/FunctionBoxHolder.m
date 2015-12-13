//
//  FunctionBoxHolder.m
//  Functions3
//
//  Created by erdikanik on 8.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FunctionBoxHolder.h"
#import "FStyle.h"
#import "FunctionSquare.h"

@interface FunctionBoxHolder() <FunctionSquareDelegate>

@property (nonatomic, strong) NSArray *squareArray;

@end


@implementation FunctionBoxHolder


- (instancetype)initWithFunctionSquareArray:(NSArray*)functionSquares withMargin:(CGFloat)functionSquareMargin
{
    self = [super initWithColor:[FStyle fFunctionsHolderColor]  size:[self calculateSize:functionSquares]];
    if (self)
    {
        _squareArray = functionSquares;
        _functionSquareMargin = functionSquareMargin;
        [self fixFunctionSquaresOnSquare];
        [self setSize:[self calculateSize:functionSquares]];
    }
    return self;
}

- (CGSize)calculateSize:(NSArray*)fsqArray
{
    FunctionSquare* fsq = fsqArray.firstObject;
    CGFloat width = fsq.size.width + 2 * self.functionSquareMargin;
    CGFloat height = fsqArray.count * (fsq.size.height + self.functionSquareMargin) + self.functionSquareMargin;
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (void)fixFunctionSquaresOnSquare
{
    int i = 0;
    for (FunctionSquare *fsq in self.squareArray)
    {   fsq.delegate = self;
        CGFloat height = i * (fsq.size.height + self.functionSquareMargin) + self.functionSquareMargin;
        [fsq setPosition:CGPointMake(self.functionSquareMargin,height)];
        [self addChild:fsq];
        ++i;
    }
}

#pragma mark - FuntionSquareDelegate

- (void)functionSquarePressed:(FunctionSquare *)fSquare
{
    for (FunctionSquare *fsq in self.squareArray)
    {
        if (fsq != fSquare)
        {
            fsq.selected = NO;
        }
    }
    self.currentFunction = fSquare.function;
}

@end

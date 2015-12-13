//
//  FBoardLogic.m
//  Functions3
//
//  Created by erdikanik on 14.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FBoardLogic.h"
#import "FMath.h"

const NSUInteger kFBoardTotalWidthSquareNumber = 10;
const NSUInteger kFBoardGameOverSquareNumber = 21;


@interface FBoardLogic()

@end

@implementation FBoardLogic

- (CGFloat)numberEdgeSizes
{
    return self.boardSize.width / kFBoardTotalWidthSquareNumber;
}

- (CGPoint)fNumberStartPoint
{
    self.lastColumnNumber = [FMath getRandomGeneratorGivenRange:0 withSecond:kFBoardTotalWidthSquareNumber];
    CGFloat x = [self numberEdgeSizes] * self.lastColumnNumber;
    return CGPointMake(x,self.boardSize.height);
}

@end

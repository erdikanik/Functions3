//
//  FBoardLogic.h
//  Functions3
//
//  Created by erdikanik on 14.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSUInteger kFBoardTotalWidthSquareNumber;
extern const NSUInteger kFBoardGameOverSquareNumber;

@interface FBoardLogic : NSObject
@property (assign, nonatomic) CGSize boardSize;
@property (assign, nonatomic) NSUInteger lastColumnNumber;

- (CGFloat)numberEdgeSizes;
- (CGPoint)fNumberStartPoint;
@end

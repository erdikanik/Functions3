//
//  FBoard.h
//  Functions3
//
//  Created by erdikanik on 14.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FSpriteNodeBase.h"
#import "FunctionBoxHolder.h"

@protocol FBoardDelegate;

@interface FBoard : FSpriteNodeBase

@property (weak, nonatomic) id <FBoardDelegate>delegate;
@property (assign, nonatomic) NSUInteger level;

- (instancetype)initWithSize:(CGSize)size functionBoxHolder:(FunctionBoxHolder*)fbHolder;
- (void)initialize;

@end

@protocol FBoardDelegate <NSObject>

- (void)fBoardNumberTapped:(CGFloat)tappedNumber withResult:(CGFloat)resultNumber;
- (void)fBoardGameBorderExceeded;
@end
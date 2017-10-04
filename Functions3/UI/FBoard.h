//
//  FBoard.h
//  Functions3
//
//  Created by erdikanik on 14.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FSpriteNodeBase.h"

@protocol FBoardDelegate;

@interface FBoard : FSpriteNodeBase

@property (weak, nonatomic) id <FBoardDelegate>delegate;
@property (assign, nonatomic) NSUInteger level;

- (instancetype)initWithSize:(CGSize)size;
- (void)initialize;

@end

@protocol FBoardDelegate <NSObject>

- (void)fBoardNumberTapped:(double)tappedNumber withResult:(double)resultNumber;
- (void)fBoardGameBorderExceeded;
@end

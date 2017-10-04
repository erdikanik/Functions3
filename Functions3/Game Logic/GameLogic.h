//
//  GameLogic.h
//  Functions3
//
//  Created by erdikanik on 30.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNumber.h"
#import "Polynomal.h"

@protocol GameLogicDelegate;

@interface GameLogic : NSObject

@property (weak, nonatomic) id<GameLogicDelegate> delegate;
@property (assign, nonatomic) double number;
@property (assign, nonatomic) double score;

- (instancetype)initWithGameOverTime:(NSTimeInterval)initialTime;
- (void)gameStarted;
+ (FNumber*)getNumberFromLogic;

@end

@protocol GameLogicDelegate <NSObject>

- (void)timeUpdated:(GameLogic *)logic time:(NSTimeInterval)time gameOvered:(BOOL)gameOver;
- (void)functionResulted:(GameLogic *)logic functionResult:(double)result;
- (void)functionChanged:(GameLogic *)logic function:(Polynomal *)function;

@end

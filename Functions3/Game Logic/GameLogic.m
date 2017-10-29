//
//  GameLogic.m
//  Functions3
//
//  Created by erdikanik on 30.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "GameLogic.h"
#import "FMath.h"
#import "FunctionNumber.h"
#import "Functions.h"

const CGFloat kGameLogicWaitForDuration = 0.01;
const CGFloat kGameLogicRandomFunctionsDuration = 10;

@interface GameLogic()

@property (assign, nonatomic) NSTimeInterval initialTime;
@property (assign, nonatomic) NSTimeInterval scoreTime;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *methodTimer;
@property (assign, nonatomic) double totalNumber;
@property (strong, nonatomic) Polynomal *function;

@end

@implementation GameLogic

- (instancetype)initWithGameOverTime:(NSTimeInterval)initialTime
{
    self = [super init];
    if (self)
    {
        _initialTime = initialTime;
        _scoreTime = initialTime;
    }

    return self;
}

- (void)gameStarted {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:kGameLogicWaitForDuration repeats:YES block:^(NSTimer * _Nonnull timer) {
       if (self.scoreTime <= 0)
       {
           [self.timer invalidate];
           [self.delegate timeUpdated:self time:self.scoreTime gameOvered:YES];
       }
       else
       {
           self.scoreTime -= kGameLogicWaitForDuration;
           [self.delegate timeUpdated:self time:self.scoreTime gameOvered:NO];
       }
    }];

    [self initializeRandomFunctions];
}

- (void)setNumber:(double)number
{
    _number = number;
    _totalNumber = [self.function getPolynomalValue:_number];
    self.score += self.totalNumber > 0 ? self.totalNumber * 0.1 : 0;
    _scoreTime += _totalNumber * 0.5;
    [self.delegate functionResulted:self functionResult:_totalNumber];
}

#pragma mark - Functions

- (void)initializeRandomFunctions
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kGameLogicRandomFunctionsDuration
                                                 repeats:YES
                                                   block:^(NSTimer * _Nonnull timer) {
        [self getRandomFunction];
    }];
}

- (void)getRandomFunction
{
    self.function = [Functions getRandomFunction];
    [self.delegate functionChanged:self function:self.function];
}

+ (FNumber*)getNumberFromLogic
{
    CGFloat num = [FMath getRandomGeneratorGivenRange:0 withSecond:1000];
    
    if (num < 800)
    {
        FNumber *number = [[FNumber alloc] initWithNumber:[self getRandomNumber]];
        return number;
    }
    else if (num < 850)
    {
        FNumber *number = [[FNumber alloc] initWithType:FNumberTypeEmerald];
        return number;
    }
    else if (num < 900)
    {
        FNumber *number = [[FNumber alloc] initWithType:FNumberTypeDiamond];
        return number;
    }
    else if (num < 950)
    {
        FNumber *number = [[FNumber alloc] initWithType:FNumberTypeGolden];
        return number;
    }
    else if (num < 850)
    {
        FNumber *number = [[FNumber alloc] initBombTypeWithNumber:[self getRandomNumber]];
        return number;
    }
    else if (num < 900)
    {
        CGFloat num1 = [GameLogic getRandomNumber];
        CGFloat num2 = [GameLogic getRandomNumber];
        CGFloat num3 = [GameLogic getRandomNumber];
        NSArray *numberArray = [NSArray arrayWithObjects:_N(num1),_N(num2),_N(num3),nil];
        FNumber *number = [[FNumber alloc] initWithNumberArray:numberArray];
        return number;
    }
    else if (num < 940)
    {
        FNumber *number = [[FNumber alloc] initBombTypeWithNumber:[self getRandomNumber]];
        return number;
    }
    else
    {
        FNumber *number = [[FNumber alloc] initInvisibleNumber:[self getRandomNumber]];
        return number;
    }
    
}

+ (CGFloat)getRandomNumber
{
    return [FMath getRandomGeneratorGivenRange:-10 withSecond:9];
}

@end

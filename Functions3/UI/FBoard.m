//
//  FBoard.m
//  Functions3
//
//  Created by erdikanik on 14.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FBoard.h"
#import "FStyle.h"
#import "FBoardLogic.h"

#import "Functions3-Swift.h"

@interface FBoard()<SquareDelegate>

@property (strong, nonatomic) FBoardLogic *boardLogic;
@property (strong, nonatomic) NSMutableArray *numberColumns;
@property (assign ,nonatomic) BOOL exceed;

@end

@implementation FBoard

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithColor:[FStyle fMainDarkColor] size:size];
    if (self)
    {
        self.boardLogic = [FBoardLogic new];
        self.boardLogic.boardSize = size;
        self.numberColumns = [[NSMutableArray alloc] initWithCapacity:kFBoardTotalWidthSquareNumber];
        for (NSUInteger i = 0;i < kFBoardTotalWidthSquareNumber; ++i)
        {
            NSMutableArray *numberRows = [[NSMutableArray alloc] initWithCapacity:kFBoardTotalWidthSquareNumber];
            [self.numberColumns addObject:numberRows];
        }
        self.level = 1;
    }
    return self;
}

- (void)initialize
{
    [self runProduceRandomNumberWithWaitingTime];
}

- (void)runProduceRandomNumberWithWaitingTime
{
    CGFloat waitTime = 4 - self.level * 0.05 ;
    waitTime = waitTime < 0.2 ? 0.2 : waitTime;
    SKAction *wait = [SKAction waitForDuration:waitTime];
    SKAction *performSelector = [SKAction performSelector:@selector(produceRandomNumber) onTarget:self];
    SKAction *sequence   = [SKAction sequence:@[performSelector, wait]];
    SKAction *repeat   = [SKAction repeatAction:sequence count:1];
    [self runAction:repeat completion:^{
        [self runProduceRandomNumberWithWaitingTime];
    }];
}

- (void)produceRandomNumber
{
    /* Called when a touch begins */
    Square *square = [Square getRandomSquare];
    square.isMoving = YES;
    square.delegate = self;
    square.edge = [self.boardLogic numberEdgeSizes];
    square.position = [self.boardLogic fNumberStartPoint];
    NSUInteger lastNumber = self.boardLogic.lastColumnNumber;

    [self resetRowArrayWithLastNumber:lastNumber];
    
    [self addChild:square];
    
    [self calculateDestinationPointForNumber:lastNumber withNumber:square];
    CGFloat distance = fabs(square.moveToPoint.y - square.position.y);
    SKAction *liftoff = [SKAction moveTo:square.moveToPoint duration:[self calculateTimeWithDestionationWithDistance:distance]];
    SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
    [square runAction:rep completion:^{
        square.isMoving = NO;
    }];
}

- (void)calculateDestinationPointForNumber:(NSUInteger)columnNumber withNumber:(Square*)square
{
    NSMutableArray*numberRows = [self.numberColumns objectAtIndex:columnNumber];
    [numberRows addObject:square];
    NSUInteger numberIndex =  numberRows.count - 1;

    square.moveToPoint = CGPointMake(square.position.x,[self.boardLogic numberEdgeSizes] * numberIndex);
}

- (void)resetRowArrayWithLastNumber:(NSUInteger)lastNumber
{
    NSMutableArray*columnArray = [self.numberColumns objectAtIndex:self.boardLogic.lastColumnNumber];
    if(columnArray.count >= kFBoardGameOverSquareNumber && !self.exceed)
    {
        [self.delegate fBoardGameBorderExceeded];
        self.exceed = YES;
    }
}

- (void)reassignDestinationPointsAndMoveTo:(NSMutableArray*)array withNumberIndex:(NSInteger)index
{
    if(index + 1 >= array.count)
        return;
    
    for (NSInteger i=index + 1;i<array.count;++i)
    {
        Square *fNumber = [array objectAtIndex:i];
        fNumber.isMoving = YES;
        fNumber.moveToPoint = CGPointMake(fNumber.moveToPoint.x, fNumber.moveToPoint.y - [self.boardLogic numberEdgeSizes]);
        CGFloat distance = fabs(fNumber.moveToPoint.y - fNumber.position.y);
        SKAction *liftoff = [SKAction moveTo:fNumber.moveToPoint duration:[self calculateTimeWithDestionationWithDistance:distance]];
        SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
        [fNumber runAction:rep completion:^{
            fNumber.isMoving = NO;
        }];
    }
}

- (void)explodeSurroundingsNumbers:(NSMutableArray*)array withNumberIndex:(NSInteger)index
{
    NSUInteger columnIndex = [self.numberColumns indexOfObject:array];

    if (columnIndex > 0)
    {
        [self removeNumbersAtColumn:[self.numberColumns objectAtIndex:columnIndex - 1]
                    bombNumberIndex:index];
    }
    
    if (columnIndex < kFBoardTotalWidthSquareNumber - 1)
    {
        [self removeNumbersAtColumn:[self.numberColumns objectAtIndex:columnIndex + 1]
                    bombNumberIndex:index];
    }
    
    [self removeNumbersAtColumn:[self.numberColumns objectAtIndex:columnIndex]
                bombNumberIndex:index];
}

#pragma mark - Helpers

- (void)removeNumbersAtColumn:(NSMutableArray<Square *> *)numbers bombNumberIndex:(NSInteger)index
{
    [self removeFromColumnIfItIsNotMoving:numbers index:index + 1];
    [self removeFromColumnIfItIsNotMoving:numbers index:index];
    if (index > 0)
    {
        [self removeFromColumnIfItIsNotMoving:numbers index:index - 1];
    }
}

- (void)removeFromColumnIfItIsNotMoving:(NSMutableArray<Square *> *)numbers index:(NSInteger)index
{
    if (numbers.count <= index)
    {
        return;
    }
    
    Square *previousNumber = [numbers objectAtIndex:index];
    
    if (!previousNumber)
    {
        return;
    }
    
    if (!previousNumber.isMoving)
    {
        [previousNumber explodeNumberWith:^{
            [self reassignDestinationPointsAndMoveTo:numbers
                                     withNumberIndex:[numbers indexOfObject:previousNumber]];
            [numbers removeObject:previousNumber];
            [previousNumber removeFromParent];
        }];
    }
}

- (NSTimeInterval)calculateTimeWithDestionationWithDistance:(CGFloat)distance
{
    return distance / 60;
}

#pragma mark - SquareDelegate

- (void)squareTappedWithSquare:(Square *)square
{
    for (NSUInteger i = 0;i < kFBoardTotalWidthSquareNumber; ++i)
    {
        NSMutableArray* numberRows = [self.numberColumns objectAtIndex:i];
        if ([numberRows indexOfObject:square] != NSNotFound)
        {
            if (square.squareType == SquareTypeBomb && !square.isMoving)
            {
                [self explodeSurroundingsNumbers:numberRows withNumberIndex:[numberRows indexOfObject:square]];

                [square explodeNumberWith:^{
                    [self reassignDestinationPointsAndMoveTo:numberRows withNumberIndex:[numberRows indexOfObject:square]];
                    [numberRows removeObject:square];
                }];

                return;
                break;
            }

            [self reassignDestinationPointsAndMoveTo:numberRows withNumberIndex:[numberRows indexOfObject:square]];
            [numberRows removeObject:square];
            break;
        }
    }
    
    CGFloat result = 1 * square.number;
    [self.delegate fBoardNumberTapped:square.number withResult:result];
    
    [square removeFromParent];
}



@end

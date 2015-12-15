//
//  FBoard.m
//  Functions3
//
//  Created by erdikanik on 14.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FBoard.h"
#import "FStyle.h"
#import "FNumber.h"
#import "GameLogic.h"
#import "FBoardLogic.h"

@interface FBoard()<FNumberDelegate>

@property (strong, nonatomic) FBoardLogic *boardLogic;
@property (strong, nonatomic) NSMutableArray *numberColumns;
@property (strong, nonatomic) FunctionBoxHolder *fbHolder;
@property (assign ,nonatomic) BOOL exceed;

@end

@implementation FBoard

- (instancetype)initWithSize:(CGSize)size functionBoxHolder:(FunctionBoxHolder*)fbHolder
{
    self = [self initWithSize:size];
    if (self)
    {
        _fbHolder = fbHolder;
    }
    return self;
}

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithColor:[FStyle fBoardColor] size:size];
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
    CGFloat gameOverLineY = [self.boardLogic numberEdgeSizes] * kFBoardGameOverSquareNumber;
    FSpriteNodeBase *gameOverNode = [[FSpriteNodeBase alloc] initWithColor:[UIColor redColor] size:CGSizeMake(self.size.width , 1)];
    [self addChild:gameOverNode];
    gameOverNode.position = CGPointMake(0, gameOverLineY);
    
    SKLabelNode *gameOverLabelNode = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont]];
    [gameOverLabelNode setText:@"Game Over Border"];
    [gameOverLabelNode setFontColor:[UIColor redColor]];
    [gameOverLabelNode setFontSize:10];
    [gameOverLabelNode.scene setAnchorPoint:CGPointMake(0,0)];
    gameOverLabelNode.position = CGPointMake(10 + gameOverLabelNode.frame.size.width / 2, gameOverLineY - 10 );
    [self addChild:gameOverLabelNode];
    
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
    FNumber *fNumber = [GameLogic getNumberFromLogic];
    fNumber.delegate = self;
    fNumber.edge = [self.boardLogic numberEdgeSizes];
    fNumber.position = [self.boardLogic fNumberStartPoint];
    NSUInteger lastNumber = self.boardLogic.lastColumnNumber;
    
    [self resetRowArrayWithLastNumber:lastNumber];
    
    [self addChild:fNumber];
    
    [self calculateDestinationPointForNumber:lastNumber withNumber:fNumber];
    CGFloat distance = fabs(fNumber.moveToPoint.y - fNumber.position.y);
    SKAction *liftoff = [SKAction moveTo:fNumber.moveToPoint duration:[self calculateTimeWithDestionationWithDistance:distance]];
    SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
    [fNumber runAction:rep completion:nil];
}

- (void)calculateDestinationPointForNumber:(NSUInteger)columnNumber withNumber:(FNumber*)fNumber
{
    NSUInteger numberIndex = [self addAndLiftOff:fNumber indexNumber:columnNumber];
    fNumber.moveToPoint = CGPointMake(fNumber.position.x,[self.boardLogic numberEdgeSizes] * numberIndex);
}


- (CGFloat)addNumberToRow:(FNumber*)number column:(NSUInteger)column
{
    return [self addAndLiftOff:number indexNumber:column];
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

- (NSUInteger)addAndLiftOff:(FNumber*)number indexNumber:(NSUInteger)index
{
    NSMutableArray*numberRows = [self.numberColumns objectAtIndex:index];
    [numberRows addObject:number];
    return numberRows.count - 1;
}

- (void)reassignDestinationPointsAndMoveTo:(NSMutableArray*)array withNumberIndex:(NSInteger)index
{
    if(index + 1 >= array.count)
        return;
    
    for (NSInteger i=index + 1;i<array.count;++i)
    {
        FNumber *fNumber = [array objectAtIndex:i];
        fNumber.moveToPoint = CGPointMake(fNumber.moveToPoint.x, fNumber.moveToPoint.y - [self.boardLogic numberEdgeSizes]);
        CGFloat distance = fabs(fNumber.moveToPoint.y - fNumber.position.y);
        SKAction *liftoff = [SKAction moveTo:fNumber.moveToPoint duration:[self calculateTimeWithDestionationWithDistance:distance]];
        SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
        [fNumber runAction:rep completion:nil];
    }
}

#pragma mark - Helpers
- (CGFloat)bottomLiftOffY
{
    return -self.size.height + [self.boardLogic numberEdgeSizes] / 2;
}

- (CGFloat)liftForever
{
    return [self bottomLiftOffY] - 100;
}

- (NSTimeInterval)calculateTimeWithDestionationWithDistance:(CGFloat)distance
{
    CGFloat velocity = 40 * (1 + 0.4 * self.level);
    return distance / velocity;
}

#pragma mark - FNumberDelegate

- (void)fNumberPressed:(FNumber *)fNumber
{
    for (NSUInteger i = 0;i < kFBoardTotalWidthSquareNumber; ++i)
    {
        NSMutableArray*numberRows = [self.numberColumns objectAtIndex:i];
        if ([numberRows indexOfObject:fNumber] != NSNotFound)
        {
            [self reassignDestinationPointsAndMoveTo:numberRows withNumberIndex:[numberRows indexOfObject:fNumber]];
            [numberRows removeObject:fNumber];
            break;
        }
    }
    
    CGFloat result = self.fbHolder.currentValue * fNumber.number;
    [self.delegate fBoardNumberTapped:fNumber.number withResult:result];
    
    [fNumber removeFromParent];
}



@end

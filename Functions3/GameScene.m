//
//  GameScene.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "GameScene.h"
#import "FNumber.h"
#import "Functions.h"
#import "Polynomal.h"
#import "FStyle.h"
#import "AbsoluteValueFunction.h"
#import "ResultViewController.h"
#import "FunctionTopBar.h"

#import "Functions3-Swift.h"

static NSString* const kGameSceneInitialFunction1 = @"x + 9";
static NSString* const kGameSceneInitialFunction2 = @"-x + 9";

static const CGFloat kGameSceneTopBoardWidthFactor = 0.1;



@interface GameScene() < GameLogicDelegate, BoardDelegate>

@property (assign, nonatomic) NSInteger b1CurrentPath;
@property (assign, nonatomic) NSInteger b2CurrentPath;
@property (strong, nonatomic) NSMutableArray *currentNumbers;
@property (strong, nonatomic) NSMutableArray *currentFunctions;
@property (strong, nonatomic) SKLabelNode *labelNodePoint;
@property (strong, nonatomic) SKLabelNode *labelNodeFunction;
@property (strong, nonatomic) SKLabelNode *labelNodeGameOver;
@property (strong, nonatomic) SKLabelNode *labelNodeGameOverDetail;
@property (assign, nonatomic) CGFloat totalPoint;
@property (strong, nonatomic) Board *board;
@property (strong, nonatomic) FunctionTopBar *topBar;
@property (strong, nonatomic) GameLogic *gameLogic;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {

    self.gameLogic = [[GameLogic alloc] initWith:120];
    self.gameLogic.delegate = self;
    [self.gameLogic gameStarted];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    [self setSize:CGSizeMake(screenWidth, screenHeight)];
    [self setupUI];

}

#pragma mark - UI
- (void)setupUI
{
    [self setBackgroundColor:[FStyle fMainColor]];
    CGSize boardSize = CGSizeMake(self.size.width, self.size.height - kGameSceneTopBoardWidthFactor * self.size.height);

    _board = [[Board alloc] initWith:boardSize];
    self.board.position = CGPointMake(0,0);
    self.board.delegate = self;
    [self addChild:self.board];
    [self.board initialize];
    [self setupGameOverLabel];

    self.topBar = [[FunctionTopBar alloc] initWithSize:CGSizeMake(self.size.width, kGameSceneTopBoardWidthFactor * self.size.height)];
    self.topBar.position = CGPointMake(0,self.size.height - kGameSceneTopBoardWidthFactor * self.size.height);
    [self addChild:self.topBar];
    [self.topBar initialize];
}

- (void)setupGameOverLabel
{
    _labelNodeGameOver = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont]];
    [self.labelNodeGameOver setText:@"Game Over"];
    self.labelNodeGameOver.fontSize = 50;
    self.labelNodeGameOver.fontColor = [UIColor redColor];
    self.labelNodeGameOver.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    [self.labelNodeGameOver setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self.labelNodeGameOver setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [self addChild:self.labelNodeGameOver];
    [self.labelNodeGameOver setHidden:YES];
    
    _labelNodeGameOverDetail = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont]];
    [self.labelNodeGameOverDetail setText:@"Border Exceed."];
    self.labelNodeGameOverDetail.fontSize = 20;
    self.labelNodeGameOverDetail.fontColor = [UIColor redColor];
    self.labelNodeGameOverDetail.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.45);
    [self.labelNodeGameOverDetail setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self.labelNodeGameOverDetail setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [self addChild:self.labelNodeGameOverDetail];
    [self.labelNodeGameOverDetail setHidden:YES];
}

#pragma mark - UIHelpers

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    //SKSpriteNode* node = (SKSpriteNode *)[self childNodeWithName:kGameSceneblackBoxName];
    //[node setColor:[UIColor redColor]];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"scull"]) {
        
    }
}

- (void)fBoardGameBorderExceeded
{
    self.labelNodeGameOver.hidden = NO;
    self.labelNodeGameOverDetail.hidden = NO;
    self.labelNodeGameOverDetail.text = @"Border Exceed.";
    [self gameOvered];
}

#pragma mark GameLogicDelegate

- (void)gameLogic:(GameLogic *)gameLogic time:(NSTimeInterval)time gameOvered:(BOOL)gameOvered
{
    NSTimeInterval remainingTime = time < 0 ? 0 : time;
    [self.topBar updateTime:[NSString stringWithFormat:@"%.2f", remainingTime]];

    if (gameOvered)
    {
        [self gameOvered];
    }
}

- (void)gameLogic:(GameLogic *)gameLogic functionChanged:(Polynomal *)function
{
    [self.topBar updateFunction:[function description]];
}

- (void)gameLogic:(GameLogic *)gameLogic functionResulted:(NSInteger)result
{
    [self.topBar updateResult:(NSInteger)result];
    [self.topBar updateScore:[NSString stringWithFormat:@"%li", (long)gameLogic.score]];
}

#pragma mark - Navigation

- (void)gameOvered
{
    self.labelNodeGameOver.hidden = NO;
    self.labelNodeGameOverDetail.hidden = NO;
    self.labelNodeGameOverDetail.text = @"Time is Over.";

    [self performSelector:@selector(navigateToResultViewController) withObject:nil afterDelay:5];
}

- (void)navigateToResultViewController
{
    [self.sdelegate gameSceneOvered:@(self.totalPoint)];
}

#pragma mark - BoardDelegate

- (void)boardWithBoard:(Board *)board didTappedSquare:(Square * _Nonnull)didTappedSquare
{
    NSInteger tappedNumber = didTappedSquare.number;
    self.gameLogic.number = tappedNumber;
    [self.topBar updateNumber:[NSString stringWithFormat:@"%ld",tappedNumber]];

    self.labelNodePoint.text = @(self.totalPoint).stringValue;
    self.labelNodeFunction.text = [NSString stringWithFormat:@"f(%li)=%li",(NSInteger)tappedNumber,(NSInteger)0];
    if (self.totalPoint < 0)
    {
        self.labelNodeGameOver.hidden = NO;
        self.labelNodeGameOverDetail.hidden = NO;
        self.labelNodeGameOverDetail.text = @"Total Point is Negative.";
        [self gameOvered];
    }
}

@end

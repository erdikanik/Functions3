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
static const CGFloat kGameSceneStatusBarHeight = 25;


@interface GameScene() < GameLogicDelegate, BoardDelegate>

@property (assign, nonatomic) NSInteger b1CurrentPath;
@property (assign, nonatomic) NSInteger b2CurrentPath;
@property (strong, nonatomic) NSMutableArray *currentNumbers;
@property (strong, nonatomic) NSMutableArray *currentFunctions;
@property (strong, nonatomic) SKLabelNode *labelNodeGameOver;
@property (strong, nonatomic) SKLabelNode *labelNodeGameOverDetail;
@property (assign, nonatomic) NSInteger totalPoint;
@property (strong, nonatomic) Board *board;
@property (strong, nonatomic) FunctionTopBar *topBar;
@property (strong, nonatomic) GameLogic *gameLogic;

@property (strong, nonatomic) SKAudioNode *bombSound;
@property (strong, nonatomic) SKAudioNode *functionChangingSound;
@property (strong, nonatomic) SKAudioNode *gameOveredSound;
@property (strong, nonatomic) SKAudioNode *tappingSound;
@property (strong, nonatomic) SKAudioNode *themeSound;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    [self setSize:CGSizeMake(screenWidth, screenHeight)];
    [self setupUI];

    self.gameLogic = [[GameLogic alloc] initWith:30];
    self.gameLogic.delegate = self;
    [self.gameLogic gameStarted];
    
    [self installSounds];

}

#pragma mark - UI
- (void)setupUI
{
    [self setBackgroundColor:[FStyle fMainColor]];
    CGSize boardSize = CGSizeMake(self.size.width, self.size.height - kGameSceneTopBoardWidthFactor * self.size.height - kGameSceneStatusBarHeight);

    _board = [[Board alloc] initWith:boardSize];
    self.board.position = CGPointMake(0,0);
    self.board.delegate = self;
    [self addChild:self.board];
    [self.board initialize];
    [self setupGameOverLabel];

    self.topBar = [[FunctionTopBar alloc] initWithSize:CGSizeMake(self.size.width, kGameSceneTopBoardWidthFactor * self.size.height + kGameSceneStatusBarHeight)];
    self.topBar.position = CGPointMake(0,self.size.height - kGameSceneTopBoardWidthFactor * self.size.height - kGameSceneStatusBarHeight);
    [self addChild:self.topBar];
    [self.topBar initialize];
}

- (void)setupGameOverLabel
{
    _labelNodeGameOver = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont]];
    [self.labelNodeGameOver setText:@"Game Over"];
    self.labelNodeGameOver.fontSize = 70;
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

#pragma mark GameLogicDelegate

- (void)gameLogic:(GameLogic *)gameLogic time:(NSTimeInterval)time gameOvered:(BOOL)gameOvered
{
    NSTimeInterval remainingTime = time < 0 ? 0 : time;
    [self.topBar updateTime:[NSString stringWithFormat:@"%.2f", remainingTime]];

    if (gameOvered)
    {
        [self gameOvered:YES withTotalScore:self.gameLogic.score];
    }
}

- (void)gameLogic:(GameLogic *)gameLogic functionChanged:(Polynomal *)function
{
    [self.topBar updateFunction:[function description]];
    [self.functionChangingSound runAction:[SKAction play]];
}

- (void)gameLogic:(GameLogic *)gameLogic functionResulted:(NSInteger)result
{
    [self.topBar updateResult:(NSInteger)result];
    [self.topBar updateScore:[NSString stringWithFormat:@"%li", (long)gameLogic.score]];
}

- (void)gameLogic:(GameLogic *)gameLogic promotionChanged:(NSInteger)promotionNumber
{
    [self.topBar updateFunctionPromotionNumber:promotionNumber];
}

- (void)gameLogic:(GameLogic *)gameLogic functionTimeDidChanged:(float)time
{
    [self.topBar updateFunctionTimeText:[NSString stringWithFormat:@"%.2f", time]];
}

- (void)gameLogic:(GameLogic *)gameLogic levelChanged:(NSInteger)level
{
    self.board.timeThreshold += (level * 0.1);
}

#pragma mark - Navigation

- (void)gameOvered:(BOOL)isTimeOvered withTotalScore:(NSInteger)totalScore
{
    
    NSString *detailText = nil;
    
    detailText = isTimeOvered ? @"Time Passed!" : @"Into The Breach";
    
    self.labelNodeGameOver.hidden = NO;
    self.labelNodeGameOverDetail.hidden = NO;
    self.labelNodeGameOverDetail.text = detailText;

    self.totalPoint = totalScore;
    [self.themeSound runAction:[SKAction stop]];
    [self.gameOveredSound runAction:[SKAction play]];
    [self performSelector:@selector(navigateToResultViewController) withObject:nil afterDelay:5];
}

- (void)navigateToResultViewController
{
    [self.gameSceneDelegate gameSceneGameDidOvered:self.totalPoint];
}

#pragma mark - BoardDelegate

- (void)boardWithBoard:(Board *)board didTappedSquare:(Square * _Nonnull)didTappedSquare
{
    NSInteger tappedNumber = didTappedSquare.number;
    self.gameLogic.number = tappedNumber;
    [self.topBar updateNumber:[NSString stringWithFormat:@"%ld",tappedNumber]];
    
    [self.tappingSound runAction:[SKAction stop]];
    [self.tappingSound runAction:[SKAction play]];
    
    if (didTappedSquare.squareType == SquareTypeBomb)
    {
        [self.bombSound runAction:[SKAction stop]];
        [self.bombSound runAction:[SKAction play]];
    }
}

- (void)didExceedBorderWithBoard:(Board *)board
{
    [self gameOvered:NO withTotalScore:self.gameLogic.score];
}

#pragma mark - Sounds

- (void)installSounds
{
    self.bombSound = [[SKAudioNode alloc] initWithFileNamed:@"bomb.mp3"];
    self.functionChangingSound = [[SKAudioNode alloc] initWithFileNamed:@"functionChanged.mp3"];
    self.gameOveredSound = [[SKAudioNode alloc] initWithFileNamed:@"gameOvered.mp3"];
    self.tappingSound = [[SKAudioNode alloc] initWithFileNamed:@"tapped.mp3"];
    self.themeSound = [[SKAudioNode alloc] initWithFileNamed:@"theme.mp3"];
    
    self.themeSound.positional = NO;
    [self addChild:self.themeSound];
    
    self.tappingSound.autoplayLooped = NO;
    self.tappingSound.positional = NO;
    [self addChild:self.tappingSound];
    
    self.gameOveredSound.autoplayLooped = NO;
    [self addChild:self.gameOveredSound];
    
    self.bombSound.autoplayLooped = NO;
    [self addChild:self.bombSound];
    
    self.functionChangingSound.autoplayLooped = NO;
    [self addChild:self.functionChangingSound];
}

@end

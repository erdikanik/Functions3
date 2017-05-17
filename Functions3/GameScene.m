//
//  GameScene.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "GameScene.h"
#import "FNumber.h"
#import "GameLogic.h"
#import "FunctionSquare.h"
#import "Functions.h"
#import "Polynomal.h"
#import "FStyle.h"
#import "BlackBox.h"
#import "FunctionBoxHolder.h"
#import "FBoard.h"
#import "AbsoluteValueFunction.h"
#import "ResultViewController.h"

static NSString* const kGameSceneInitialFunction1 = @"x + 9";
static NSString* const kGameSceneInitialFunction2 = @"-x + 9";

static const CGFloat kGameSceneRightBoardWidthFactor = 0.3;



@interface GameScene() <FBoardDelegate>

@property (assign, nonatomic) NSInteger b1CurrentPath;
@property (assign, nonatomic) NSInteger b2CurrentPath;
@property (strong, nonatomic) NSMutableArray *currentNumbers;
@property (strong, nonatomic) NSMutableArray *currentFunctions;
@property (strong, nonatomic) SKLabelNode *labelNodePoint;
@property (strong, nonatomic) SKLabelNode *labelNodeFunction;
@property (strong, nonatomic) SKLabelNode *labelNodeGameOver;
@property (strong, nonatomic) SKLabelNode *labelNodeGameOverDetail;
@property (assign, nonatomic) CGFloat totalPoint;
@property (strong, nonatomic) FBoard *board;

@property (weak, nonatomic) FunctionSquare* fsquareNew;

@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    [self setSize:CGSizeMake(screenWidth, screenHeight)];
    [self setupUI];
    
    [self setBackgroundColor:[FStyle fMainColor]];
    CGSize boardSize = CGSizeMake(self.size.width - self.size.width * kGameSceneRightBoardWidthFactor, self.size.height);
    _board = [[FBoard alloc] initWithSize:boardSize functionBoxHolder:[self setupFunctionBoxHolder]];
    self.board.position = CGPointMake(0,0);
    self.board.delegate = self;
    [self addChild:self.board];
    [self.board initialize];
    [self setupGameOverLabel];
}

#pragma mark - UI
- (void)setupUI
{
    CGFloat rightBoardWidth = self.size.width * kGameSceneRightBoardWidthFactor;
    
    SKLabelNode *labelNodePointTitle = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont2]];
    [labelNodePointTitle setText:@"Point:"];
    
    labelNodePointTitle.fontSize = 20;
    labelNodePointTitle.fontColor = [FStyle fNumberTextColor];
    
    labelNodePointTitle.position = CGPointMake(self.size.width - rightBoardWidth * 0.9, self.size.height * 0.9);
    [labelNodePointTitle setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self addChild:labelNodePointTitle];
    
    _labelNodePoint = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont2]];
    [self.labelNodePoint setText:@(self.totalPoint).stringValue];
    
    self.labelNodePoint.fontSize = 17;
    self.labelNodePoint.fontColor = [FStyle fNumberTextColor];
    
    self.labelNodePoint.position = CGPointMake(self.size.width - rightBoardWidth * 0.9, self.size.height * 0.86);
    [self.labelNodePoint setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self addChild:self.labelNodePoint];

    
    _labelNodeFunction = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont2]];
    [self.labelNodeFunction setText:@"f(x) = x"];
    [self.labelNodeFunction setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    self.labelNodeFunction.fontSize = 15;
    self.labelNodeFunction.fontColor = [FStyle fNumberTextColor];
    
    self.labelNodeFunction.position = CGPointMake(self.size.width - rightBoardWidth * 0.9, self.size.height * 0.05);
    [self addChild:self.labelNodeFunction];
    
    [self setupFunctionBoxHolder];
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

- (FunctionBoxHolder*)setupFunctionBoxHolder
{
    CGFloat rightBoardWidth = self.size.width * kGameSceneRightBoardWidthFactor;

    
    FunctionSquare *fsquare1 = [[FunctionSquare alloc] initWithShapeType:FunctionShapeTypeCircle];
    FunctionSquare *fsquare2 = [[FunctionSquare alloc] initWithShapeType:FunctionShapeTypeTriangle];
    FunctionSquare *fsquare3 = [[FunctionSquare alloc] initWithShapeType:FunctionShapeTypeSquare];

    CGFloat fSquareRightBoardMargin = rightBoardWidth * 0.05;
    
    CGFloat fSquareWidthHeight = rightBoardWidth - 4 * fSquareRightBoardMargin;
    [fsquare1 setSize:CGSizeMake(fSquareWidthHeight , fSquareWidthHeight)];
    [fsquare2 setSize:CGSizeMake(fSquareWidthHeight , fSquareWidthHeight)];
    [fsquare3 setSize:CGSizeMake(fSquareWidthHeight , fSquareWidthHeight)];
    
    [fsquare1 updateShapeAndLabel];
    [fsquare2 updateShapeAndLabel];
    [fsquare3 updateShapeAndLabel];
    
    NSArray *fsqArray = [NSArray arrayWithObjects:fsquare1,fsquare2,fsquare3, nil];
    
    FunctionBoxHolder *fboxHolder = [[FunctionBoxHolder alloc] initWithFunctionSquareArray:fsqArray withMargin:fSquareRightBoardMargin];
    fsquare2.selected = YES;
    
    fboxHolder.position = CGPointMake(self.size.width - rightBoardWidth + fSquareRightBoardMargin , self.size.height / 4);
    [self addChild:fboxHolder];
    
    return fboxHolder;
}

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

#pragma mark - FBoardDelegate

- (void)fBoardNumberTapped:(CGFloat)tappedNumber withResult:(CGFloat)resultNumber
{
    self.totalPoint += resultNumber;
    self.labelNodePoint.text = @(self.totalPoint).stringValue;
    self.labelNodeFunction.text = [NSString stringWithFormat:@"f(%i)=%i",(NSInteger)tappedNumber,(NSInteger)resultNumber];
    if (self.totalPoint < 0)
    {
        self.labelNodeGameOver.hidden = NO;
        self.labelNodeGameOverDetail.hidden = NO;
        self.labelNodeGameOverDetail.text = @"Total Point is Negative.";
        [self gameOvered];
    }
    
    self.board.level = 10 + (NSInteger)self.totalPoint / 40;
}

- (void)fBoardGameBorderExceeded
{
    self.labelNodeGameOver.hidden = NO;
    self.labelNodeGameOverDetail.hidden = NO;
    self.labelNodeGameOverDetail.text = @"Border Exceed.";
    [self gameOvered];
}


#pragma mark - Navigation

- (void)gameOvered
{
    [self performSelector:@selector(navigateToResultViewController) withObject:nil afterDelay:5];
}

- (void)navigateToResultViewController
{
    [self.sdelegate gameSceneOvered:@(self.totalPoint)];
}

@end

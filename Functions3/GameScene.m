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

@property (strong, nonatomic) NSArray *bBoxDirections;
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

@property (weak, nonatomic) SKSpriteNode *bbox1;
@property (weak, nonatomic) SKSpriteNode *bbox2;

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
    
    SKLabelNode *labelNodePointTitle = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont]];
    [labelNodePointTitle setText:@"Point:"];
    
    labelNodePointTitle.fontSize = 20;
    labelNodePointTitle.fontColor = [FStyle fNumberTextColor];
    
    labelNodePointTitle.position = CGPointMake(self.size.width - rightBoardWidth * 0.9, self.size.height * 0.9);
    [labelNodePointTitle setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self addChild:labelNodePointTitle];
    
    _labelNodePoint = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont]];
    [self.labelNodePoint setText:@(self.totalPoint).stringValue];
    
    self.labelNodePoint.fontSize = 20;
    self.labelNodePoint.fontColor = [FStyle fNumberTextColor];
    
    self.labelNodePoint.position = CGPointMake(self.size.width - rightBoardWidth * 0.9, self.size.height * 0.85);
    [self.labelNodePoint setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self addChild:self.labelNodePoint];

    
    _labelNodeFunction = [[SKLabelNode alloc] initWithFontNamed:[FStyle fMainFont]];
    [self.labelNodeFunction setText:@"f(x) = x"];
    
    self.labelNodeFunction.fontSize = 15;
    self.labelNodeFunction.fontColor = [UIColor blackColor];
    
    self.labelNodeFunction.position = CGPointMake(self.size.width - rightBoardWidth * 0.5, self.size.height * 0.1);
    [self.labelNodeFunction setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
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
    
    self.board.level = 1 + (NSInteger)self.totalPoint / 40;
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

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
//    for (FNumber *fnumber in self.currentNumbers)
//    {
//        if ([self.bbox1 containsPoint:fnumber.position])
//        {
//            if (!fnumber.f1)
//            {
//                fnumber.f1 = YES;
//                fnumber.number = -9;
//                [self changeColorBox:[UIColor redColor] withBBox:self.bbox1];
//            }
//        }
//        
//        if ([self.bbox2 containsPoint:fnumber.position])
//        {
//            if (!fnumber.f2)
//            {
//                fnumber.f2 = YES;
//                fnumber.number = -10;
//                [self changeColorBox:[UIColor redColor] withBBox:self.bbox2];
//            }
//        }
//    
//    }
}


//-(void)newFunction
//{
//    /* Called before each frame is rendered */
//    // call function timer sequences
//    SKAction *wait = [SKAction waitForDuration:20];
//    SKAction *performSelector = [SKAction performSelector:@selector(createNewFunction) onTarget:self];
//    SKAction *sequence   = [SKAction sequence:@[performSelector, wait]];
//    SKAction *repeat   = [SKAction repeatAction:sequence count:1];
//    [self runAction:repeat completion:^{
//        [self newFunction];
//    }];
//}

//-(void)update
//{
//    /* Called before each frame is rendered */
//    // call function timer sequences
//    SKAction *wait = [SKAction waitForDuration:5.5];
//    SKAction *performSelector = [SKAction performSelector:@selector(produceRandomNumber) onTarget:self];
//    SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
//    SKAction *repeat   = [SKAction repeatAction:sequence count:10];
//    [self runAction:repeat completion:^{
//        [self update];
//    }];
//}


#pragma mark - UISetups

//- (void)staticGameScreenSetups
//{
//    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"gear"];
//    sprite.xScale = kGameSceneBigGearScaleFactor;
//    sprite.yScale = kGameSceneBigGearScaleFactor;
//    sprite.position = CGPointMake(kGameSceneBigGearPointX, kGameSceneBigGearPointY);
//    SKAction *action = [SKAction rotateByAngle:M_PI duration:kGameSceneGearDuration];
//    [sprite runAction:[SKAction repeatActionForever:action]];
//    [self addChild:sprite];
//    
//    SKSpriteNode *sprite2 = [SKSpriteNode spriteNodeWithImageNamed:@"gear"];
//    sprite2.xScale = kGameSceneSmallGearScaleFactor;
//    sprite2.yScale = kGameSceneSmallGearScaleFactor;
//    sprite2.position = CGPointMake(kGameSceneSmallGearPointX, kGameSceneSmallGearPointY);
//    SKAction *action2 = [SKAction rotateByAngle:-M_PI duration:kGameSceneGearDuration];
//    [sprite2 runAction:[SKAction repeatActionForever:action2]];
//    [self addChild:sprite2];
//
//    SKSpriteNode *scullSprite = [SKSpriteNode spriteNodeWithImageNamed:@"scull_g"];
//    [scullSprite setName:@"scull"];
//    scullSprite.xScale = 0.6;
//    scullSprite.yScale = 0.6;
//   [self addChild:scullSprite];
//    scullSprite.position = CGPointMake(348, 597);
//    SKAction *changeAction = [SKAction animateWithTextures:[NSArray arrayWithObjects:
//                                                            [SKTexture textureWithImageNamed:@"scull_g.png"],
//                                                            [SKTexture textureWithImageNamed:@"scull_m.png"],
//                                                            [SKTexture textureWithImageNamed:@"scull_r.png"],
//                                                            [SKTexture textureWithImageNamed:@"scull_y.png"], nil] timePerFrame:0.5 resize:YES restore:YES];
//    [scullSprite runAction:[SKAction repeatActionForever:changeAction]];
//    
//}

//- (void)produceRandomNumber
//{
//    /* Called when a touch begins */
//    FNumber *fNumber = [GameLogic getNumberFromLogic];
//    
//    fNumber.position = CGPointMake(66,710);
//    
//    [self addChild:fNumber];
//    
//    SKAction *liftoff = [SKAction moveByX:0 y:-2 * CGRectGetMidY(self.frame) duration: 5];
//    SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
//    [self.currentNumbers addObject:fNumber];
//    [fNumber runAction:rep completion:^{
//        
//    }];
//    
//}

//- (void)createNewFunction
//{
//    FunctionSquare *fsquare1 = [[FunctionSquare alloc] initWithFunction:[Functions getRandomFunction]  withColor:[FStyle getRandomColor]];
//    fsquare1.position = CGPointMake(kGameSceneNewFunctionX, kGameSceneNewFunctionY);
//    [self addChild:fsquare1];
//    self.fsquareNew = fsquare1;
//    SKAction *changeColor = [SKAction colorizeWithColor:fsquare1.color colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor2 = [SKAction colorizeWithColor:[UIColor clearColor] colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor3 = [SKAction colorizeWithColor:fsquare1.color colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor4 = [SKAction colorizeWithColor:[UIColor clearColor] colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor5 = [SKAction colorizeWithColor:fsquare1.color colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor6 = [SKAction colorizeWithColor:[UIColor clearColor] colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor7 = [SKAction colorizeWithColor:fsquare1.color colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor8 = [SKAction colorizeWithColor:[UIColor clearColor] colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor9 = [SKAction colorizeWithColor:fsquare1.color colorBlendFactor:0 duration:0.2];
//    SKAction *changeColor10 = [SKAction colorizeWithColor:[UIColor clearColor] colorBlendFactor:0 duration:0.2];
//    
//    SKAction *rep = [SKAction sequence:@[changeColor,changeColor2,changeColor3,changeColor4,changeColor5,changeColor6
//                                         ,changeColor7,changeColor8,changeColor9,changeColor10]];
//    SKAction* remove = [SKAction removeFromParent];
//    
//    SKAction* sequence = [SKAction sequence:@[rep,remove]];
//    [fsquare1 runAction:sequence];
//}
//
//- (void)changeColorBox:(UIColor *)curColor withBBox:(SKSpriteNode*)bbox
//{
//    SKAction *changeColor = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
//    SKAction *changeColor2 = [SKAction colorizeWithColor:curColor colorBlendFactor:0 duration:0.1];
//    SKAction *changeColor3 = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
//    SKAction *changeColor4 = [SKAction colorizeWithColor:curColor colorBlendFactor:0 duration:0.1];
//    SKAction *changeColor5 = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
//    SKAction *changeColor6 = [SKAction colorizeWithColor:curColor colorBlendFactor:0 duration:0.1];
//    SKAction *changeColor7 = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
//    
//    SKAction *rep = [SKAction sequence:@[changeColor,changeColor2,changeColor3,changeColor4,changeColor5,changeColor6,changeColor7]];
//    
//    [bbox runAction:rep];
//}



@end

//
//  FunctionTopBar.m
//  Functions3
//
//  Created by Erdi Kanık on 27.06.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "FunctionTopBar.h"
#import "FStyle.h"
#import "FunctionBoard.h"

const CGFloat functionBoardWidthFactor = 0.3;
const CGFloat functionBoardHeightFactor = 0.7;
const CGFloat functionBoardPositionXFactor = 0.4;
const CGFloat functionBoardPositionYFactor = 0.1;

@interface FunctionTopBar()

@property (nonatomic,strong) SKLabelNode *timeLabel;
@property (nonatomic, strong) SKLabelNode *resultLabel;
@property (nonatomic, strong) SKLabelNode *numberLabel;
@property (nonatomic, strong) FunctionBoard *board;
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, assign) SKAction *timeLabelAction;
@property (nonatomic, strong) SKLabelNode *scoreLabel;

@property (nonatomic, strong) SKLabelNode *goldenCounterLabel;
@property (nonatomic, strong) SKLabelNode *emeraldCounterLabel;
@property (nonatomic, strong) SKLabelNode *diamondCounterLabel;

@end

@implementation FunctionTopBar

- (instancetype)initWithSize:(CGSize)size {

    self = [super initWithColor:[FStyle fMainColor] size:size];
    
    if (self)
    {
        self.zPosition = 1;
    }
    
    return self;
}

- (void)initialize {
    [self createFunctionLabel];
    [self createTimeLabel];
}

- (void)createFunctionLabel {
    self.board = [[FunctionBoard alloc] initWithSize:
                            CGSizeMake(self.size.width * functionBoardWidthFactor, self.size.height * functionBoardHeightFactor) functionText:@"x^2 + 5c + 67"];
    
    [self.board initialize];
    [self addChild:self.board];
    self.board.position = CGPointMake(self.size.width * functionBoardPositionXFactor, self.size.height * functionBoardPositionYFactor);

    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont2]];
    [self.scoreLabel setFontSize:10];

    self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.scoreLabel];
    self.scoreLabel.text = @"Score: 1200";
    self.scoreLabel.fontColor = [FStyle fNumberTextColor];
    self.scoreLabel.position = CGPointMake(self.size.width * 0.75, self.size.height * 0.85);

    FSpriteNodeBase *rightArrow = [[FSpriteNodeBase alloc] initWithImageNamed:@"arrow"];
    rightArrow.userInteractionEnabled = NO;
    [rightArrow setScale:0.6];
    [self addChild:rightArrow];
    
    rightArrow.position = CGPointMake(self.size.width * 0.7, self.size.height * 0.2);
    
    self.numberLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.numberLabel setFontSize:25];
    
    self.numberLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.numberLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.numberLabel];
    self.numberLabel.text = @"120";
    self.numberLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.numberLabel setPosition:CGPointMake(self.size.width * 0.87, self.size.height * 0.4)];
    
    self.resultLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.resultLabel setFontSize:25];
    self.resultLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.resultLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.resultLabel];
    self.resultLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.resultLabel setPosition:CGPointMake(self.size.width * 0.04, self.size.height * 0.4)];
    
    FSpriteNodeBase *gameOverNode = [[FSpriteNodeBase alloc] initWithColor:[FStyle fNumberTextColor] size:CGSizeMake(self.size.width , 1)];
    [self addChild:gameOverNode];
    gameOverNode.position = CGPointZero;

    // TODO: Add next stage
    //[self addJevels];
}

- (void)addJevels
{
    FSpriteNodeBase *goldenLabelNode = [[FSpriteNodeBase alloc] initWithImageNamed:@"golden"];
    [goldenLabelNode setScale:0.3];
    goldenLabelNode.userInteractionEnabled = NO;
    [self addChild:goldenLabelNode];
    [goldenLabelNode setPosition:CGPointMake(self.size.width * 0.35, self.size.height * 0.1)];
    
    FSpriteNodeBase *diamonLabelNode = [[FSpriteNodeBase alloc] initWithImageNamed:@"diamond"];
    [diamonLabelNode setScale:0.3];
    diamonLabelNode.userInteractionEnabled = NO;
    [self addChild:diamonLabelNode];
    [diamonLabelNode setPosition:CGPointMake(self.size.width * 0.35, self.size.height * 0.35)];
    
    FSpriteNodeBase *emeraldLabelNode = [[FSpriteNodeBase alloc] initWithImageNamed:@"emerald"];
    [emeraldLabelNode setScale:0.3];
    emeraldLabelNode.userInteractionEnabled = NO;
    [self addChild:emeraldLabelNode];
    [emeraldLabelNode setPosition:CGPointMake(self.size.width * 0.35, self.size.height * 0.6)];
    
    
    self.goldenCounterLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.goldenCounterLabel setFontSize:10];
    self.goldenCounterLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.goldenCounterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:self.goldenCounterLabel];
    self.goldenCounterLabel.text = @"55555 x";
    self.goldenCounterLabel.fontColor = [FStyle fNumberTextColor];
    [self.goldenCounterLabel setPosition:CGPointMake(self.size.width * 0.33, self.size.height * 0.1)];
    
    
    self.diamondCounterLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.diamondCounterLabel setFontSize:10];
    self.diamondCounterLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.diamondCounterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:self.diamondCounterLabel];
    self.diamondCounterLabel.text = @"55555 x";
    self.diamondCounterLabel.fontColor = [FStyle fNumberTextColor];
    [self.diamondCounterLabel setPosition:CGPointMake(self.size.width * 0.33, self.size.height * 0.35)];
    
    self.emeraldCounterLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.emeraldCounterLabel setFontSize:10];
    self.emeraldCounterLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.emeraldCounterLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:self.emeraldCounterLabel];
    self.emeraldCounterLabel.text = @"55555 x";
    self.emeraldCounterLabel.fontColor = [FStyle fNumberTextColor];
    [self.emeraldCounterLabel setPosition:CGPointMake(self.size.width * 0.33, self.size.height * 0.6)];
}

- (void)createTimeLabel {
    self.timeLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont2]];
    [self.timeLabel setFontSize:12];
    
    self.timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.timeLabel];
    self.timeLabel.text = @"1200 seconds";
    self.timeLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.timeLabel setPosition:CGPointMake(self.size.width * 0.04 , self.size.height * 0.7)];
}

- (void)updateFunction:(NSString *)functionText
{
    self.board.text = functionText;
}

- (void)updateTime:(NSString *)time
{
    self.timeLabel.text = time;
}

- (void)updateResult: (NSInteger)result
{
    self.result = result;
    self.resultLabel.text = @(result).stringValue;

    if (result != 0)
    {
        [self.timeLabel removeAllActions];

        SKAction *performAction = [SKAction performSelector:@selector(changeTimeLabeColor) onTarget:self];
        SKAction *sequence   = [SKAction sequence:@[performAction, [SKAction waitForDuration:0.5]]];
        [self.timeLabel runAction:sequence completion:^{
            self.timeLabel.fontColor = [FStyle fNumberTextColor];
        }];
    }

    SKAction *fadeIn = [SKAction fadeInWithDuration:0.5];
    SKAction *wait = [SKAction waitForDuration:0.5];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.5];
    SKAction *sequence   = [SKAction sequence:@[fadeIn, wait, fadeOut]];

    [self.resultLabel runAction:sequence];
}

- (void)updateNumber: (NSString *)number
{
    self.numberLabel.text = number;
}

- (void)updateScore: (NSString *)score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@",score ];
}

- (void)updateFunctionTimeText:(NSString *)timeText
{
    self.board.timeText = timeText;
}

#pragma mark - Helpers

- (void)changeTimeLabeColor
{
    UIColor *timeColor = self.result < 0 ? [UIColor redColor] : [UIColor blueColor];
    self.timeLabel.fontColor = timeColor;
}

@end

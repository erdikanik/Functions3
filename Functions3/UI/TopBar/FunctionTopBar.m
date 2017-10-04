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
const CGFloat functionBoardHeightFactor = 0.8;
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

@end

@implementation FunctionTopBar

- (instancetype)initWithSize:(CGSize)size {

    self = [super initWithColor:[FStyle fMainColor] size:size];
    
    if (self)
    {
        
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
    
    rightArrow.position = CGPointMake(self.size.width * 0.7, self.size.height * 0.1);
    
    self.numberLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.numberLabel setFontSize:25];
    
    self.numberLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.numberLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.numberLabel];
    self.numberLabel.text = @"120";
    self.numberLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.numberLabel setPosition:CGPointMake(self.size.width * 0.87, self.size.height * 0.3)];
    
    self.resultLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.resultLabel setFontSize:25];
    self.resultLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.resultLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.resultLabel];
    self.resultLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.resultLabel setPosition:CGPointMake(self.size.width * 0.04, self.size.height * 0.3)];
    
    FSpriteNodeBase *gameOverNode = [[FSpriteNodeBase alloc] initWithColor:[UIColor redColor] size:CGSizeMake(self.size.width , 1)];
    [self addChild:gameOverNode];
    gameOverNode.position = CGPointZero;
}

- (void)createTimeLabel {
    self.timeLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont2]];
    [self.timeLabel setFontSize:20];
    
    self.timeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.timeLabel];
    self.timeLabel.text = @"1200 seconds";
    self.timeLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.timeLabel setPosition:CGPointMake(self.size.width * 0.04 , self.size.height * 0.8)];
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

#pragma mark - Helpers

- (void)changeTimeLabeColor
{
    UIColor *timeColor = self.result < 0 ? [UIColor redColor] : [UIColor blueColor];
    self.timeLabel.fontColor = timeColor;
}

@end

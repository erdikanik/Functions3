//
//  FunctionTopBar.m
//  Functions3
//
//  Created by Erdi Kanık on 27.06.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "FunctionTopBar.h"
#import "FStyle.h"

#import "Functions3-Swift.h"

const CGFloat functionBoardWidthFactor = 0.3;
const CGFloat functionBoardHeightFactor = 0.6;
static
const CGFloat functionBoardPositionXFactor = 0.4;
const CGFloat functionBoardPositionYFactor = 0.1;

@interface FunctionTopBar()

@property (nonatomic,strong) SKLabelNode *timeLabel;
@property (nonatomic, strong) SKLabelNode *numberLabel;
@property (nonatomic, strong) SKLabelNode *resultLabel;
@property (nonatomic, assign) NSInteger result;
@property (nonatomic, assign) SKAction *timeLabelAction;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, strong) SKLabelNode *methodName;

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

    self.methodName = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Bold"];
    [self.methodName setFontSize:18];
    self.methodName.fontColor = [FStyle fNumberTextColor];
    [self addChild:self.methodName];
    [self.methodName setPosition:CGPointMake(self.size.width * 0.5, self.size.height * 0.5)];
    self.methodName.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.methodName.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.methodName.text = @"GREATER THAN 20";
    
    self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont2]];
    [self.scoreLabel setFontSize:14];

    self.scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.scoreLabel];
    self.scoreLabel.text = @"Score: 0";
    self.scoreLabel.fontColor = [FStyle fNumberTextColor];
    self.scoreLabel.position = CGPointMake(self.size.width * 0.75, self.size.height * 0.70);
    
    self.resultLabel = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Bold"];
    [self.resultLabel setFontSize:20];
    
    self.resultLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.resultLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.resultLabel];
    self.resultLabel.text = @"0";
    self.resultLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.resultLabel setPosition:CGPointMake(self.size.width * 0.87, self.size.height * 0.4)];
    
    self.numberLabel = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Bold"];
    [self.numberLabel setFontSize:20];
    self.numberLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.numberLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.numberLabel];
    self.numberLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.numberLabel setPosition:CGPointMake(self.size.width * 0.04, self.size.height * 0.4)];
    
    FSpriteNodeBase *gameOverNode = [[FSpriteNodeBase alloc] initWithColor:[FStyle fNumberTextColor] size:CGSizeMake(self.size.width , 1)];
    [self addChild:gameOverNode];
    gameOverNode.position = CGPointZero;
}

- (void)createTimeLabel {
    self.timeLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont2]];
    [self.timeLabel setFontSize:14];
    
    self.timeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    [self addChild:self.timeLabel];
    self.timeLabel.text = @"999999999";
    self.timeLabel.fontColor = [FStyle fNumberTextColor];
    
    [self.timeLabel setPosition:CGPointMake(self.size.width * 0.04 , self.size.height * 0.7)];
}

- (void)updateFunction:(NSString *)functionText
{
    // use it
}

- (void)updateTime:(NSString *)time
{
    self.timeLabel.text = [NSString stringWithFormat:@"Time: %@", time];
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
}

- (void)updateNumber: (NSString *)number
{
    self.numberLabel.text = number;
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.5];
    SKAction *wait = [SKAction waitForDuration:0.5];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.5];
    SKAction *sequence   = [SKAction sequence:@[fadeIn, wait, fadeOut]];
    
    [self.numberLabel runAction:sequence];
}

- (void)updateScore: (NSString *)score
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@",score ];
}

- (void)updateFunctionTimeText:(NSString *)timeText
{
}

- (void)updateFunctionPromotionNumber:(NSInteger)promotionNumber
{
}

#pragma mark - Helpers

- (void)changeTimeLabeColor
{
    UIColor *timeColor = self.result < 0 ? [UIColor redColor] : [UIColor blueColor];
    self.timeLabel.fontColor = timeColor;
}

@end

//
//  FunctionNumber.m
//  Functions3
//
//  Created by Erdi Kanik on 21/05/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "FunctionNumber.h"
#import "FStyle.h"
#import "Producer.h"
#import "Polynomal.h"
#import "Functions.h"

static const CGFloat kFunctionNumberLabelPositionMarginFactor = 0.05;
static const CGFloat kFunctionNumberLabelFontSizeFactor = 0.23;
static const CGFloat kFunctionNumberEdgeNumber = 4;

@interface FunctionNumber()

@property (strong, nonatomic) SKLabelNode *leftLabel;
@property (strong, nonatomic) SKLabelNode *rightLabel;
@property (strong, nonatomic) SKLabelNode *topLabel;
@property (strong, nonatomic) SKLabelNode *bottomLabel;

/**
 Holds polynomal functions - left * right * top * bottom
 */
@property (strong, nonatomic) NSArray<Polynomal *> *polynomals;


@end

@implementation FunctionNumber

- (instancetype)init
{
    if (self = [super init])
    {
        self.fType = FNumberTypeFunctions;
    }

    return self;
}

- (void)initialize
{
    [super initialize];

    NSMutableArray<Polynomal *> *polynomals = [NSMutableArray new];

    for (int i = 0; i < kFunctionNumberEdgeNumber; ++i )
    {
        [polynomals addObject:[Functions getRandomFunction]];
    }

    self.polynomals = [polynomals copy];

    self.leftLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    self.rightLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    self.topLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    self.bottomLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];

    [self.leftLabel.scene setAnchorPoint:CGPointMake(0,0)];
    [self.rightLabel.scene setAnchorPoint:CGPointMake(0,0)];
    [self.topLabel.scene setAnchorPoint:CGPointMake(0,0)];
    [self.bottomLabel.scene setAnchorPoint:CGPointMake(0,0)];

    [self applyLabelStylesAndProperties:self.topLabel];
    [self applyLabelStylesAndProperties:self.bottomLabel];
    [self applyLabelStylesAndProperties:self.leftLabel];
    [self applyLabelStylesAndProperties:self.rightLabel];

    self.leftLabel.text = [polynomals[0] description];
    self.rightLabel.text = [polynomals[1] description];
    self.topLabel.text = [polynomals[2] description];
    self.bottomLabel.text = [polynomals[3] description];

    self.leftLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.leftLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    self.leftLabel.position =
    CGPointMake(self.size.width * kFunctionNumberLabelPositionMarginFactor, self.size.height / 2);

    self.rightLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.rightLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    self.rightLabel.position =
    CGPointMake(self.size.width * (1 - kFunctionNumberLabelPositionMarginFactor),
                self.size.height / 2);

    self.topLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    self.topLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.topLabel.position =
    CGPointMake(self.size.width / 2, self.size.height * (1 - kFunctionNumberLabelPositionMarginFactor));

    self.bottomLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    self.bottomLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.bottomLabel.position =
    CGPointMake(self.size.width / 2, self.size.height * kFunctionNumberLabelPositionMarginFactor);

    [self addChild:self.leftLabel];
    [self addChild:self.rightLabel];
    [self addChild:self.topLabel];
    [self addChild:self.bottomLabel];

    self.innerLabel.text = @"";

    self.tile.fillColor = [FStyle fFunctionsHolderColor];
}

- (void)applyLabelStylesAndProperties:(SKLabelNode *)labelNode
{
    [labelNode.scene setAnchorPoint:CGPointMake(0,0)];
    labelNode.fontSize = self.size.height * kFunctionNumberLabelFontSizeFactor;
    labelNode.fontColor = [FStyle fNumberTextColor];
}

@end

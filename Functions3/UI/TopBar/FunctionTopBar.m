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
    FunctionBoard *board = [[FunctionBoard alloc] initWithSize:
                            CGSizeMake(self.size.width * functionBoardWidthFactor, self.size.height * functionBoardHeightFactor) functionText:@"x^2 + 5c + 67"];
    
    [board initialize];
    [self addChild:board];
    board.position = CGPointMake(self.size.width * functionBoardPositionXFactor, self.size.height * functionBoardPositionYFactor);
    
    FSpriteNodeBase *leftArrow = [[FSpriteNodeBase alloc] initWithImageNamed:@"arrow"];
    leftArrow.userInteractionEnabled = NO;
    [leftArrow setScale:0.6];
    [self addChild:leftArrow];
    
    leftArrow.position = CGPointMake(self.size.width * 0.2, self.size.height * 0.1);
    
    FSpriteNodeBase *rightArrow = [[FSpriteNodeBase alloc] initWithImageNamed:@"arrow"];
    rightArrow.userInteractionEnabled = NO;
    [rightArrow setScale:0.6];
    [self addChild:rightArrow];
    
    rightArrow.position = CGPointMake(self.size.width * 0.7, self.size.height * 0.1);
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

@end

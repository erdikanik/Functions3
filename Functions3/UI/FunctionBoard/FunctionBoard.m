//
//  FunctionBoard.m
//  Functions3
//
//  Created by Erdi Kanık on 4.09.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "FunctionBoard.h"
#import "FStyle.h"

@interface FunctionBoard()

@property (nonatomic, strong) NSString *text;
@property (nonatomic,strong) SKLabelNode *leftFunctionLabel;
@property (nonatomic,strong) SKLabelNode *nameLabel;
@property (strong, nonatomic) SKShapeNode *tile;

@end

@implementation FunctionBoard

- (instancetype)initWithSize:(CGSize)size functionText:(NSString *)text {
    
    self = [super initWithColor:[UIColor blackColor] size:size];
    
    if (self)
    {
        _text = text;
    }
    
    return self;
}

- (void)initialize {
    self.tile = [SKShapeNode node];
    [self.tile setPath:CGPathCreateWithRoundedRect(CGRectMake(0, 0, self.size.width, self.size.height), 5, 5, nil)];
    self.tile.strokeColor = self.tile.fillColor = self.color;
    self.tile.strokeColor = [FStyle fNumberTextColor];
    self.color = UIColor.clearColor;
    
    [self addChild:self.tile];
    
    self.nameLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont2]];
    [self.nameLabel setFontSize:10];
    
    self.nameLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.nameLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [self addChild:self.nameLabel];
    self.nameLabel.text = @"Black Box";
    self.nameLabel.fontColor = [UIColor whiteColor];
    
    [self.nameLabel setPosition:CGPointMake(self.size.width * 0.5 , self.size.height * 0.8)];

    
    self.leftFunctionLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont2]];
    [self.leftFunctionLabel setFontSize:15];
    
    self.leftFunctionLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.leftFunctionLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [self addChild:self.leftFunctionLabel];
    self.leftFunctionLabel.text = self.text;
    self.leftFunctionLabel.fontColor = [UIColor whiteColor];
    
    [self.leftFunctionLabel setPosition:CGPointMake(self.size.width * 0.5 , self.size.height * 0.3)];
}

@end

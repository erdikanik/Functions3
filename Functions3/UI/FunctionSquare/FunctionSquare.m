//
//  FunctionSquare.m
//  Functions
//
//  Created by Erdi Kanık on 12/01/15.
//  Copyright (c) 2015 erdikanik. All rights reserved.
//

/*
    Fonksiyonların isimlerinin bulunduğu diktörtgensel yapı
 */

#import "FunctionSquare.h"
#import "FStyle.h"

@interface FunctionSquare()
@property (nonatomic,copy) NSString *text;
@property (nonatomic,strong) SKLabelNode *innerLabel;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) FSpriteNodeBase *shape;
@property (nonatomic, assign) FunctionShapeType shapeType;
@end

@implementation FunctionSquare


- (id) initWithShapeType:(FunctionShapeType)shapeType {
    if (self = [super initWithColor:[FStyle fBoardColor] size:CGSizeMake(0,0)]) {
        _shapeType = shapeType;
        _currentColor = [FStyle fBoardColor];
        self.innerLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
        [self.innerLabel setFontSize:14];
        [self.innerLabel setColor:[UIColor blackColor]];
        [self.innerLabel setText:self.text];
        [self addChild:self.innerLabel];
        _shape = [self addShape];
        self.innerLabel.text = [self getFunctionNameForShape];
    }
    return self;
}

- (void)setSize:(CGSize)size
{
    [super setSize:size];
    [self.innerLabel setPosition:CGPointMake(self.size.width / 2, self.size.height/2)];
    self.shape.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.25);
}

- (CGFloat)calculate:(CGFloat)val {
    switch (self.shapeType) {
        case FunctionShapeTypeSquare:
            return val;
        case FunctionShapeTypeTriangle:
            return 0;
        case FunctionShapeTypeCircle:
            return -1 * val;
    }
}

- (CGFloat)currentValue
{
    switch (self.shapeType) {
        case FunctionShapeTypeSquare:
            return 1;
        case FunctionShapeTypeTriangle:
            return 0;
        case FunctionShapeTypeCircle:
            return -1;
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected)
    {
        [self setColor:[UIColor blackColor]];
        [self.delegate functionSquarePressed:self];
    }
    else
    {
        [self reset];
    }
}

- (FSpriteNodeBase*)addShape
{
    FSpriteNodeBase *labelNode = [[FSpriteNodeBase alloc] initWithImageNamed:[self getImageNameForShape]];
    [labelNode setScale:0.8];
    labelNode.position = CGPointMake(self.size.width * 0.25, self.size.height * 0.25);
    labelNode.userInteractionEnabled = NO;
    [self addChild:labelNode];
    return labelNode;
}

- (NSString*)getImageNameForShape
{
    switch (self.shapeType) {
        case FunctionShapeTypeSquare:
            return @"square";
        case FunctionShapeTypeTriangle:
            return @"triangle";
        case FunctionShapeTypeCircle:
            return @"circle";
    }
}

- (NSString*)getFunctionNameForShape
{
    switch (self.shapeType) {
        case FunctionShapeTypeSquare:
            return @"x";
        case FunctionShapeTypeTriangle:
            return @"";
        case FunctionShapeTypeCircle:
            return @"-x";
    }
}

- (void)reset
{
    [self setColor:self.currentColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
}

@end

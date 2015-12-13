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
@end

@implementation FunctionSquare


- (id) initWithFunction: (AbstractFunction *) func withColor:(UIColor*) funcColor {
    self.text = [func description];
    if (self = [super initWithColor:funcColor size:CGSizeMake(0,0)]) {
        self.currentColor = funcColor;
        self.innerLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
        [self.innerLabel setFontSize:14];
        [self.innerLabel setColor:[UIColor blackColor]];
        [self.innerLabel setText:self.text];
        [self addChild:self.innerLabel];
        _function = func;
    }
    return self;
}

- (void)setSize:(CGSize)size
{
    [super setSize:size];
    [self.innerLabel setPosition:CGPointMake(self.size.width / 2, self.size.height/2)];
}

- (CGFloat)calculateFunction:(CGFloat)val {
    CGFloat returnVal = 0;
    if (self.function.ftype == FunctionTypePolynomal) {
        Polynomal *poly = (Polynomal*) self;
        returnVal = [poly getPolynomalValue:val];
    }
    return returnVal;
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

- (void)reset
{
    [self setColor:self.currentColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
}

@end

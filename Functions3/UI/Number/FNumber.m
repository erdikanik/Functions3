//
//  FNumber.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FNumber.h"
#import "FStyle.h"
#import "Producer.h"

static const CGFloat kFNumberSize = 30;
static const CGFloat kFNumberFontSizeFactor = 0.5;
static const CGFloat kFNumberWaitForDuration = 1;

@interface FNumber()

@property (strong, nonatomic) SKLabelNode* innerLabel;
@property (strong, nonatomic) NSArray *numberArray;
@property (assign, nonatomic) FNumberType fType;
@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic,getter=isInvisible) BOOL invisible;
@end

@implementation FNumber


- (instancetype)initWithNumber:(CGFloat)number
{
    if (self = [super initWithColor:[FStyle fNumberColor] size:CGSizeMake(kFNumberSize,kFNumberSize)])
    {
        self.number = number;
        self.fType = FNumberTypeNormal;
    }
    return self;
}

- (instancetype)initWithNumberArray:(NSArray*)arr
{
    if (self = [super initWithColor:[UIColor yellowColor] size:CGSizeMake(kFNumberSize,kFNumberSize)])
    {
        self.counter = 0;
        self.numberArray = arr;
        self.number = [[arr objectAtIndex:0] floatValue];
        self.fType = FNumberTypeChageAble;
        
        // call function timer sequences
        SKAction *wait = [SKAction waitForDuration:kFNumberWaitForDuration];
        SKAction *performSelector = [SKAction performSelector:@selector(fNumberEvents) onTarget:self];
        SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
        SKAction *repeat   = [SKAction repeatActionForever:sequence];
        [self runAction:repeat];
    }
    return self;
}

- (instancetype)initInvisibleNumber:(CGFloat)number
{
    if (self = [super initWithColor:[FStyle fNumberColor] size:CGSizeMake(kFNumberSize,kFNumberSize)])
    {
        self.number = number;
        self.fType = FNumberTypeInvisible;
        
        // call function timer sequences
        SKAction *wait = [SKAction waitForDuration:kFNumberWaitForDuration];
        SKAction *performSelector = [SKAction performSelector:@selector(fNumberEvents) onTarget:self];
        SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
        SKAction *repeat   = [SKAction repeatActionForever:sequence];
        [self runAction:repeat];
    }
    return self;
}

#pragma mark - Properties

- (void)fNumberEvents
{
    if (self.fType == FNumberTypeChageAble)
    {
        if (self.counter == self.numberArray.count - 1)
        {
            self.counter = 0;
        }
        else
        {
            ++self.counter;
        }
        
        self.number = [self.numberArray[self.counter] floatValue];
        [self setColor:[[FStyle fNumberColorArray] objectAtIndex:self.counter ]];
        self.innerLabel.text = _FF(self.number);
    }
    else
    {
        if (self.isInvisible)
        {
            self.invisible = NO;
            self.color = [FStyle fNumberColor];
        }
        else
        {
            self.invisible = YES;
            self.color = [FStyle fNumberTextColor];
        }
    }
}

- (void)updateInnerLabelProperties
{
    self.innerLabel = [SKLabelNode labelNodeWithFontNamed:[FStyle fMainFont]];
    [self.innerLabel.scene setAnchorPoint:CGPointMake(0,0)];
    self.innerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.innerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.innerLabel.fontSize = self.size.height * kFNumberFontSizeFactor;
    self.innerLabel.fontColor = [FStyle fNumberTextColor];
    self.innerLabel.text = _FF(self.number);
    [self.innerLabel setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    self.innerLabel.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:self.innerLabel];
}

- (void)setSize:(CGSize)size
{
    [super setSize:size];
}

+ (FNumber*)numberGivenFunction:(NSString*)func
{
    Producer *producer = [[Producer alloc] initWithProduceName:func];
    CGFloat num = [producer parseFunctionFromName];
    return [[FNumber alloc] initWithNumber:num];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.delegate fNumberPressed:self];
}

#pragma mark - Setters
- (void)setNumber:(CGFloat)number
{
    _number = number;
    self.innerLabel.text = [@(number) description];
}

- (void)setEdge:(CGFloat)edge
{
    [self setSize:CGSizeMake(edge, edge)];
    [self updateInnerLabelProperties];
}

@end

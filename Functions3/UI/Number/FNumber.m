//
//  FNumber.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FNumber.h"
#import "FColor.h"
#import "Producer.h"

static const CGFloat kFNumberSize = 70;
static const CGFloat kFNumberFontSizeFactor = 0.4;
static const CGFloat kFNumberWaitForDuration = 1;

@interface FNumber()

@property (assign, nonatomic) CGFloat number;
@property (strong, nonatomic) SKLabelNode* innerLabel;
@property (strong, nonatomic) NSArray *numberArray;
@property (assign, nonatomic) FNumberType fType;
@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic,getter=isInvisible) BOOL invisible;
@end

@implementation FNumber


- (instancetype)initWithNumber:(CGFloat)number
{
    if (self = [super initWithColor:[FColor fNumberColor] size:CGSizeMake(kFNumberSize,kFNumberSize)])
    {
        self.number = number;
        [self updateInnerLabelProperties];
        [self addChild:self.innerLabel];
        [self setZPosition:-1];
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
        [self updateInnerLabelProperties];
        [self addChild:self.innerLabel];
        [self setZPosition:-1];
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
    if (self = [super initWithColor:[FColor fNumberColor] size:CGSizeMake(kFNumberSize,kFNumberSize)])
    {
        self.number = number;
        [self updateInnerLabelProperties];
        [self addChild:self.innerLabel];
        [self setZPosition:-1];
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
        [self setColor:[[FColor fNumberColorArray] objectAtIndex:self.counter ]];
        self.innerLabel.text = _FF(self.number);
    }
    else
    {
        if (self.isInvisible)
        {
            self.invisible = NO;
            self.color = [FColor fNumberColor];
        }
        else
        {
            self.invisible = YES;
            self.color = [FColor fNumberTextColor];
        }
    }
}

- (void)updateInnerLabelProperties
{
    self.innerLabel = [SKLabelNode labelNodeWithFontNamed:ARIAL_BOLD];
    self.innerLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.innerLabel.fontSize = self.size.height * kFNumberFontSizeFactor;
    self.innerLabel.fontColor = [FColor fNumberTextColor];
    self.innerLabel.text = _FF(self.number);
    self.innerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMidY(self.frame));
}

+ (FNumber*)numberGivenFunction:(NSString*)func
{
    Producer *producer = [[Producer alloc] initWithProduceName:func];
    CGFloat num = [producer parseFunctionFromName];
    return [[FNumber alloc] initWithNumber:num];
}

@end

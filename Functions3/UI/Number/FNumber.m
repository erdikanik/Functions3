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

const CGFloat kFNumberSize = 30;
const CGFloat kFNumberFontSizeFactor = 0.5;
const CGFloat kFNumberWaitForDuration = 1;

@interface FNumber()

@property (strong, nonatomic) NSArray *numberArray;
@property (assign, nonatomic) NSInteger counter;
@property (assign, nonatomic,getter=isInvisible) BOOL invisible;
@property (strong, nonatomic) SKAction *changeAction;

@end

@implementation FNumber


- (instancetype)init
{
    if (self = [super initWithColor:[FStyle fNumberColor] size:CGSizeMake(kFNumberSize,kFNumberSize)])
    {
        self.fType = FNumberTypeNormal;
    }
    return self;
}

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
        self.fType = FNumberTypeChangable;
        
        // call function timer sequences
        SKAction *wait = [SKAction waitForDuration:kFNumberWaitForDuration];
        SKAction *performSelector = [SKAction performSelector:@selector(fNumberEvents) onTarget:self];
        SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
        self.changeAction = [SKAction repeatActionForever:sequence];
        
        [self runAction:self.changeAction];
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

- (instancetype)initBombTypeWithNumber:(CGFloat)number
{
    if (self = [super initWithColor:[FStyle fNumberColor] size:CGSizeMake(kFNumberSize,kFNumberSize)])
    {
        self.number = number;
        self.fType = FNumberTypeBomb;
        
        // call function timer sequences
        SKAction *wait = [SKAction waitForDuration:kFNumberWaitForDuration];
        SKAction *performSelector = [SKAction performSelector:@selector(fNumberEvents) onTarget:self];
        SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
        SKAction *repeat   = [SKAction repeatActionForever:sequence];
        [self runAction:repeat];
    }
    return self;
}

#pragma mark - Public

- (void)explodeNumberWithCompletion:(void (^)())block
{
    self.fType = FNumberTypeBomb;
    
    SKAction *wait = [SKAction waitForDuration:0.05];
    SKAction *performSelector = [SKAction performSelector:@selector(fNumberEvents) onTarget:self];
    SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
    SKAction *repeat   = [SKAction repeatAction:sequence count:5];
    [self runAction:repeat completion:^{
        if (block)
        {
            block();
        }
    }];
}

- (void)initialize
{

}

#pragma mark - Properties

- (void)fNumberEvents
{
    switch (self.fType) {
        case FNumberTypeChangable:
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
            self.tile.fillColor = [[FStyle fNumberColorArray] objectAtIndex:self.counter ];
            self.innerLabel.text = _FF(self.number);
        }
            break;
        case FNumberTypeInvisible:
        {
            self.tile.fillColor = self.isInvisible ? [FStyle fNumberColor] : [FStyle fNumberTextColor];
            self.invisible = !self.isInvisible;
        }
            break;
        case FNumberTypeBomb:
        {
            self.tile.fillColor = self.isInvisible ? [FStyle fNumberColor] : [UIColor blackColor];
            self.invisible = !self.isInvisible;
        }
        default:
            break;
    }
}

- (void)updateInnerLabelProperties
{
    self.tile = [SKShapeNode node];
    [self.tile setPath:CGPathCreateWithRoundedRect(CGRectMake(0, 0, self.size.width, self.size.height), 5, 5, nil)];
    self.tile.strokeColor = self.tile.fillColor = self.color;
    self.tile.strokeColor = [FStyle fNumberTextColor];
    self.color = UIColor.clearColor;
    
    [self addChild:self.tile];
    
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

//- (void)addTexture
//{
//    UIGraphicsBeginImageContext(self.size);
//    [self.color setFill];
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];
//    [path fill];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    SKTexture *texture = [SKTexture textureWithImage:image];
//    
//    [self setTexture:texture];
//}

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

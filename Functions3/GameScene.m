//
//  GameScene.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "GameScene.h"
#import "FNumber.h"
#import "GameLogic.h"

static NSString* const kGameSceneblackBoxName = @"blackBox";

static const CGFloat kGameSceneGearDuration = 1.5;
static const CGFloat kGameSceneBigGearScaleFactor = 0.5;
static const CGFloat kGameSceneBigGearPointX = 355;
static const CGFloat kGameSceneBigGearPointY = 708;

static const CGFloat kGameSceneSmallGearScaleFactor = 0.25;
static const CGFloat kGameSceneSmallGearPointX = 390;
static const CGFloat kGameSceneSmallGearPointY = 700;


@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    [self staticGameScreenSetups];
    NSLog(@"hhh:  %f,%f",self.view.frame.size.height,self.view.frame.size.width);
    [self update];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    //SKSpriteNode* node = (SKSpriteNode *)[self childNodeWithName:kGameSceneblackBoxName];
    //[node setColor:[UIColor redColor]];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"scull"]) {
        
    }
    
}

-(void)update
{
    /* Called before each frame is rendered */
    // call function timer sequences
    SKAction *wait = [SKAction waitForDuration:5];
    SKAction *performSelector = [SKAction performSelector:@selector(produceRandomNumber) onTarget:self];
    SKAction *sequence = [SKAction sequence:@[performSelector, wait]];
    SKAction *repeat   = [SKAction repeatAction:sequence count:10];
    [self runAction:repeat completion:^{
        [self update];
    }];
}

#pragma mark - UISetups

- (void)staticGameScreenSetups
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"gear"];
    sprite.xScale = kGameSceneBigGearScaleFactor;
    sprite.yScale = kGameSceneBigGearScaleFactor;
    sprite.position = CGPointMake(kGameSceneBigGearPointX, kGameSceneBigGearPointY);
    SKAction *action = [SKAction rotateByAngle:M_PI duration:kGameSceneGearDuration];
    [sprite runAction:[SKAction repeatActionForever:action]];
    [self addChild:sprite];
    
    SKSpriteNode *sprite2 = [SKSpriteNode spriteNodeWithImageNamed:@"gear"];
    sprite2.xScale = kGameSceneSmallGearScaleFactor;
    sprite2.yScale = kGameSceneSmallGearScaleFactor;
    sprite2.position = CGPointMake(kGameSceneSmallGearPointX, kGameSceneSmallGearPointY);
    SKAction *action2 = [SKAction rotateByAngle:-M_PI duration:kGameSceneGearDuration];
    [sprite2 runAction:[SKAction repeatActionForever:action2]];
    [self addChild:sprite2];

    SKSpriteNode *scullSprite = [SKSpriteNode spriteNodeWithImageNamed:@"scull_g"];
    [scullSprite setName:@"scull"];
    scullSprite.xScale = 0.6;
    scullSprite.yScale = 0.6;
   [self addChild:scullSprite];
    scullSprite.position = CGPointMake(348, 597);
    SKAction *changeAction = [SKAction animateWithTextures:[NSArray arrayWithObjects:
                                                            [SKTexture textureWithImageNamed:@"scull_g.png"],
                                                            [SKTexture textureWithImageNamed:@"scull_m.png"],
                                                            [SKTexture textureWithImageNamed:@"scull_r.png"],
                                                            [SKTexture textureWithImageNamed:@"scull_y.png"], nil] timePerFrame:0.5 resize:YES restore:YES];
    [scullSprite runAction:[SKAction repeatActionForever:changeAction]];
    
}

- (void)produceRandomNumber
{
    /* Called when a touch begins */
    FNumber *fNumber = [GameLogic getNumberFromLogic];
    
    fNumber.position = CGPointMake(66,710);
    
    [self addChild:fNumber];
    
    SKAction *liftoff = [SKAction moveByX:0 y:-CGRectGetMidY(self.frame) +100 duration: 5];
    SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
    
    [fNumber runAction:rep completion:^{
        [self changeColorBox:[UIColor redColor]];
        
        SKAction *liftoff = [SKAction moveByX:0 y:-CGRectGetMidY(self.frame) +100 duration: 5];
        SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
        
        liftoff = [SKAction moveByX:0 y:-CGRectGetMidY(self.frame) -100 duration: 5];
        rep = [SKAction sequence:@[liftoff]]; //Test Sequence
        [fNumber runAction:rep completion:^{
            
        }];
    }];
    
}

- (void) changeColorBox:(UIColor *) curColor {
    SKAction *changeColor = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
    SKAction *changeColor2 = [SKAction colorizeWithColor:curColor colorBlendFactor:0 duration:0.1];
    SKAction *changeColor3 = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
    SKAction *changeColor4 = [SKAction colorizeWithColor:curColor colorBlendFactor:0 duration:0.1];
    SKAction *changeColor5 = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
    SKAction *changeColor6 = [SKAction colorizeWithColor:curColor colorBlendFactor:0 duration:0.1];
    SKAction *changeColor7 = [SKAction colorizeWithColor:[UIColor blackColor] colorBlendFactor:0 duration:0.1];
    
    SKAction *rep = [SKAction sequence:@[changeColor,changeColor2,changeColor3,changeColor4,changeColor5,changeColor6,changeColor7]];
    
    SKSpriteNode* node = (SKSpriteNode *)[self childNodeWithName:@"b1"];
    [node runAction:rep];
    
}

@end

//
//  GameScene.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "GameScene.h"
#import "FNumber.h"

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
    
    [self gameScreenSetups];
    NSLog(@"hhh:  %f,%f",self.view.frame.size.height,self.view.frame.size.width);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    FNumber *fNumber = [[FNumber alloc] initWithNumber:10];
    
    fNumber.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:fNumber];
    
    SKAction *liftoff = [SKAction moveByX:0 y:-CGRectGetMidY(self.frame) duration: 2];
    SKAction *rep = [SKAction sequence:@[liftoff]]; //Test Sequence
    
    [fNumber runAction:rep completion:^{
        
    }];
    
    SKSpriteNode* node = (SKSpriteNode *)[self childNodeWithName:kGameSceneblackBoxName];
    [node setColor:[UIColor redColor]];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    
    
}

#pragma mark - UISetups

- (void)gameScreenSetups
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

}



@end

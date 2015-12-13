//
//  GameScene.h
//  Functions3
//

//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol GameSceneDelegate;

@interface GameScene : SKScene <UIGestureRecognizerDelegate>

@property (weak, nonatomic) id <GameSceneDelegate> sdelegate;

@end


@protocol GameSceneDelegate <NSObject>

- (void)gameSceneOvered:(NSNumber*)totalPoint;

@end
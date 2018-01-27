//
//  GameScene.h
//  Functions3
//

//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol GameSceneDelegate;

@interface GameScene : SKScene <UIGestureRecognizerDelegate>

@property (weak, nonatomic) id <GameSceneDelegate> gameSceneDelegate;

@end


@protocol GameSceneDelegate <NSObject>

- (void)gameSceneGameDidOvered:(NSInteger)totalPoint;

@end

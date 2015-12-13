//
//  BlackBox.h
//  Functions3
//
//  Created by erdikanik on 6.09.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FSpriteNodeBase.h"

typedef NS_ENUM(NSUInteger, BlackBoxHorizantalMovement) {
    BlackBoxHorizantalMovementLeft=1,
    BlackBoxHorizantalMovementMiddle,
    BlackBoxHorizantalMovementRight
};

typedef NS_ENUM(NSUInteger, BlackBoxVerticalMovement) {
    BlackBoxVerticalMovementTop=1,
    BlackBoxVerticalMovementDown
};


#import <SpriteKit/SpriteKit.h>

@interface BlackBox : FSpriteNodeBase
- (id) initWithBboxName:(NSString*)bbName;
@property (assign, nonatomic) BlackBoxHorizantalMovement currentH;
@property (assign, nonatomic) BlackBoxVerticalMovement currentV;
@property (weak, nonatomic) SKScene* parentView;

- (void)initialize;
@end

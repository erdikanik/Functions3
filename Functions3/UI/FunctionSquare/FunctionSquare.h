//
//  FunctionSquare.h
//  Functions
//
//  Created by Erdi Kanık on 12/01/15.
//  Copyright (c) 2015 erdikanik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractFunction.h"
#import "FSpriteNodeBase.h"
#import <SpriteKit/SpriteKit.h>
#import "Polynomal.h"


@class FunctionTab;

@protocol FunctionSquareDelegate;

@interface FunctionSquare : FSpriteNodeBase

@property (nonatomic,strong) AbstractFunction *function;;
@property (weak, nonatomic) id <FunctionSquareDelegate> delegate;
@property (assign, nonatomic) BOOL selected;


- (id) initWithFunction: (AbstractFunction *) func withColor:(UIColor*) funcColor;
- (CGFloat)calculateFunction:(CGFloat)val;
@end

@protocol FunctionSquareDelegate <NSObject>

@required

- (void)functionSquarePressed:(FunctionSquare*)fSquare;

@end


//
//  BlackBox.m
//  Functions3
//
//  Created by erdikanik on 6.09.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "BlackBox.h"
#import "AbstractFunction.h"
#import "Polynomal.h"

static const CGFloat kBlackBoxWidth = 58;
static const CGFloat kBlackBoxHeight = 100;

static const CGFloat kGameSceneBlackBoxMoveX = 82;
static const CGFloat kGameSceneBlackBoxMoveDuration = 0.2;

@interface BlackBox()
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) SKLabelNode *innerLabel;
@property (strong, nonatomic) AbstractFunction *function;
@end


@implementation BlackBox
- (id) initWithBboxName:(NSString*)bbName
{
    CGSize size = CGSizeMake(kBlackBoxWidth, kBlackBoxHeight);
    if (self = [super initWithColor:[UIColor blackColor] size:size]) {
        self.innerLabel = [SKLabelNode labelNodeWithFontNamed:@"System"];
        [self.innerLabel setFontSize:14];
        [self.innerLabel setColor:[UIColor whiteColor]];
        [self.innerLabel setText:bbName];
        [self.innerLabel setFontColor:[UIColor whiteColor]];
        [self addChild:self.innerLabel];
    }
    return self;
}

- (void)initialize
{
    [self createGestureEvents];
}

#pragma mark - Privates

- (void)createGestureEvents
{
    UISwipeGestureRecognizer *swipeRightGestureR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:) ];
    UISwipeGestureRecognizer *swipeRightGestureL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:) ];
    
    [swipeRightGestureR setDirection: UISwipeGestureRecognizerDirectionRight];
    [swipeRightGestureL setDirection: UISwipeGestureRecognizerDirectionLeft];
    [self.parentView.view addGestureRecognizer: swipeRightGestureR];
    [self.parentView.view addGestureRecognizer: swipeRightGestureL];
    [self setZPosition:100];

}


#pragma mark - Gestures

-(void)handleSwipeRight:( UISwipeGestureRecognizer *)recognizer {
    CGFloat minY = self.position.y - kBlackBoxHeight / 2;
    CGFloat maxY = self.position.y + kBlackBoxHeight / 2;
    
    if ([recognizer locationInView:self.parentView.view].y >= minY && [recognizer locationInView:self.parentView.view].y <= maxY)
    {
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            if (self.currentH < 3)
            {
                SKAction *liftoff = [SKAction moveByX:kGameSceneBlackBoxMoveX y:0 duration: kGameSceneBlackBoxMoveDuration];
                ++self.currentH;
                [self runAction:liftoff completion:nil];
            }
        }
    }
}

-(void)handleSwipeLeft:( UISwipeGestureRecognizer *)recognizer {
    CGFloat minY = self.position.y - kBlackBoxHeight / 2;
    CGFloat maxY = self.position.y + kBlackBoxHeight / 2;
    
    if ([recognizer locationInView:self.parentView.view].y >= minY && [recognizer locationInView:self.parentView.view].y <= maxY)
    {
        if (recognizer.state == UIGestureRecognizerStateEnded)
        {
            if (self.currentH > 1)
            {
                SKAction *liftoff = [SKAction moveByX:-82 y:0 duration: 0.2];
                --self.currentH;
                [self runAction:liftoff completion:nil];
            }
        }
    }
}



@end

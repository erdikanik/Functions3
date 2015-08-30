//
//  FNumber.m
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FNumber.h"
#import "FColor.h"

static const CGFloat kFNumberSize = 50;
static const CGFloat kFNumberFontSizeFactor = 0.7;

@interface FNumber()

@property (assign, nonatomic) CGFloat number;
@property (strong, nonatomic) SKLabelNode* innerLabel;
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
    }
    return self;
}


#pragma mark - Properties

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


@end

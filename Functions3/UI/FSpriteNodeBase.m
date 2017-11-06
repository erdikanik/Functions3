//
//  FSpriteNodeBase.m
//  Functions3
//
//  Created by erdikanik on 14.11.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FSpriteNodeBase.h"

@implementation FSpriteNodeBase

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size
{
    self = [super initWithTexture:nil color:color size:size];

    if (self)
    {
        [self setAnchorPoint:CGPointMake(0,0)];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setAnchorPoint:CGPointMake(0,0)];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithImageNamed:(NSString *)name
{
    self = [super initWithImageNamed:name];
    if (self)
    {
        [self setAnchorPoint:CGPointMake(0,0)];
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end

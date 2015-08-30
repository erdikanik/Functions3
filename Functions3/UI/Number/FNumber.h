//
//  FNumber.h
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//


typedef NS_ENUM(NSUInteger, FNumberType) {
    FNumberTypeNormal,
    FNumberTypeChageAble,
    FNumberTypeInvisible
};

@interface FNumber : SKSpriteNode

- (instancetype)initWithNumber:(CGFloat)number;
- (instancetype)initWithNumberArray:(NSArray*)arr;
- (instancetype)initInvisibleNumber:(CGFloat)number;
@end

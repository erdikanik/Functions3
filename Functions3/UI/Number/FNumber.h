//
//  FNumber.h
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FSpriteNodeBase.h"

typedef NS_ENUM(NSUInteger, FNumberType) {
    FNumberTypeNormal,
    FNumberTypeChangable,
    FNumberTypeInvisible,
    FNumberTypeBomb
};

@protocol FNumberDelegate;

@interface FNumber : FSpriteNodeBase

@property (assign, nonatomic,getter=isf1) BOOL f1;
@property (assign, nonatomic,getter=isf2) BOOL f2;
@property (assign, nonatomic) CGFloat number;
@property (assign, nonatomic) CGFloat edge;
@property (weak, nonatomic) id<FNumberDelegate>delegate;
@property (assign, nonatomic,getter=isMoving) BOOL moving;
@property (assign, nonatomic) FNumberType fType;

/**
 Number's destination point.
 */
@property (assign, nonatomic) CGPoint moveToPoint;

- (instancetype)initWithNumber:(CGFloat)number;
- (instancetype)initWithNumberArray:(NSArray*)arr;
- (instancetype)initInvisibleNumber:(CGFloat)number;
- (instancetype)initBombTypeWithNumber:(CGFloat)number;

@end



@protocol FNumberDelegate <NSObject>

- (void)fNumberPressed:(FNumber*)fNumber;

@end

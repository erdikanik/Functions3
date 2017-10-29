//
//  FNumber.h
//  Functions3
//
//  Created by erdikanik on 29.08.2015.
//  Copyright (c) 2015 ekanik. All rights reserved.
//

#import "FSpriteNodeBase.h"

extern const CGFloat kFNumberSize;
extern const CGFloat kFNumberFontSizeFactor;
extern const CGFloat kFNumberWaitForDuration;

typedef NS_ENUM(NSUInteger, FNumberType) {
    FNumberTypeNormal,
    FNumberTypeChangable,
    FNumberTypeInvisible,
    FNumberTypeBomb,
    FNumberTypeGolden,
    FNumberTypeDiamond,
    FNumberTypeEmerald,
    FNumberTypeFunctions
};

@protocol FNumberDelegate;

@interface FNumber : FSpriteNodeBase

@property (assign, nonatomic) CGFloat number;
@property (assign, nonatomic) CGFloat edge;
@property (weak, nonatomic) id<FNumberDelegate>delegate;
@property (assign, nonatomic,getter=isMoving) BOOL moving;
@property (assign, nonatomic) FNumberType fType;
@property (strong, nonatomic) SKLabelNode* innerLabel;
@property (strong, nonatomic) FSpriteNodeBase *innerShape;
@property (strong, nonatomic) SKShapeNode *tile;

/**
 Number's destination point.
 */
@property (assign, nonatomic) CGPoint moveToPoint;

- (instancetype)initWithNumber:(CGFloat)number;
- (instancetype)initWithType:(FNumberType)type;
- (instancetype)initWithNumberArray:(NSArray*)arr;
- (instancetype)initInvisibleNumber:(CGFloat)number;
- (instancetype)initBombTypeWithNumber:(CGFloat)number;

- (void)explodeNumberWithCompletion:(void (^)())block;
- (void)initialize;

@end



@protocol FNumberDelegate <NSObject>

- (void)fNumberPressed:(FNumber*)fNumber;

@end

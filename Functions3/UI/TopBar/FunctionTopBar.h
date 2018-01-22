//
//  FunctionTopBar.h
//  Functions3
//
//  Created by Erdi Kanık on 27.06.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "FSpriteNodeBase.h"

@interface FunctionTopBar : FSpriteNodeBase

- (instancetype)initWithSize:(CGSize)size;
- (void)initialize;

- (void)updateFunction:(NSString *)functionText;
- (void)updateFunctionTimeText:(NSString *)timeText;
- (void)updateTime:(NSString *)time;
- (void)updateResult: (NSInteger)result;
- (void)updateNumber: (NSString *)number;
- (void)updateScore: (NSString *)score;

@end

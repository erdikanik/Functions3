//
//  FunctionBoard.h
//  Functions3
//
//  Created by Erdi Kanık on 4.09.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "FSpriteNodeBase.h"

@interface FunctionBoard : FSpriteNodeBase

- (instancetype)initWithSize:(CGSize)size functionText:(NSString *)text;
- (void)initialize;

@property (nonatomic, strong) NSString *text;

@end

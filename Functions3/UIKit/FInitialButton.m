//
//  FInitialButton.m
//  Functions3
//
//  Created by Erdi Kanık on 16.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

#import "FInitialButton.h"
#import "FStyle.h"

@implementation FInitialButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:15]];
    [self setTitleColor: [FStyle fNumberTextColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[FStyle fNumberColor]];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [FStyle fNumberTextColor].CGColor;
    self.layer.cornerRadius = 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

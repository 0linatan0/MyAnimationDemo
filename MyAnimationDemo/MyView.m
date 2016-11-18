//
//  MyView.m
//  MyAnimationDemo
//
//  Created by 谭丽 on 16/11/16.
//  Copyright © 2016年 linatan. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    id action = [super actionForLayer:layer forKey:event];
    return action;
}

@end

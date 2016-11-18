//
//  MyListView.h
//  MyAnimationDemo
//
//  Created by 谭丽 on 16/11/17.
//  Copyright © 2016年 linatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyListViewDelegate
- (void)changeTransitionDesc;
@end

@interface MyListView : UIView

@property(nonatomic, weak) id<MyListViewDelegate> delegate;

- (instancetype)initWithBtn:(UIButton *)btn withAllTypes:(NSArray *)typeList;

-(void)hideDropDown:(UIButton *)btn;

@end

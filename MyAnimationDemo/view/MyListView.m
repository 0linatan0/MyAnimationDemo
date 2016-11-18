//
//  MyListView.m
//  MyAnimationDemo
//
//  Created by 谭丽 on 16/11/17.
//  Copyright © 2016年 linatan. All rights reserved.
//

#import "MyListView.h"

static const NSInteger tableHeight = 100;
static const NSInteger rowHeight = 20;

@interface MyListView ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIButton *_copyBtn;
    NSArray *_allTypes;
}
@end

@implementation MyListView

- (instancetype)initWithBtn:(UIButton *)btn withAllTypes:(NSArray *)typeList
{
    self = [self init];
    if (self)
    {
        _copyBtn = btn;
        _allTypes = typeList;
        
        _tableView = [[UITableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        self.frame = CGRectMake(_copyBtn.frame.origin.x, _copyBtn.frame.origin.y + _copyBtn.frame.size.height, 0, 0);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.frame = CGRectMake(_copyBtn.frame.origin.x, _copyBtn.frame.origin.y + _copyBtn.frame.size.height, _copyBtn.frame.size.width, tableHeight);
        _tableView.frame = CGRectMake(0, 0, _copyBtn.bounds.size.width, tableHeight);
        [UIView commitAnimations];

    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allTypes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"listCellIndentifier";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:11.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = [_allTypes objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_copyBtn setTitle:[_allTypes objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    if (self.delegate && self.delegate )
    {
        [_delegate changeTransitionDesc];
    }
    
    [self hideDropDown:_copyBtn];
}

-(void)hideDropDown:(UIButton *)btn {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y+btn.frame.size.height, btn.frame.size.width, 0);
    _tableView.frame = CGRectMake(0, 0, btn.frame.size.width, 0);
    [UIView commitAnimations];
}

@end

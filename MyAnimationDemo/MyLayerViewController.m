//
//  MyLayerViewController.m
//  MyAnimationDemo
//
//  Created by 谭丽 on 16/11/16.
//  Copyright © 2016年 linatan. All rights reserved.
//

#import "MyLayerViewController.h"
#import "MyView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface MyLayerViewController ()
{
    UIButton *_clickBtn;
    MyView *_view;
    CALayer *_subLayer;
    
    MyView *_viewCompact;
}
@end

@implementation MyLayerViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _viewCompact = [[MyView alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, 200, 100 , 100)];
        _viewCompact.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:_viewCompact];
        
        _view = [[MyView alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, 100, 100 , 100)];
        _view.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_view];
        
        _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, 20, 100, 50)];
        [_clickBtn setTitle:@"show" forState:UIControlStateNormal];
        [_clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clickBtn setBackgroundColor:[UIColor blueColor]];
        [_clickBtn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_clickBtn];
        
        _subLayer = [CALayer layer];
        _subLayer.bounds = CGRectMake(0, 0, 50 , 50);
        _subLayer.position = CGPointMake(20,20);
        _subLayer.backgroundColor = [UIColor blueColor].CGColor;
        [_view.layer addSublayer:_subLayer];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation:(id)sender
{
    _subLayer.zPosition = 1;
    _subLayer.position = CGPointMake(100, 20);

    _viewCompact.layer.position = CGPointMake(100, 400);
}

@end

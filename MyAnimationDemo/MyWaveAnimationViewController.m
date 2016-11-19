//
//  MyWaveAnimationViewController.m
//  MyAnimationDemo
//
//  Created by 谭丽 on 16/11/18.
//  Copyright © 2016年 linatan. All rights reserved.
//

#import "MyWaveAnimationViewController.h"
#import "MyView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MyWaveAnimationViewController ()
{
    MyView *_myview;
    CALayer *_subLayer;
    UIView *_view;
    UIButton *_clickBtn;
}
@end

@implementation MyWaveAnimationViewController

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _view = [[UIView alloc] init];
        _view.frame = CGRectMake(0, 100, kScreenWidth, kScreenHeight - 100);
        _view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_view];
        
        _clickBtn = [[UIButton alloc] init];
        _clickBtn.frame = CGRectMake((kScreenWidth - 100)/2, 20, 100, 30);
        [_clickBtn setTitle:@"show" forState:UIControlStateNormal];
        [_clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clickBtn setBackgroundColor:[UIColor blueColor]];
        [_clickBtn addTarget:self action:@selector(showAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_clickBtn];
        
        
        _myview = [[MyView alloc] init];
        _myview.frame = CGRectMake(0, 100, 100, 200);
        _myview.backgroundColor = [UIColor grayColor];
        [_view addSubview:_myview];
        
        _subLayer = [CALayer layer];
        _subLayer.backgroundColor = [[UIColor redColor] CGColor];
        _subLayer.frame = CGRectMake(0, 0, 50, 50);
        [_myview.layer addSublayer:_subLayer];
    }
    return self;
}

- (void) showAnimation:(UIButton *)btn
{
//    _myview.layer.hidden = YES;
    
//    [self generateSnowAnimation];
    
    _subLayer.hidden = YES;
}

//利用CAEmitterLayer制作雪花飘落的动画
- (void)generateSnowAnimation
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(_view.bounds.size.width/2, -30);
    emitterLayer.emitterSize = CGSizeMake(_view.bounds.size.width * 2, 0 );
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    emitterLayer.shadowOpacity = 1.0;
    emitterLayer.shadowRadius = 0.0;
    emitterLayer.shadowOffset = CGSizeMake(0.0, 1.0);
    emitterLayer.shadowColor = [[UIColor whiteColor] CGColor];
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.birthRate = 1.0;
    emitterCell.lifetime = 100;
    emitterCell.velocity = -10;
    emitterCell.velocityRange = 10;
    emitterCell.yAcceleration = 2;
    emitterCell.emissionRange = 0.5 * M_PI;
    emitterCell.spinRange = 0.25 * M_PI;
    emitterCell.contents = (id)[[UIImage imageNamed:@"snow"] CGImage];
    emitterCell.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    emitterLayer.emitterCells = [NSArray arrayWithObject:emitterCell];
    [_view.layer addSublayer:emitterLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MyViewController.m
//  MyAnimationDemo
//
//  Created by 谭丽 on 16/11/14.
//  Copyright © 2016年 linatan. All rights reserved.
//

#import "MyViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
static const NSInteger imageSize = 180;

@interface MyViewController ()
{
    UIImageView *_cardOne;
    UIImageView *_cardOther;
    UIButton *_showBtn;
    UIView *_view;
    UILabel *_descLabel;
}
@end

@implementation MyViewController

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenWidth)];
        [self.view addSubview:_view];
        
        _cardOther = [[UIImageView alloc] initWithFrame:CGRectMake((_view.bounds.size.width - imageSize)/2, (_view.bounds.size.height - imageSize)/2, imageSize, imageSize)];
        _cardOther.image = [UIImage imageNamed:@"push2.jpg"];
        _cardOther.contentMode = UIViewContentModeScaleAspectFill;
        [_view addSubview:_cardOther];
        
        _cardOne = [[UIImageView alloc] initWithFrame:CGRectMake((_view.bounds.size.width - imageSize)/2, (_view.bounds.size.height - imageSize)/2, imageSize, imageSize)];
        _cardOne.image = [UIImage imageNamed:@"push1.jpg"];
        _cardOne.contentMode = UIViewContentModeScaleAspectFill;
        [_view addSubview:_cardOne];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake((_view.bounds.size.width - 100)/2, (_view.bounds.size.height - 70), 100, 50)];
        _descLabel.font = [UIFont systemFontOfSize:20];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.text = @"两小无猜";
        [_view addSubview:_descLabel];
        
        _showBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, 70, 100, 40)];
        [_showBtn setTitle:@"切换" forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showBtn setBackgroundColor:[UIColor blueColor]];
        [_showBtn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_showBtn];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimation:(id)sender
{
    _descLabel.text = @"两小无猜";
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        _descLabel.text = @"锦鲤";
    }];
    [self showOneCardAnimation];
    [self showOtherCardAnimation];
    [CATransaction commit];


    [UIView animateKeyframesWithDuration:1.2 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.2 animations:^{
            _cardOne.frame = CGRectMake(0, 50, imageSize, imageSize);
        }];
    } completion:^(BOOL finished) {
        //...
    }];
    
}

- (void)showOneCardAnimation
{
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[@0, @-0.14, @0];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                ];
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[[NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(-110, -10)],
                        [NSValue valueWithCGPoint:CGPointZero]];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[rotation,position];
    group.duration = 1.2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ;
    
    [_cardOne.layer addAnimation:group forKey:@"shuffle"];
}


- (void)showOtherCardAnimation
{
    //other card
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotationOther = [CAKeyframeAnimation animation];
    rotationOther.keyPath = @"transform.rotation";
    rotationOther.values = @[@0, @0.14, @0];
    rotationOther.duration = 1.2;
    rotationOther.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    CAKeyframeAnimation *positionOther = [CAKeyframeAnimation animation];
    positionOther.keyPath = @"position";
    positionOther.values = @[[NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(110, -30)],
                        [NSValue valueWithCGPoint:CGPointZero]];
    positionOther.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    positionOther.additive = YES;
    positionOther.duration = 1.2;
//    positionOther.beginTime = CACurrentMediaTime() + 0.5; //让动画延迟执行
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 1.2;
    group.animations = @[zPosition,rotationOther,positionOther];
    [_cardOther.layer addAnimation:group forKey:@"shuffle"];
    _cardOther.layer.zPosition = 1;
}





@end

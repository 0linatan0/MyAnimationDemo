//
//  MyCardChangeViewController.m
//  MyAnimationDemo
//
//  转场动画demo展示
//
//  Created by 谭丽 on 16/11/17.
//  Copyright © 2016年 linatan. All rights reserved.
//

#import "MyCardChangeViewController.h"
#import "MyListView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

static const NSInteger imageSize = 180;

@interface MyCardChangeViewController ()<MyListViewDelegate>
{
    UIView *_view;
    UIImageView *_cardImageView;
    UIButton *_showBtn;
    UIButton *_transitionTypeBtn;
    UIButton *_transitionDirectionBtn;
    
    UILabel *_transistionDesclabel;
    
    MyListView *_transitionTypeListView;
    MyListView *_transitionDirectionView;
    
    NSMutableArray *_cardImgList;
    NSUInteger _currentIndex;
    NSArray *_transitionAllTypes;
    NSArray *_transitionAllDirections;
    
    NSDictionary *_transitionDic;
    NSDictionary *_directionDic;
}
@end

@implementation MyCardChangeViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _currentIndex = 0;
        
        _transitionDic = @{
                           @"fade":@"交叉淡化过渡",
                           @"push":@"新视图把旧视图推出去",
                           @"moveIn":@"新视图移到旧视图上面",
                           @"reveal":@"移开旧视图,显示下面的新视图",
                           @"cube":@"立方体翻转效果",
                           @"oglFlip":@"上下左右翻转效果",
                           @"suckEffect":@"收缩效果,像一块布被抽走",
                           @"rippleEffect":@"水滴效果",
                           @"pageCurl":@"向上翻页效果",
                           @"pageUnCurl":@"向下翻页效果",
                           @"cameraIrisHollowOpen":@"相机镜头打开效果",
                           @"cameraIrisHollowClose":@"相机镜头关闭效果"
                           };
        _directionDic = @{
                          @"fromLeft":@"自左向右",
                          @"fromRight":@"自右至左",
                          @"fromTop":@"自上而下",
                          @"fromBottom":@"自下而上"
                          };
        
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenWidth)];
        _view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_view];
        
        _cardImgList = [NSMutableArray array];
        [_cardImgList addObject:[UIImage imageNamed:@"push1.jpg"]];
        [_cardImgList addObject:[UIImage imageNamed:@"push2.jpg"]];
        [_cardImgList addObject:[UIImage imageNamed:@"push3.jpg"]];
        
        _cardImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_view.bounds.size.width - imageSize)/2, (_view.bounds.size.height - imageSize)/2, imageSize, imageSize)];
        _cardImageView.image = [_cardImgList objectAtIndex:_currentIndex];
         _cardImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_view addSubview:_cardImageView];
        
        _showBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 150, 70, 30)];
        [_showBtn setTitle:@"show" forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_showBtn setBackgroundColor:[UIColor blueColor]];
        [_showBtn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_showBtn];
        
        _transitionTypeBtn = [[UIButton alloc] init];
        _transitionTypeBtn.frame = CGRectMake(10, 150, 150, 30);
        _transitionTypeBtn.titleLabel.font = [UIFont systemFontOfSize: 13];
        [_transitionTypeBtn setTitle:@"fade" forState:UIControlStateNormal];
        [_transitionTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_transitionTypeBtn addTarget:self action:@selector(chooseTransistionType:) forControlEvents:UIControlEventTouchUpInside];
        _transitionTypeBtn.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_transitionTypeBtn];
        
        _transitionDirectionBtn = [[UIButton alloc] init];
        _transitionDirectionBtn.frame = CGRectMake(170, 150, 100, 30);
        _transitionDirectionBtn.titleLabel.font = [UIFont systemFontOfSize: 13];
        _transitionDirectionBtn.backgroundColor = [UIColor grayColor];
        [_transitionDirectionBtn setTitle:@"fromLeft" forState:UIControlStateNormal];
        [_transitionDirectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_transitionDirectionBtn addTarget:self action:@selector(chooseTransistionDirection:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_transitionDirectionBtn];
        
        _transitionAllTypes = @[@"fade",@"push",@"moveIn",@"reveal",@"cube",@"oglFlip",@"suckEffect",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"];
        _transitionAllDirections = @[@"fromLeft",@"fromRight",@"fromTop",@"fromBottom"];
        
        _transistionDesclabel = [[UILabel alloc]init];
        _transistionDesclabel.frame = CGRectMake(10, 70 , kScreenWidth , 60 );
        _transistionDesclabel.numberOfLines = 2;
        _transistionDesclabel.font = [UIFont systemFontOfSize:15];
        _transistionDesclabel.textColor = [UIColor blackColor];
        _transistionDesclabel.text = [self generalTransitionDesc];
        [self.view addSubview:_transistionDesclabel];
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

- (void)chooseTransistionType:(UIButton *)transistionTypeBtn
{
    if (!_transitionTypeListView)
    {
        _transitionTypeListView = [[MyListView alloc] initWithBtn:transistionTypeBtn withAllTypes:_transitionAllTypes];
        _transitionTypeListView.delegate = self;
        [self.view addSubview:_transitionTypeListView];
    }
    else
    {
        [_transitionTypeListView hideDropDown:transistionTypeBtn];
        _transitionTypeListView = nil;
    }
    
}

- (void)chooseTransistionDirection:(UIButton *)transistionDirectionBtn
{
    if (!_transitionDirectionView)
    {
        _transitionDirectionView = [[MyListView alloc] initWithBtn:transistionDirectionBtn withAllTypes:_transitionAllDirections];
        _transitionDirectionView.delegate = self;
        [self.view addSubview:_transitionDirectionView];
    }
    else
    {
        [_transitionDirectionView hideDropDown:transistionDirectionBtn];
        _transitionDirectionView = nil;
    }
}


- (void)startAnimation:(id)sender
{
    //转场效果
    /* 对于transition中的type字段
        fade 交叉淡化过渡
        push 新视图把旧视图推出去
        moveIn 新视图移到旧视图上面
        reveal 将旧视图移开,显示下面的新视图
        cube 立方体翻转效果
        oglFlip 直接翻转效果
        suckEffect 收缩效果,抽纸似的
        rippleEffect 水滴效果
        pageCurl 向上翻页效果
        pageUnCurl 向下翻页效果
        cameraIrisHollowOpen 相机镜头打开效果
        cameraIrisHollowClose 相机镜头关闭效果
      subType 转场的方向
        fromLeft
        fromRight
        fromTop
        fromBottom
     */
    
    NSString *transitionType = [_transitionTypeBtn titleForState:UIControlStateNormal];
    NSString *transitionDirection = [_transitionDirectionBtn titleForState:UIControlStateNormal];
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = transitionType;
    transition.subtype = transitionDirection;
    transition.duration = 1.5;
    _cardImageView.image =  [self _getNextCardImage];
    [_cardImageView.layer addAnimation:transition forKey:@"cardTransistion"];
}

- (void)changeTransitionDesc
{
    _transistionDesclabel.text = [self generalTransitionDesc];
}

- (NSString *)generalTransitionDesc
{
    NSString *transitionType = [_transitionTypeBtn titleForState:UIControlStateNormal];
    NSString *transitionDirection = [_transitionDirectionBtn titleForState:UIControlStateNormal];
    
    return [NSString stringWithFormat:@"过渡效果:%@ \n方向：%@",[_transitionDic objectForKey:transitionType],[_directionDic objectForKey:transitionDirection]];
}

- (UIImage *)_getNextCardImage
{
    NSUInteger nextIndex = (_currentIndex + 1)%[_cardImgList count];
    _currentIndex = nextIndex;
    return [_cardImgList objectAtIndex:nextIndex];
}

@end

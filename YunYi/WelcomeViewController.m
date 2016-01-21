//
//  WelcomeViewController.m
//  StoryB
//
//  Created by jarvan on 15/6/1.
//  Copyright (c) 2015年 姜淞文. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4f];

    // Do any additional setup after loading the view.
}
- (void)configUI
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(w * 2, h);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    int size = 5;

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"5_12.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(w/2 - 68, h - 60, 136, 39)];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    for (int i = 0; i< 2 ; i ++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d-%c",size,('a'+i)] ofType:@"png"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * w, 0, w, h)];
        imageView.image = [[UIImage alloc] initWithContentsOfFile:path];
        if (i == 1) {
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:button];
        }
        [_scrollView addSubview:imageView];
    }
    
    
}
- (void)btnClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(finishedLaunchWithWelcome:)]) {
        [_delegate finishedLaunchWithWelcome:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

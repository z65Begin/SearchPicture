//
//  WelcomeViewController.h
//  StoryB
//
//  Created by jarvan on 15/6/1.
//  Copyright (c) 2015年 姜淞文. All rights reserved.
//

#import <UIKit/UIKit.h>
//浏览结束后进入程序的代理
@protocol finishedLaunchDelegate <NSObject>
/**
 *  程序luanch完毕代理
 */
- (void)finishedLaunchWithWelcome:(UIViewController *)welcome;

@end
@interface WelcomeViewController : UIViewController

@property (weak, nonatomic) id <finishedLaunchDelegate> delegate;

@end

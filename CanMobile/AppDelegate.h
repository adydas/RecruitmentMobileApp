//
//  AppDelegate.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
        UIView *darkView;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic)   NSInteger m_nHomeType;

@property (strong, nonatomic) ViewController *viewController;

- (void)initDarkView;
- (void)addDarkView;
- (void)removeDarkView;

@end

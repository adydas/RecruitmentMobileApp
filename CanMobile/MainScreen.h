//
//  MainScreen.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/ADBannerView.h>

@interface MainScreen : UITabBarController <ADBannerViewDelegate>{
    
}

@property (nonatomic, retain) ADBannerView *bannerView;
@property (nonatomic) NSInteger m_nHomeType;

@property (nonatomic, retain) NSString *name;

@end

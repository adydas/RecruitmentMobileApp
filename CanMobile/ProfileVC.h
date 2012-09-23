//
//  ProfileVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController 

{
    IBOutlet UIImageView *qRCodeImageView;
}

@property (nonatomic) BOOL  m_bHome;
@property (nonatomic, retain) IBOutlet UIButton *accountInfoButton;

- (id)initWithNibNameHome:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bHome: (BOOL) bHome;

- (IBAction)accountInfoButtonPressed:(id)sender;

@end

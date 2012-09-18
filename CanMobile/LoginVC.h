//
//  LoginVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
{
    IBOutlet UIActivityIndicatorView *activityView;
    IBOutlet UIView *darkView;
}
@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *password;

- (IBAction) loginButtonPressed:(id)sender;
- (IBAction) onClickForgotPassword:(id)sender;
- (IBAction) onClickRegister:(id)sender;

@end

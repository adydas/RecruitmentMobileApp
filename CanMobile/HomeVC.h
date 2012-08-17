//
//  HomeVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController
{
    UIBarButtonItem *logoutButton;
    IBOutlet UIView *darkView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) IBOutlet UILabel *username;
-(IBAction)searchJobsButtonpressed:(id)sender;
-(IBAction)favoriteJobsButtonpressed:(id)sender;
-(IBAction)upcomingEventsButtonpressed:(id)sender;
-(IBAction)myProfileButtonpressed:(id)sender;
-(void)getFirstAndLastName;
@end

//
//  MainScreen.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScreen.h"
#import "HomeVC.h"
#import "JobsVC.h"
#import "FavoriteJobsVC.h"
#import "EventsVC.h"
#import "ProfileVC.h"

@implementation MainScreen
@synthesize name;
@synthesize m_nHomeType;
@synthesize bannerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
           }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIImage *backButton = [[UIImage imageNamed:Back_Button_Up] 
                           resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 12.0f, 0.0f, 12.0f)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton 
                                                      forState:UIControlStateNormal 
                                                    barMetrics:UIBarMetricsLandscapePhone];
    
    UIViewController *homeViewCtrl;

    if (m_nHomeType == 0) {
        homeViewCtrl = [[JobsVC alloc] initWithNibNameHome:@"JobsVC" bundle:nil bHome: YES];
    } else if (m_nHomeType == 1) {
        homeViewCtrl = [[FavoriteJobsVC alloc] initWithNibName:@"FavoriteJobsVC" bundle:nil];        
    } else if (m_nHomeType == 2) {
        homeViewCtrl = [[EventsVC alloc] initWithNibNameHome:@"EventsVC" bundle:nil bHome: YES];
    } else {
        homeViewCtrl = [[ProfileVC alloc] initWithNibNameHome:@"ProfileVC" 
                                                bundle:nil bHome: YES];
    }
    
    UINavigationController *firstTabVC = [[UINavigationController alloc] initWithRootViewController:homeViewCtrl];
    
    //Initialize the second tab
    UIViewController *jobViewCtrl = [[JobsVC alloc] initWithNibName:@"JobsVC" bundle:nil];
    UINavigationController *secondTabVC = [[UINavigationController alloc] initWithRootViewController:jobViewCtrl];
    
    //Initialize the Thrid Tab 
    UIViewController *eventViewCtrl = [[EventsVC alloc] initWithNibName:@"EventsVC" bundle:nil];
    UINavigationController *thirdTabVC = [[UINavigationController alloc] initWithRootViewController:eventViewCtrl];
    
    //Initialize the Fourth Tab
    UIViewController *profileViewCtrl = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    UINavigationController *fourthTabVC = [[UINavigationController alloc] initWithRootViewController:profileViewCtrl];

    self.viewControllers = [NSArray arrayWithObjects:firstTabVC, 
                                             secondTabVC, 
                                             thirdTabVC,
                                             fourthTabVC, nil];
	
	CGRect frame = self.tabBar.frame;
	frame.size.height = 50.0;
	self.tabBar.frame = frame;
    
    
    bannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)];
    bannerView.delegate = self;

    [self.view addSubview: bannerView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc {
    [super dealloc];
    [bannerView release];
}

#pragma mark - ADView Banner
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [banner setFrame:CGRectMake(0, 20, 320, 50)];
}

@end

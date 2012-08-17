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
#import "EventsVC.h"
#import "ProfileVC.h"
@implementation MainScreen
@synthesize name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
//        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 250, 30)];
//        topLabel.textColor = [UIColor whiteColor];
//        topLabel.backgroundColor = [UIColor clearColor];
//        topLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:17.0f];
//        topLabel.text = @"eRecruiting from Experience.com";
//        [self.navigationController.navigationBar addSubview:topLabel];
        
//        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_refresh.png"]]];
//        
//        [refreshButton setBackgroundImage:[UIImage imageNamed:@"icon_refresh.png"] 
//                                 forState:UIControlStateNormal
//                               barMetrics:UIBarMetricsDefault];
//        self.navigationItem.rightBarButtonItem = refreshButton;
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

    
    UIViewController *viewController1 = [[HomeVC alloc] initWithNibName:@"HomeVC" 
                                                                                   bundle:nil];
    UINavigationController *firstTabVC = [[UINavigationController alloc] initWithRootViewController:viewController1];
    
    //Initialize the second tab
    UIViewController *viewController2 = [[JobsVC alloc] initWithNibName:@"JobsVC" 
                                                                                    bundle:nil];
    UINavigationController *secondTabVC = [[UINavigationController alloc] initWithRootViewController:viewController2];
    
    //Initialize the Thrid Tab 
    UIViewController *viewController3 = [[EventsVC alloc] initWithNibName:@"EventsVC" 
                                                                                bundle:nil];
    UINavigationController *thirdTabVC = [[UINavigationController alloc] initWithRootViewController:viewController3];
    
    //Initialize the Fourth Tab
    UIViewController *viewController4 = [[ProfileVC alloc] initWithNibName:@"ProfileVC" 
                                                                                    bundle:nil];
    UINavigationController *fourthTabVC = [[UINavigationController alloc] initWithRootViewController:viewController4];
    
//    UIViewController *viewController5 = [[LogoutVC alloc] initWithNibName:@"LogoutVC" 
//                                                                    bundle:nil];
//    UINavigationController *fifthTabVC = [[UINavigationController alloc] initWithRootViewController:viewController5];

    self.viewControllers = [NSArray arrayWithObjects:firstTabVC, 
                                             secondTabVC, 
                                             thirdTabVC,
                                             fourthTabVC, /*fifthTabVC,*/ nil];
	
	CGRect frame = self.tabBar.frame;
	frame.size.height = 50.0;
	self.tabBar.frame = frame;
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

@end

//
//  HomeVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeVC.h"
#import "JobsVC.h"
#import "EventsVC.h"
#import "ProfileVC.h"
#import "FavoriteJobsVC.h"
#import "NetworkController.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "ViewController.h"

@implementation HomeVC
@synthesize username;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem * tabtitle = [[UITabBarItem alloc] initWithTitle: @"Home"
                                                                image: [UIImage imageNamed:Home_tab_Image] //or your icon 
                                                                  tag: 0];
        
        [self setTabBarItem: tabtitle];

        UIImage *logoImage = [UIImage imageNamed:Experience_Logo];
        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
        logoImageView.frame = CGRectMake(160, 0, 156, 27);
        self.navigationItem.titleView = logoImageView ;
        
        UIButton *customView = [[UIButton alloc] initWithFrame:CGRectMake(210, 0, 112, 25)];
        [customView setBackgroundImage:[UIImage imageNamed:Logout_Button_Up] forState:UIControlStateNormal];
        [customView setBackgroundImage:[UIImage imageNamed:Logout_Button_Pressed] forState:UIControlStateSelected];

        [customView addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        logoutButton = [[UIBarButtonItem alloc] initWithCustomView:customView];
        
        self.navigationItem.rightBarButtonItem = logoutButton;
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
    [self.view addSubview:darkView];
    [activityView startAnimating];
    [self getFirstAndLastName];

    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.username = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc
{
    [self.username release];
    [super dealloc];
}

#pragma mark - IBActions

-(IBAction)searchJobsButtonpressed:(id)sender
{
    JobsVC *jobsVC = [[JobsVC alloc] initWithNibName:@"JobsVC" bundle:nil];
    [self.navigationController pushViewController:jobsVC animated:YES];
    //[jobsVC release];
    NSLog(@"searchJobs button pressed");
}

-(IBAction)favoriteJobsButtonpressed:(id)sender
{

    NSLog(@"favoriteJobs button pressed");
    FavoriteJobsVC *favoriteJobsVC = [[FavoriteJobsVC alloc] initWithNibName:@"FavoriteJobsVC" bundle:nil];
    [self.navigationController pushViewController:favoriteJobsVC animated:YES];
    [favoriteJobsVC release];
    
    
}

-(IBAction)upcomingEventsButtonpressed:(id)sender
{
    EventsVC *eventsVC = [[EventsVC alloc] initWithNibName:@"EventsVC" bundle:nil];
    [self.navigationController pushViewController:eventsVC animated:YES];
    //[eventsVC release];
    NSLog(@"upcomingEvents button pressed");
}

-(IBAction)myProfileButtonpressed:(id)sender
{
    ProfileVC *profileVC = [[ProfileVC alloc] initWithNibName:@"ProfileVC" bundle:nil];
    [self.navigationController pushViewController:profileVC animated:YES];
    [ProfileVC release];
    NSLog(@"myProfile button pressed");
}

-(IBAction) logoutButtonPressed: (id) sender 
{
     AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    delegate.viewController = [[ViewController alloc] initWithRootViewController:loginVC];
    delegate.window.rootViewController = delegate.viewController;
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:User_Name_Key_For_User_Defaults];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Password_Key_For_User_Defaults];
}




-(void)getFirstAndLastName{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[[NetworkController singleton] getFirstNameAndLastNameFromServer:^(int result, NSString *userNameString){
        if (result == NO_INTERNET)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:No_Internet_Connection_Title
                                                            message:No_Internet_Connection_Message
                                                           delegate:nil cancelButtonTitle:Alert_Button_Title otherButtonTitles:nil];
            [alert show];
            [alert release];

        }
        else if (result == REQUEST_FAILED)
        {
            NSLog(@"Error");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Request_Failiure_Title
                                                            message:Request_Failiure_Message
                                                           delegate:nil cancelButtonTitle:Alert_Button_Title otherButtonTitles:nil];
            [alert show];
            [alert release];

        }
        else if (result == ERROR_OCCURED)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Request_Error_Title
                                                            message:Request_Error_Message
                                                           delegate:nil cancelButtonTitle:Alert_Button_Title otherButtonTitles:nil];
            [alert show];
            [alert release];

        }
        else if(result == REQUEST_SUCCEEDED){
            NSLog(@"success");
            self.username.text = userNameString;
            
        }
        [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:userNameString waitUntilDone:NO];
    }];	
    
	[pool release];
    
}


-(void)removeOverLay:(NSString*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

@end

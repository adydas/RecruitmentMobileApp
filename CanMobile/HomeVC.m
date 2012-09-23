//
//  HomeVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeVC.h"
#import "MainScreen.h"
#import "NetworkController.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "SUtils.h"

@implementation HomeVC
@synthesize username;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /*

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
         */
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

- (void) dealloc
{
    [self.username release];
    [super dealloc];
}

#pragma mark - Member Functions


- (void)getFirstAndLastName{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[[NetworkController singleton] getFirstNameAndLastNameFromServer:^(int result, NSString *userNameString){
        if (result == NO_INTERNET)
        {
            [SUtils showAlertMsg:No_Internet_Connection_Message title:No_Internet_Connection_Title];
        }
        else if (result == REQUEST_FAILED)
        {
            NSLog(@"Error");
            [SUtils showAlertMsg:Request_Failiure_Message title:Request_Failiure_Title];
        }
        else if (result == ERROR_OCCURED)
        {
            [SUtils showAlertMsg:Request_Error_Message title:Request_Error_Title];
        }
        else if (result == REQUEST_SUCCEEDED){
            NSLog(@"success");
            self.username.text = [NSString stringWithFormat:@"Welcome, %@.", userNameString];
        }
        [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:userNameString waitUntilDone:NO];
    }];	
    
	[pool release];
    
}


- (void)removeOverLay:(NSString*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IBActions

- (IBAction)searchJobsButtonpressed:(id)sender
{    
    NSLog(@"searchJobs button pressed");
    
    MainScreen *mainScreen = [[MainScreen alloc] initWithNibName:@"MainScreen" bundle:nil];
    mainScreen.m_nHomeType = 0;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = mainScreen;
}

- (IBAction)favoriteJobsButtonpressed:(id)sender
{

    NSLog(@"favoriteJobs button pressed");
    MainScreen *mainScreen = [[MainScreen alloc] initWithNibName:@"MainScreen" bundle:nil];
    mainScreen.m_nHomeType = 1;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = mainScreen;
    
    
}

- (IBAction)upcomingEventsButtonpressed:(id)sender
{
    NSLog(@"upcomingEvents button pressed");
    MainScreen *mainScreen = [[MainScreen alloc] initWithNibName:@"MainScreen" bundle:nil];
    mainScreen.m_nHomeType = 2;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = mainScreen;
}

- (IBAction)myProfileButtonpressed:(id)sender
{
    NSLog(@"myProfile button pressed");
    MainScreen *mainScreen = [[MainScreen alloc] initWithNibName:@"MainScreen" bundle:nil];
    mainScreen.m_nHomeType = 3;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController = mainScreen;
}

- (IBAction) logoutButtonPressed: (id) sender 
{
     AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    delegate.viewController = [[ViewController alloc] initWithRootViewController:loginVC];
    delegate.window.rootViewController = delegate.viewController;
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:User_Name_Key_For_User_Defaults];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:Password_Key_For_User_Defaults];
}

#pragma mark - ADView Banner
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [banner setFrame:CGRectMake(0, 0, 320, 50)];
}

@end

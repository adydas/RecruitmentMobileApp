//
//  LoginVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginVC.h"
#import "MainScreen.h"
#import "AppDelegate.h"
#import "NetworkController.h"

@implementation LoginVC
@synthesize username, password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Home / Sign in";
        UIImageView *homeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:Login_Home_Icon]];
        homeImageView.frame = CGRectMake(-70, -10, 16, 16);
//                self.navigationItem.titleView = homeImageView;
        
        CGRect frame = CGRectMake(-80, -25, 200, 44);
        UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
        [label setBackgroundColor:[UIColor clearColor]];
        label.font = [UIFont boldSystemFontOfSize: 20.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:1];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = Login_Navigation_Bar_Title_Text;
        
        UIView *view = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.frame];
        view.backgroundColor = [UIColor yellowColor];
        [view addSubview:homeImageView];
        [view addSubview:label];
        self.navigationItem.titleView = view;



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
    self.navigationItem.hidesBackButton = YES;
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.username = nil;
    self.password = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc
{
    [self.username release];
    [self.password release];
    [super dealloc];
}


#pragma mark - IBActions

-(IBAction)loginButtonPressed:(id)sender
{
    NSString *userId = self.username.text;
    NSString *pwd = self.password.text;

    if(userId==nil||[userId isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                            message:@"Username cannot be empty."
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
        
    else if(pwd==nil||[pwd isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                            message:@"Password cannot be empty."
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else 
    {
            [[NSUserDefaults standardUserDefaults]
             setObject:userId forKey:User_Name_Key_For_User_Defaults];
            [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:Password_Key_For_User_Defaults];

            [self.view addSubview:darkView];
            [activityView startAnimating];
            [self performSelectorInBackground:@selector(performLogin) withObject:nil];
        }

} 
        
-(void)performLogin{

	[[NetworkController singleton] loginWithServer:^(int result, NSString *usernameString ) {
        if (result==NO_INTERNET) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:No_Internet_Connection_Title 
                                                            message:No_Internet_Connection_Message
                                                           delegate:nil cancelButtonTitle:Alert_Button_Title otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else if (result == REQUEST_FAILED)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: Request_Failiure_Title
                                  message: Login_Request_Failiure_Message
                                  delegate: nil
                                  cancelButtonTitle:Alert_Button_Title
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else if (result == ERROR_OCCURED)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:Request_Error_Title
                                  message: Request_Error_Message
                                  delegate: nil
                                  cancelButtonTitle:Alert_Button_Title
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else{
            [[NSUserDefaults standardUserDefaults] setObject:usernameString forKey:User_First_And_Last_Name];
            MainScreen *mainScreen = [[MainScreen alloc] initWithNibName:@"MainScreen" bundle:nil];
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            delegate.window.rootViewController = mainScreen;

            [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:usernameString waitUntilDone:NO];

        }

    }];
	    
}

-(void)removeOverLay:(NSString*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];

    [self.navigationController popViewControllerAnimated:YES];

    
    
}

        
-(IBAction)refreshButtonPressed:(id)sender
{
    NSLog(@"Refresh button pressed");
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	
    [textField resignFirstResponder];
    return YES;
}

@end

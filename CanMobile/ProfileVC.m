//
//  ProfileVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileVC.h"
#import "NetworkController.h"

@implementation ProfileVC

@synthesize m_bHome;
@synthesize accountInfoButton;


- (id)initWithNibNameHome:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bHome: (BOOL) bHome {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        m_bHome = bHome;
        
        UITabBarItem * tabtitle;
        if (m_bHome == YES) {
            tabtitle = [[UITabBarItem alloc] initWithTitle: @"Home"
                                                     image: [UIImage imageNamed:Home_tab_Image] //or your icon 
                                                       tag: 0];
            
            [self setTabBarItem: tabtitle];
            
            [self.tabBarController setHidesBottomBarWhenPushed: NO];
            
        } else {
            tabtitle = [[UITabBarItem alloc] initWithTitle: @"Profile"
                                                     image: [UIImage imageNamed:@"profile.png"] 
                                                       tag: 0];
        }

        [self setTabBarItem: tabtitle];
        [tabtitle release];
        
        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
        topLabel.textColor = [UIColor whiteColor];
        topLabel.backgroundColor = [UIColor clearColor];
        topLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15.0f];
        topLabel.text = @"eRecruiting from Experience.com";
        self.navigationItem.titleView = topLabel ;
        [topLabel release];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [super viewDidLoad];
        UITabBarItem * tabtitle = [[UITabBarItem alloc] initWithTitle: @"Profile"
                                                     image: [UIImage imageNamed:@"profile.png"] 
                                                       tag: 0];
        [self setTabBarItem: tabtitle];
        [tabtitle release];
        
        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
        topLabel.textColor = [UIColor whiteColor];
        topLabel.backgroundColor = [UIColor clearColor];
        topLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15.0f];
        topLabel.text = @"eRecruiting from Experience.com";
        self.navigationItem.titleView = topLabel ;
        [topLabel release];

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
    [[NetworkController singleton] getQRCodeFromServer:^(int result, NSData *imageData){
        if(result == REQUEST_SUCCEEDED){
            NSLog(@"%@", imageData);
            UIImage *image = [UIImage imageWithData:imageData];
            qRCodeImageView.image = image; 

            NSLog(@"Success");
        }else{
            NSLog(@"Error");
        }
    }];

//    self.username.text = @"beta@betauniversity.com";
//    self.studentId.text = @"N/A";
//    self.firstName.text = @"Ady";
//    self.lastName.text = @"Daz";
//    self.accountCreationDate.text = @"02/02/2010"; 

//    qRCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_01"]];
//    qRCodeImageView.frame = CGRectMake(25, 133, 270, 200);
//    [self.view addSubview:qRCodeImageView];
//    [qRCodeImageView setHidden:YES];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
//    self.username = nil;
//    self.studentId = nil;
//    self.firstName = nil;
//    self.lastName = nil;
//    self.accountCreationDate = nil;
    self.accountInfoButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc 
{
//    [self.username release];
//    [self.studentId release];
//    [self.firstName release];
//    [self.lastName release];
//    [self.accountCreationDate release];
    [self.accountInfoButton release];
    [super dealloc];
}

#pragma mark - IBActions

-(IBAction)accountInfoButtonPressed:(id)sender
{
//    if ([qRCodeImageView isHidden]) {
//        
//        [qRCodeImageView setHidden:NO];
//        [accountInfoButton setTitle:@"Display my personal QR code" forState:UIControlStateNormal];
//    } 
//    else
//    {
//        [qRCodeImageView setHidden:YES];
//        [accountInfoButton setTitle:@"Display my account information" forState:UIControlStateNormal];
//
//    }

}



@end

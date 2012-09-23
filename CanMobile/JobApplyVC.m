//
//  JobApplyVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobApplyVC.h"
#import "AppDelegate.h"
#import "QuartzCore/QuartzCore.h"

@implementation JobApplyVC
@synthesize m_labelLocation;
@synthesize m_textCover;

@synthesize jobBO;
@synthesize m_labelJobTitle;
@synthesize m_labelJobDesc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        jobBO = [[JobBO alloc] init];
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
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont fontWithName:Font_TrebuchetMS_Bold size:15.0f];
    topLabel.text = Navigation_Bar_Title_Text;
    self.navigationItem.titleView = topLabel ;
    
    m_textCover.layer.borderColor = [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133/255.0 alpha:1.0].CGColor;
    
    m_textCover.layer.borderWidth = 2;
    m_textCover.layer.cornerRadius = 10;
    m_textCover.layer.masksToBounds = YES;
    
    [m_labelJobTitle setText: jobBO.jobTitle];
    [m_labelJobDesc setText: [NSString stringWithFormat:@"%@ | %@", jobBO.employerName, jobBO.jobLocation]];
    [m_labelLocation setText: jobBO.jobLocation];


}

- (void)viewDidUnload
{
    [self setM_labelLocation:nil];
    [self setM_labelJobTitle:nil];
    [self setM_labelJobDesc:nil];
    [self setM_textCover:nil];
    
    self.jobBO                = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)dealloc {
    [m_labelLocation release];
    [m_labelJobTitle release];
    [m_labelJobDesc release];
    [m_textCover release];
    [jobBO release];
    [super dealloc];
}

#pragma mark - Actions
- (IBAction)onClickChooseResumeBtn:(id)sender {
    
}

- (IBAction)onClickApplyBtn:(id)sender {
    
}


@end

//
//  JobDetailVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobDetailVC.h"
#import "JobApplyVC.h"

@implementation JobDetailVC
@synthesize jobNameLabel, jobNameDetailedLabel, jobDetailTextView, jobBO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [topLabel release];
    
    
    jobNameLabel.text = jobBO.jobTitle;
    jobNameDetailedLabel.text = [NSString stringWithFormat:@"%@ | %@", jobBO.employerName, jobBO.jobLocation];
    jobDetailTextView.text = jobBO.jobDescription;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.jobNameLabel         = nil;
    self.jobNameDetailedLabel = nil;
    self.jobDetailTextView    = nil;
    self.jobBO                = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc 
{
    [self.jobNameLabel release];
    [self.jobNameDetailedLabel release];
    [self.jobDetailTextView release];
    [self.jobBO release];
    [super dealloc];
}

#pragma mark - IBActions

- (IBAction)jobApplyButtonPressed:(id)sender
{
    JobApplyVC *jobApplyVC = [[JobApplyVC alloc] initWithNibName:@"JobApplyVC" bundle:nil];

    [self.navigationController pushViewController:jobApplyVC animated:YES];
    
    [jobApplyVC release];

}
- (IBAction)favoriteButtonPressed:(id)sender
{

}

@end

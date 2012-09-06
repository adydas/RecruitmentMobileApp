//
//  JobApplyVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobApplyVC.h"
#import "AppDelegate.h"

@implementation JobApplyVC
@synthesize applyUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}



@end

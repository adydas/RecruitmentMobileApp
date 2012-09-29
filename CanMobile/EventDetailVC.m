//
//  EventDetailVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventDetailVC.h"

@implementation EventDetailVC
@synthesize eventDateLabel;
@synthesize eventNameLabel, descriptionLabel, locationLabel, dateLabel, timeLabel, eventBO;
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
    [super viewDidLoad];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont fontWithName:Font_TrebuchetMS_Bold size:15.0f];
    topLabel.text = Navigation_Bar_Title_Text;
    self.navigationItem.titleView = topLabel;
    [topLabel release];
    
    eventNameLabel.text = eventBO.eventName;
    descriptionLabel.text = eventBO.eventDescription;
    locationLabel.text = eventBO.eventlocation;
    dateLabel.text = eventBO.eventStartDate;
    timeLabel.text = [NSString stringWithFormat:@"%@ to %@", eventBO.eventStartTime, eventBO.eventEndTime];
    
    if ([eventBO.eventStartDate isEqualToString: eventBO.eventEndDate] == YES) {
        eventDateLabel.text = [NSString stringWithFormat:@"%@, %@-%@",eventBO.eventStartDate, eventBO.eventStartTime, eventBO.eventEndTime];        
    } else {
        eventDateLabel.text = [NSString stringWithFormat:@"%@-%@",eventBO.eventStartDate, eventBO.eventEndDate];        
    }

}

- (void)viewDidUnload
{
    [self setEventDateLabel:nil];
    [super viewDidUnload];
    self.eventNameLabel = nil;
    self.descriptionLabel = nil;
    self.locationLabel = nil; 
    self.dateLabel = nil;
    self.timeLabel = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc 
{
    [self.eventNameLabel release]; 
    [self.descriptionLabel release]; 
    [self.locationLabel release]; 
    [self.dateLabel release]; 
    [self.timeLabel release];
    [eventDateLabel release];
    [super dealloc];
}

#pragma mark - Actions
- (IBAction)onClickNavBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}
@end

//
//  EventsVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EventsVC.h"
#import "EventDetailVC.h"
#import "NetworkController.h"
#import "EventBO.h"

@implementation EventsVC
@synthesize tableview, events;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem * tabtitle = [[UITabBarItem alloc] initWithTitle: @"Events" image: [UIImage imageNamed:Events_tab_Image] tag: 0];
        
        [self setTabBarItem: tabtitle];
        [tabtitle release];
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
    
    [self initDarkView];
    [self getEventsList];

    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont fontWithName: Font_TrebuchetMS_Bold size:15.0f];
    topLabel.text = @"eRecruiting from Experience.com";
    self.navigationItem.titleView = topLabel ;
    [topLabel release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableview = nil;
    self.events = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc
{
    [self.tableview release];
    [self.events release];
    [super dealloc];
}


#pragma mark - TableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
//	UIImageView *cellBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"input_bg.png"]];
    static NSString *SimpleTableIdentifier = @"TableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:SimpleTableIdentifier] autorelease];
//        cell.backgroundView = cellBg;
        EventBO *eventBO = [events objectAtIndex:indexPath.row];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 20)];
        titleLabel.font = [UIFont fontWithName:Font_TrebuchetMS_Bold size:12.0f];
        titleLabel.text = eventBO.eventName;
        titleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
        
        
        subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 30)];
        subTitleLabel.font = [UIFont fontWithName:Font_HelveticaNeue size:10.0f];
        subTitleLabel.text = eventBO.eventDescription;
        subTitleLabel.backgroundColor = [UIColor clearColor];
        subTitleLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:subTitleLabel];
        [subTitleLabel release];
        
//        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        editButton.frame =  CGRectMake(220, 18, 20, 20);
//        [editButton setBackgroundImage:[UIImage imageNamed:@"edit_icon_job.png"] forState:UIControlStateNormal];
//        [cell.contentView addSubview:editButton];
//        
//        favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        favoriteButton.frame =  CGRectMake(245, 18, 20, 20);
//        [favoriteButton setBackgroundImage:[UIImage imageNamed:@"heart_icon_neg.png"] forState:UIControlStateNormal];
//        [favoriteButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];  
//        [cell.contentView addSubview:favoriteButton];
        
        detailDisclosureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        detailDisclosureButton.frame =  CGRectMake(275, 20, 15, 15);
        [detailDisclosureButton setBackgroundImage:[UIImage imageNamed:Detail_Disclosure_Arrow] forState:UIControlStateNormal];
        [detailDisclosureButton addTarget:self action:@selector(detailDiscolosureIndicatorSelected:) forControlEvents:UIControlEventTouchUpInside];  
        detailDisclosureButton.tag = [indexPath row];
        [cell.contentView addSubview:detailDisclosureButton];

    }
    
    	
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    	[tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

#pragma mark - IBActions



-(IBAction) detailDiscolosureIndicatorSelected: (id) sender
{
    
    EventDetailVC *eventDetailVC = [[EventDetailVC alloc] initWithNibName:@"EventDetailVC" bundle:nil];
    eventDetailVC.eventBO = [events objectAtIndex:[sender tag]];
    [self.navigationController pushViewController:eventDetailVC animated:YES];
    [eventDetailVC release];
    
}
//-(IBAction) favoriteButtonPressed: (id) sender
//{
//	NSLog(@"Favorite Button Pressed");
//    [favoriteButton setBackgroundImage:[UIImage imageNamed:@"heart_icon"] forState:UIControlStateNormal];
//    
//}


#pragma mark - TextField delegate method
//

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	
    [textField resignFirstResponder];
    return YES;
}

-(void) getEventsList
{
    [self.view addSubview:darkView];
    [activityView startAnimating];
    [[NetworkController singleton] getEventsFromServer:^(int result, NSMutableArray *eventsArray){
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
            self.events  = eventsArray;
            [self.tableview reloadData];
        }
        [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:eventsArray waitUntilDone:NO];
    }];
}

-(void)removeOverLay:(NSArray*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];
}


-(void)initDarkView{
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityView setCenter:CGPointMake(320/2.0, 480/2.0)]; // I do this because I'm in landscape mode
    [self.view addSubview:activityView];
    [activityView startAnimating];
    darkView = [[UIView alloc] initWithFrame:self.view.frame];
    darkView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:.5];
    [darkView addSubview:activityView];
    [self.view addSubview:darkView];
    
}



@end

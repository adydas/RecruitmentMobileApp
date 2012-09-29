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
#import "SUtils.h"

@implementation EventsVC

@synthesize m_bHome;
@synthesize m_eventCell;
@synthesize m_checkeventCell;
@synthesize m_segCtrl;
@synthesize m_searchBar;
@synthesize m_labelUnavailable;
@synthesize m_btnCheckin;
@synthesize tableview, events;

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
            tabtitle = [[UITabBarItem alloc] initWithTitle: @"Events" image: [UIImage imageNamed:Events_tab_Image] tag: 0];
            
        }        
        [self setTabBarItem: tabtitle];
        [tabtitle release];
        
    }
    return self;
}

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

    [self.navigationController setNavigationBarHidden: YES];
    
}

- (void)viewDidUnload
{
    [self setM_eventCell:nil];
    [self setM_segCtrl:nil];
    [self setM_checkeventCell:nil];
    [self setM_searchBar:nil];
    [self setM_labelUnavailable:nil];
    [self setM_btnCheckin:nil];
    [super viewDidUnload];
    self.tableview = nil;
    self.events = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc
{
    [self.tableview release];
    [self.events release];
    [m_eventCell release];
    [m_segCtrl release];
    [m_checkeventCell release];
    [m_searchBar release];
    [m_labelUnavailable release];
    [m_btnCheckin release];
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
   
    if (m_segCtrl.selectedSegmentIndex == 0) {
        EventBO *eventBO = nil;
        eventBO = [events objectAtIndex:indexPath.row];
        
        [[NSBundle mainBundle] loadNibNamed:@"EventListCell" owner:self options:nil];
        
        m_eventCell.m_labelName.text = eventBO.eventName;
        
        if ([eventBO.eventStartDate isEqualToString: eventBO.eventEndDate] == YES) {
            m_eventCell.m_labelDate.text = [NSString stringWithFormat:@"%@, %@-%@",eventBO.eventStartDate, eventBO.eventStartTime, eventBO.eventEndTime];        
        } else {
            m_eventCell.m_labelDate.text = [NSString stringWithFormat:@"%@-%@",eventBO.eventStartDate, eventBO.eventEndDate];        
        }
        
        return m_eventCell;
        
    }
    
    EventBO *eventBO = nil;
    eventBO = [events objectAtIndex:indexPath.row];
    
    [[NSBundle mainBundle] loadNibNamed:@"CheckEventListCell" owner:self options:nil];
    
    m_checkeventCell.m_labelTitle.text = eventBO.eventName;
    m_checkeventCell.m_labelLocation.text = eventBO.eventlocation;
    
    if ([eventBO.eventStartDate isEqualToString: eventBO.eventEndDate] == YES) {
        m_checkeventCell.m_labelDate.text = [NSString stringWithFormat:@"%@, %@-%@",eventBO.eventStartDate, eventBO.eventStartTime, eventBO.eventEndTime];        
    } else {
        m_checkeventCell.m_labelDate.text = [NSString stringWithFormat:@"%@-%@",eventBO.eventStartDate, eventBO.eventEndDate];        
    }
    
    return m_checkeventCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (m_segCtrl.selectedSegmentIndex == 0) {
        EventDetailVC *eventDetailVC = [[EventDetailVC alloc] initWithNibName:@"EventDetailVC" bundle:nil];
        eventDetailVC.eventBO = [self.events objectAtIndex:indexPath.row];
        NSLog(@"tag %d", indexPath.row);
        [self.navigationController pushViewController:eventDetailVC animated:YES];
        
        [eventDetailVC release];
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (m_segCtrl.selectedSegmentIndex == 0) {
        return 60;
    }
    
    return 77;
}



#pragma mark - TextField delegate method
//

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Members
- (void) getEventsList
{
    [self.view addSubview:darkView];
    [activityView startAnimating];
    [[NetworkController singleton] getEventsFromServer:^(int result, NSMutableArray *eventsArray){
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

        else if(result == REQUEST_SUCCEEDED){
            self.events  = eventsArray;
            [self.tableview reloadData];
        }
        [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:eventsArray waitUntilDone:NO];
    }];
}

- (void)removeOverLay:(NSArray*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];
}


- (void)initDarkView {
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityView setCenter:CGPointMake(320/2.0, 480/2.0)]; // I do this because I'm in landscape mode
    [self.view addSubview:activityView];
    [activityView startAnimating];
    darkView = [[UIView alloc] initWithFrame:self.view.frame];
    darkView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:.5];
    [darkView addSubview:activityView];
    [self.view addSubview:darkView];
    
}

#pragma mark - IBActions

- (IBAction) detailDiscolosureIndicatorSelected: (id) sender
{
    
    EventDetailVC *eventDetailVC = [[EventDetailVC alloc] initWithNibName:@"EventDetailVC" bundle:nil];
    eventDetailVC.eventBO = [events objectAtIndex:[sender tag]];
    [self.navigationController pushViewController:eventDetailVC animated:YES];
    [eventDetailVC release];
    
}

- (IBAction)onSegValueChanged:(id)sender {
    [tableview reloadData];
}

#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [m_searchBar resignFirstResponder];
    
    NSString *searchKeyword = m_searchBar.text;
    NSLog(@"%@", searchKeyword);
    
    /*
    if (searchKeyword != nil || searchKeyword != (id)[NSNull null]) {
        [[NetworkController singleton] getSearchedJobsFromServer:searchKeyword andCallBack:^(int result, NSMutableArray *jobs1){
            if(result == REQUEST_SUCCEEDED){
                self.jobs  = jobs1;
                [self.tableview reloadData];
            }else{
                NSLog(@"Error");
            }
        }];
        
    }
     */
    
}


@end

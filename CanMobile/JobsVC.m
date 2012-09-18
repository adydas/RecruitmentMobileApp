//
//  JobsVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JobsVC.h"
#import "JobDetailVC.h"
#import "NetworkController.h"
#import "JobBO.h"
#import "JobApplyVC.h"
#import "FavoriteJobsVC.h"
#import "SUtils.h"

@implementation JobsVC
@synthesize m_JobListCell;
@synthesize keywordSearch,tableview, jobs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UITabBarItem * tabtitle = [[UITabBarItem alloc] initWithTitle: @"Jobs"
                                                                image: [UIImage imageNamed:Jobs_tab_Image] //or your icon 
                                                                  tag: 0];
        
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
        
    [self getJobsList];
        
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont fontWithName:Font_TrebuchetMS_Bold size:15.0f];
    topLabel.text = Navigation_Bar_Title_Text;
    self.navigationItem.titleView = topLabel ;
    [topLabel release];

}

- (void)viewDidUnload
{
    [self setM_JobListCell:nil];
    [super viewDidUnload];
    self.keywordSearch = nil;
    self.tableview     = nil;
    self.jobs          = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc 
{
    [self.keywordSearch release];
    [self.tableview release];
    [self.jobs release];
    [m_JobListCell release];
    [super dealloc];
}

#pragma mark - TableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [jobs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobBO *jobBo = nil;
    jobBo = [self.jobs objectAtIndex:indexPath.row];
    
    [[NSBundle mainBundle] loadNibNamed:@"JobListCell" owner:self options:nil];
    
    m_JobListCell.m_labelTitle.text = jobBo.jobTitle;
    m_JobListCell.m_labelDescription.text = [NSString stringWithFormat:@"%@ | %@", jobBo.employerName, jobBo.jobLocation];
    
    m_JobListCell.m_btnEdit.tag = indexPath.row;
    m_JobListCell.m_btnFavorite.tag = indexPath.row;
    m_JobListCell.m_btnDetail.tag = indexPath.row;
    
    return m_JobListCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JobDetailVC *jobDetailVC = [[JobDetailVC alloc] initWithNibName:@"JobDetailVC" bundle:nil];
    jobDetailVC.jobBO = [self.jobs objectAtIndex:indexPath.row];
    NSLog(@"tag %d", indexPath.row);
    [self.navigationController pushViewController:jobDetailVC animated:YES];
    
    [jobDetailVC release];

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


#pragma mark - IBActions
- (IBAction)goButtonPressed:(id)sender
{
    NSString *searchKeyword = keywordSearch.text;
    NSLog(@"%@", searchKeyword);
    
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
    
}

- (IBAction) detailDiscolosureIndicatorSelected: (id) sender
{
    JobDetailVC *jobDetailVC = [[JobDetailVC alloc] initWithNibName:@"JobDetailVC" bundle:nil];
        jobDetailVC.jobBO = [self.jobs objectAtIndex:[sender tag]];
    NSLog(@"tag %d",[ sender tag]);
    [self.navigationController pushViewController:jobDetailVC animated:YES];

    [jobDetailVC release];

}

- (IBAction) applyForJobButtonSelected: (id) sender
{
    JobApplyVC *jobApplyVC = [[JobApplyVC alloc] initWithNibName:@"JobApplyVC" bundle:nil];
    JobBO *jobBO = [self.jobs objectAtIndex:[sender tag]];
    jobApplyVC.applyUrl = jobBO.jobApplyUrl;
    [self.navigationController pushViewController:jobApplyVC animated:YES];
    
    [jobApplyVC release];
}


- (IBAction) addToFavoritesButtonpressed: (id) sender
{
    /*
    FavoriteJobsVC *favoriteJobsVC = [[FavoriteJobsVC alloc] init];
    [self.navigationController pushViewController:favoriteJobsVC animated:YES];
    
    [favoriteJobsVC release];
     */
}


#pragma mark - TextField delegate method
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
	
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Logic
- (void) getJobsList
{
    [self.view addSubview:darkView];
    [activityView startAnimating];
    [[NetworkController singleton] getJobsFromServer:^(int result, NSMutableArray *jobs1)
    {
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
            self.jobs  = jobs1;
            [self.tableview reloadData];
            
        }
        [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:jobs1 waitUntilDone:NO];
    }];
}

- (void)removeOverLay:(NSArray*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];
    
    //[self.navigationController popViewControllerAnimated:YES];
}

@end

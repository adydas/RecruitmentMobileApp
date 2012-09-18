//
//  FavoriteJobsVC.m
//  CanMobile
//
//  Created by Aliza Qasim on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteJobsVC.h"
#import "JobDetailVC.h"
#import "NetworkController.h"
#import "JobBO.h"
#import "JobApplyVC.h"

@implementation FavoriteJobsVC
@synthesize m_favJobListCell;
@synthesize tableview, favoriteJobs;

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
    [self getFavoriteJobsList];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 30)];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = [UIFont fontWithName:Font_TrebuchetMS_Bold size:17.0f];
    topLabel.text = Navigation_Bar_Title_Text;
    self.navigationItem.titleView = topLabel ;
}

- (void)viewDidUnload
{
    [self setM_favJobListCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - TableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return [favoriteJobs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobBO *jobBo = nil;
    jobBo = [self.favoriteJobs objectAtIndex:indexPath.row];
    
    [[NSBundle mainBundle] loadNibNamed:@"FavJobListCell" owner:self options:nil];
    
    m_favJobListCell.m_labelTitle.text = jobBo.jobTitle;
    m_favJobListCell.m_labelDescription.text = [NSString stringWithFormat:@"%@ | %@", jobBo.employerName, jobBo.jobLocation];
    m_favJobListCell.m_btnEdit.tag = indexPath.row;
    m_favJobListCell.m_btnFavorite.tag = indexPath.row;
    m_favJobListCell.m_btnDetail.tag = indexPath.row;
    
    return m_favJobListCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JobDetailVC *jobDetailVC = [[JobDetailVC alloc] initWithNibName:@"JobDetailVC" bundle:nil];
    jobDetailVC.jobBO = [self.favoriteJobs objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:jobDetailVC animated:YES];
    
    [jobDetailVC release];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

#pragma mark - IBActions

- (IBAction) detailDiscolosureIndicatorSelected: (id) sender
{
    JobDetailVC *jobDetailVC = [[JobDetailVC alloc] initWithNibName:@"JobDetailVC" bundle:nil];
    jobDetailVC.jobBO = [self.favoriteJobs objectAtIndex:[sender tag]];
    NSLog(@"tag %d",[ sender tag]);
    [self.navigationController pushViewController:jobDetailVC animated:YES];
    
    [jobDetailVC release];
    
    
}
- (IBAction) applyForJobButtonSelected: (id) sender
{
    JobApplyVC *jobApplyVC = [[JobApplyVC alloc] initWithNibName:@"JobApplyVC" bundle:nil];
    JobBO *jobBO = [self.favoriteJobs objectAtIndex:[sender tag]];
    jobApplyVC.applyUrl = jobBO.jobApplyUrl;
    [self.navigationController pushViewController:jobApplyVC animated:YES];
    
    [jobApplyVC release];
}

- (void) getFavoriteJobsList
{
    [self.view addSubview:darkView];
    [activityView startAnimating];
    [[NetworkController singleton] getFavoriteJobsFromServer:^(int result, NSMutableArray *jobs){
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
            self.favoriteJobs  = jobs;
            [self.tableview reloadData];
        }
        [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:jobs waitUntilDone:NO];
    }];

}

- (void)removeOverLay:(NSString*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];
    
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [m_favJobListCell release];
    [super dealloc];
}
@end

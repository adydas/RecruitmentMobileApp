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
	static NSString *SimpleTableIdentifier = @"TableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:SimpleTableIdentifier] autorelease];
        
        jobBo = [self.favoriteJobs objectAtIndex:indexPath.row];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 20)];
        titleLabel.font = [UIFont fontWithName:Font_TrebuchetMS_Bold size:12.0f];
        titleLabel.text = jobBo.jobTitle;
        titleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:titleLabel];
        
        
        subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 200, 30)];
        subTitleLabel.font = [UIFont fontWithName:Font_HelveticaNeue size:10.0f];
        subTitleLabel.text = jobBo.employerName;
        subTitleLabel.backgroundColor = [UIColor clearColor];
        subTitleLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:subTitleLabel];
        
        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame =  CGRectMake(220, 18, 20, 20);
        [editButton setBackgroundImage:[UIImage imageNamed:Job_Apply_Button] forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(applyForJobButtonSelected:) forControlEvents:UIControlEventTouchUpInside]; 
        editButton.tag = indexPath.row;
        [cell.contentView addSubview:editButton];
        
        favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        favoriteButton.frame =  CGRectMake(245, 18, 20, 20);
        [favoriteButton setBackgroundImage:[UIImage imageNamed:Heart_Icon_Job] forState:UIControlStateNormal];
        
        [cell.contentView addSubview:favoriteButton];
        
        
        detailDisclosureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        detailDisclosureButton.frame =  CGRectMake(275, 20, 15, 15);
        [detailDisclosureButton setBackgroundImage:[UIImage imageNamed:Detail_Disclosure_Arrow] forState:UIControlStateNormal];
        [detailDisclosureButton addTarget:self action:@selector(detailDiscolosureIndicatorSelected:) forControlEvents:UIControlEventTouchUpInside];  
        detailDisclosureButton.tag = indexPath.row;
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
    JobDetailVC *jobDetailVC = [[JobDetailVC alloc] initWithNibName:@"JobDetailVC" bundle:nil];
    jobDetailVC.jobBO = [self.favoriteJobs objectAtIndex:[sender tag]];
    NSLog(@"tag %d",[ sender tag]);
    [self.navigationController pushViewController:jobDetailVC animated:YES];
    
    [jobDetailVC release];
    
    
}
-(IBAction) applyForJobButtonSelected: (id) sender
{
    JobApplyVC *jobApplyVC = [[JobApplyVC alloc] initWithNibName:@"JobApplyVC" bundle:nil];
    JobBO *jobBO = [self.favoriteJobs objectAtIndex:[sender tag]];
    jobApplyVC.applyUrl = jobBO.jobApplyUrl;
    [self.navigationController pushViewController:jobApplyVC animated:YES];
    
    [jobApplyVC release];
}

-(void) getFavoriteJobsList
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

-(void)removeOverLay:(NSString*) results{    
    
    [activityView stopAnimating];
	[darkView removeFromSuperview];
    
    //[self.navigationController popViewControllerAnimated:YES];
}

@end

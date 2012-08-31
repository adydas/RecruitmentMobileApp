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
#import "SUtils.h"

@implementation JobsVC
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
        
//        [[NetworkController singleton] getJobsFromServer:nil];
    
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
	        JobBO *jobBo =nil;
	static NSString *SimpleTableIdentifier = @"TableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell == nil)
    {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:SimpleTableIdentifier] autorelease];    

        jobBo = [self.jobs objectAtIndex:indexPath.row];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 20)];
        titleLabel.font = [UIFont fontWithName:Font_TrebuchetMS_Bold size:12.0f];
        titleLabel.text = jobBo.jobTitle;
        titleLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
        
        
        subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 30)];
        subTitleLabel.font = [UIFont fontWithName:Font_HelveticaNeue size:10.0f];
        subTitleLabel.text = jobBo.employerName;
        subTitleLabel.backgroundColor = [UIColor clearColor];
        subTitleLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:subTitleLabel];
        [subTitleLabel release];
        
        editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.frame =  CGRectMake(220, 20, 20, 20);
        [editButton setBackgroundImage:[UIImage imageNamed:Job_Apply_Button] forState:UIControlStateNormal];
        [editButton addTarget:self action:@selector(applyForJobButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:editButton];
        
        favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        favoriteButton.frame =  CGRectMake(245, 20, 20, 20);
        [favoriteButton setBackgroundImage:[UIImage imageNamed:Favorite_Star_Button] forState:UIControlStateNormal];
        [favoriteButton addTarget:self action:@selector(addToFavoritesButtonpressed:) forControlEvents:UIControlEventTouchUpInside];
        favoriteButton.tag = indexPath.row;
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
//    [[NetworkController singleton] getJobDetailsFromServer:^(bool success, NSMutableArray *jobs1){
//        if(success){
//            self.jobs  = jobs1;
//            [self.tableview reloadData];
//        }else{
//            NSLog(@"Error");
//        }
//    }];

    
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
    [[NetworkController singleton] getJobsFromServer:^(int result, NSMutableArray *jobs1){
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

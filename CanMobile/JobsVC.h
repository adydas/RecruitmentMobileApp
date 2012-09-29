//
//  JobsVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobListCell.h"

@interface JobsVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    IBOutlet UIView *darkView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic) BOOL  m_bHome;

@property (retain, nonatomic) IBOutlet UISearchBar *m_searchBar;
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet JobListCell *m_JobListCell;


@property (nonatomic, retain)   NSMutableArray *jobs;

- (IBAction) applyForJobButtonSelected: (id) sender;
- (IBAction) addToFavoritesButtonpressed: (id) sender;
- (IBAction) detailDiscolosureIndicatorSelected: (id) sender;


- (void) getJobsList;
- (id)initWithNibNameHome:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil bHome: (BOOL) bHome;



@end

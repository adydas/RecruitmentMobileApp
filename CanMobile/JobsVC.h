//
//  JobsVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobListCell.h"

@interface JobsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIView *darkView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic, retain) IBOutlet UITextField *keywordSearch;
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet JobListCell *m_JobListCell;


@property (nonatomic, retain)   NSMutableArray *jobs;

- (IBAction) goButtonPressed:(id)sender;
- (IBAction) applyForJobButtonSelected: (id) sender;
- (IBAction) addToFavoritesButtonpressed: (id) sender;
- (IBAction) detailDiscolosureIndicatorSelected: (id) sender;

- (void) getJobsList;



@end

//
//  FavoriteJobsVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavJobListCell.h"

@interface FavoriteJobsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIView *darkView;
    IBOutlet UIActivityIndicatorView *activityView;
}

@property (nonatomic) BOOL  m_bHome;
@property (retain, nonatomic) IBOutlet FavJobListCell *m_favJobListCell;
@property (nonatomic, retain) IBOutlet UITableView *tableview;
@property (nonatomic, retain) NSMutableArray *favoriteJobs;

- (void) getFavoriteJobsList;

- (IBAction) applyForJobButtonSelected: (id) sender;

@end


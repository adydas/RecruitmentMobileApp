//
//  ProfileVC.h
//  CanMobile
//
//  Created by Aliza Qasim on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController 

{
    IBOutlet UIImageView *qRCodeImageView;
}

@property (nonatomic, retain) IBOutlet UIButton *accountInfoButton;
//@property (nonatomic, retain) IBOutlet UILabel *username;
//@property (nonatomic, retain) IBOutlet UILabel *studentId;
//@property (nonatomic, retain) IBOutlet UILabel *firstName;
//@property (nonatomic, retain) IBOutlet UILabel *lastName;
//@property (nonatomic, retain) IBOutlet UILabel *accountCreationDate;

-(IBAction)accountInfoButtonPressed:(id)sender;
//-(IBAction)downArrowButtonPressed:(id)sender;
@end

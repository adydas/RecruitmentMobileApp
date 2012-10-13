//
//  SelectLoginVC.m
//  CanMobile
//
//  Created by Optiplex790 on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectLoginVC.h"
#import "LoginVC.h"
#import "NetworkController.h"
#import "SUtils.h"

@interface SelectLoginVC ()

@end

@implementation SelectLoginVC
@synthesize m_viewPicker;
@synthesize m_pickerView;
@synthesize m_states;
@synthesize m_collages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationController.navigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    m_states = [[NSMutableArray alloc] init];
    m_collages = [[NSMutableArray alloc] init];
    
    [self getStateList];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setM_viewPicker:nil];
    [self setM_pickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [m_viewPicker release];
    [m_pickerView release];
    [m_states release];
    [m_collages release];
    [super dealloc];
}

#pragma mark - Logic functions

- (void) getStateList
{
//    [self.view addSubview:darkView];
//    [activityView startAnimating];
    [[NetworkController singleton] getStatesFromServer:^(int result, NSMutableArray *states)
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
         else if (result == REQUEST_SUCCEEDED){
             self.m_states  = states;
             
         }
  //       [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:jobs1 waitUntilDone:NO];
     }];
}

- (void) getCollageList
{
    //    [self.view addSubview:darkView];
    //    [activityView startAnimating];
    [[NetworkController singleton] getCollagesFromServer:^(int result, NSMutableArray *collages)
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
         else if (result == REQUEST_SUCCEEDED){
             self.m_collages  = collages;
             
         }
         //       [self performSelectorOnMainThread:@selector(removeOverLay:) withObject:jobs1 waitUntilDone:NO];
     }];
}



#pragma mark - Picker View Delegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == m_pickerView)
    {
        return 0;
    }
    
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == m_pickerView) {
        return 1;
    }
    
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if (pickerView == m_pickerView)
	{
		return nil;
	}
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

/**
 ** Show Drop Down menu
 **/

- (void) ShowDropdown {
    
    if (m_viewPicker.hidden == NO)
        return;

    // Animation
    [m_viewPicker setFrame: CGRectMake(0, self.view.frame.size.height, m_viewPicker.frame.size.width, m_viewPicker.frame.size.height)];
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: 0.7f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:nil];
    
    [m_viewPicker setFrame: CGRectMake(0, self.view.frame.size.height - m_viewPicker.frame.size.height, m_viewPicker.frame.size.width, m_viewPicker.frame.size.height)];
    [m_viewPicker setHidden: NO];
    
	[UIView commitAnimations];
    
}

- (void) HideDropdown {
    if (m_viewPicker.hidden == YES)
        return;
    
    // Animation
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration: 0.7f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:@selector(datepickerAnimationEnded)];
    
    [m_viewPicker setFrame: CGRectMake(0, self.view.frame.size.height, m_viewPicker.frame.size.width, m_viewPicker.frame.size.height)];
    
	[UIView commitAnimations];
    
}

- (void) datepickerAnimationEnded {
    [m_viewPicker setHidden: YES];
}

#pragma mark - Actions

- (IBAction)onClickChooseStateBtn:(id)sender {
    [self ShowDropdown];
}


- (IBAction)onClickChooseSchoolBtn:(id)sender {
    [self ShowDropdown];
}

- (IBAction)onClickLoginBtn:(id)sender {
    LoginVC *loginVC = [[LoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    [loginVC release];
}

- (IBAction)onClickDoneBtn:(id)sender {
    [self HideDropdown];
}

@end

//
//  RecordingsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "RecordingsViewController.h"
#import "PatientsViewController.h"
#import "ViewConstants.h"

@implementation RecordingsViewController

@synthesize tableView, searchBar, createNewRecordingButton, patientsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (IBAction)viewPatients:(id)sender
{
    PatientsViewController *patientsViewController = [[PatientsViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:patientsViewController];
    self.patientsPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
    [self.patientsPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (IBAction)createNewRecording:(id)sender
{
    
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self.patientsPopover dismissPopoverAnimated:YES];
}

- (void)newPatientViewControllerSubmitButtonPressed:(NewPatientViewController *)npvc
{
    
}

@end

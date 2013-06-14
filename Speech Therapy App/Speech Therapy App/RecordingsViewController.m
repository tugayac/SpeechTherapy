//
//  RecordingsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "RecordingsViewController.h"
#import "NewPatientViewController.h"
#import "PatientsViewController.h"
#import "Patient.h"
#import "ViewConstants.h"

@implementation RecordingsViewController

@synthesize tableView, searchBar, createNewRecordingButton, patientsButton;
@synthesize currentUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom init
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
    [self.navigationItem setHidesBackButton:NO];
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
    if (!self.patientsPopover) {
        PatientsViewController *patientsViewController = [[PatientsViewController alloc] init];
        patientsViewController.currentUser = self.currentUser;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:patientsViewController];
        self.patientsPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
        [self.patientsPopover setDelegate:self];
        [self.patientsPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        [self.patientsPopover dismissPopoverAnimated:YES];
        self.patientsPopover = nil;
    }
}

- (IBAction)createNewRecording:(id)sender
{
    
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.patientsPopover = nil;
}

@end

//
//  RecordingsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "RecordingsViewController.h"
#import "NewPatientViewController.h"
#import "TestsViewController.h"
#import "Patient.h"
#import "ViewConstants.h"

@implementation RecordingsViewController

@synthesize tableView, searchBar, startNewTestButton, patientsButton;
@synthesize currentUser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
    [self.navigationItem setHidesBackButton:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.patientsPopover) {
        [self.patientsPopover dismissPopoverAnimated:YES];
        self.patientsPopover = nil;
    }
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
        patientsViewController.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:patientsViewController];
        self.patientsPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
        [self.patientsPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        [self.patientsPopover dismissPopoverAnimated:YES];
        self.patientsPopover = nil;
    }
}

- (IBAction)startNewRecording:(id)sender
{
    
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.patientsPopover = nil;
}

- (void)didDismissPatientsPopover:(PatientsViewController *)pvc
{
    [self.patientsPopover dismissPopoverAnimated:YES];
    self.patientsPopover = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kShowTests]) {
        TestsViewController *testsViewController = segue.destinationViewController;
        testsViewController.currentUser = self.currentUser;
    }
}

@end

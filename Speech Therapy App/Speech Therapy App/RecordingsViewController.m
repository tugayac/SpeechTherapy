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
#import "Test.h"
#import "ViewConstants.h"

@implementation RecordingsViewController

@synthesize recordingsTable, searchBar, patientsButton, currentPatient;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *rightButtonItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Start New Test" style:UIBarButtonItemStyleBordered target:self action:@selector(startNewTestButtonTouched)];
    [rightButtonItems addObject:button];
    button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:nil];
    [rightButtonItems addObject:button];
    [self.navigationItem setRightBarButtonItems:rightButtonItems];
    
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
    [self.navigationItem setHidesBackButton:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tests = [Test getTestsForPatient:self.currentPatient];
    [self.recordingsTable reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.patientsPopover) {
        [self.patientsPopover dismissPopoverAnimated:YES];
        self.patientsPopover = nil;
    }
}

- (void)startNewTestButtonTouched
{
    [self performSegueWithIdentifier:kShowTests sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tests count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecordingCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kRecordingCellIdentifier];
    }
    
    Test *test = [self.tests objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = test.testName;
    cell.detailTextLabel.text = [Test dateToString:test.dateStarted withFormat:NSDateFormatterFullStyle];
    
    return cell;
}

- (IBAction)viewPatients:(id)sender
{
    if (!self.patientsPopover) {
        PatientsViewController *patientsViewController = [[PatientsViewController alloc] init];
        patientsViewController.currentUser = self.currentUser;
        patientsViewController.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:patientsViewController];
        self.patientsPopover = [[UIPopoverController alloc] initWithContentViewController:navController];
        self.patientsPopover.delegate = self;
        [self.patientsPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        [self.patientsPopover dismissPopoverAnimated:YES];
        self.patientsPopover = nil;
    }
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

- (void)selectedPatient:(Patient *)patient
{
    self.currentPatient = patient;
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Recordings for %@", patient.lastName]];
    self.tests = [Test getTestsForPatient:self.currentPatient];
    [self.recordingsTable reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kShowTests]) {
        TestsViewController *testsViewController = segue.destinationViewController;
        testsViewController.currentPatient = self.currentPatient;
    }
}

@end

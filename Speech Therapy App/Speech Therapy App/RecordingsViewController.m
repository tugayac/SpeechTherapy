//
//  RecordingsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <dropbox/dropbox.h>

#import "RecordingsViewController.h"
#import "NewPatientViewController.h"
#import "TestsViewController.h"
#import "Patient.h"
#import "Test.h"
#import "ViewConstants.h"

@interface RecordingsViewController ()

@property (nonatomic, strong) NSMutableArray *selectedRows;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *deleteButton;
@property (nonatomic, strong) UploadingViewController *uvc;

@end

@implementation RecordingsViewController

@synthesize recordingsTable, searchBar, patientsButton, currentPatient;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedRows = [[NSMutableArray alloc] init];
    
    [self.recordingsTable setAllowsMultipleSelectionDuringEditing:YES];
    
    NSMutableArray *rightButtonItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Start New Test" style:UIBarButtonItemStyleBordered target:self action:@selector(startNewTestButtonTouched)];
    [rightButtonItems addObject:button];
    self.editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(enableEditMode)];
    [self.editButton setEnabled:NO];
    [rightButtonItems addObject:self.editButton];
    [self.navigationItem setRightBarButtonItems:rightButtonItems];
    
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
    [self.navigationItem setHidesBackButton:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tests = [[Test getTestsForPatient:self.currentPatient] mutableCopy];
    [self.recordingsTable reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.patientsPopover) {
        [self.patientsPopover dismissPopoverAnimated:YES];
        self.patientsPopover = nil;
    }
}

- (void)enableEditMode
{
    if ([self.recordingsTable isEditing]) {
        [self.recordingsTable setEditing:NO animated:YES];
        [self.recordingsTable setFrame:CGRectMake(self.recordingsTable.frame.origin.x, self.recordingsTable.frame.origin.y, self.recordingsTable.frame.size.width, self.recordingsTable.frame.size.height + 44)];

        CGAffineTransform translateOut = CGAffineTransformMakeTranslation(0, 44);
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.footerView.transform = translateOut;
        } completion:^(BOOL finished) {
            [self.footerView setHidden:YES];
            [self.view bringSubviewToFront:self.recordingsTable];
        }];
    } else {
        [self.recordingsTable setEditing:YES animated:YES];
        [self.recordingsTable setFrame:CGRectMake(self.recordingsTable.frame.origin.x, self.recordingsTable.frame.origin.y, self.recordingsTable.frame.size.width, self.recordingsTable.frame.size.height - 44)];
        [self.footerView setHidden:NO];
        [self.view bringSubviewToFront:self.footerView];
        
        CGAffineTransform translateIn = CGAffineTransformMakeTranslation(0, -44);
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.footerView.transform = translateIn;
        } completion:nil];
    }
}

- (UIView *)addFooterForEditMode
{
    UIToolbar *footerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.recordingsTable.frame.origin.y + self.recordingsTable.frame.size.height, self.recordingsTable.frame.size.width, 44)];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    UIBarButtonItem *fixedSpacingBeforeDeleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    [fixedSpacingBeforeDeleteButton setWidth:(([UIScreen mainScreen].bounds.size.width / 4.0) - (150 / 2.0) - 10)];
    [buttons addObject:fixedSpacingBeforeDeleteButton];
    self.deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteTestsButtonTouched)];
    [self.deleteButton setTintColor:[UIColor redColor]];
    [self.deleteButton setWidth:150];
    [buttons addObject:self.deleteButton];
    UIBarButtonItem *fixedSpacingBeforeSendButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    [fixedSpacingBeforeSendButton setWidth:(([UIScreen mainScreen].bounds.size.width / 2) - 150 - 20)];
    [buttons addObject:fixedSpacingBeforeSendButton];
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send to Dropbox" style:UIBarButtonItemStyleDone target:self action:@selector(sendToDropbox)];
    [sendButton setWidth:150];
    [buttons addObject:sendButton];
    [footerToolbar setItems:buttons animated:YES];
    
    [footerToolbar setHidden:YES];
    
    return footerToolbar;
}

- (void)deleteTestsButtonTouched
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    NSArray *listOfSoundFiles = [self listOfSoundFilesAtDirectory:docsDir];
    for (Test *test in self.selectedRows) {            
        for (NSString *file in listOfSoundFiles) {
            if ([file isEqualToString:test.resultsPath]) {
                [Test removeTest:test];
                [self.tests removeObject:test];
                
                NSError *error;
                [[NSFileManager defaultManager] removeItemAtPath:[docsDir stringByAppendingPathComponent:file] error:&error];
                if (error) {
                    NSLog(@"error: %@", [error localizedDescription]);
                    return;
                }
            }
        }
    }
    
    [self.recordingsTable reloadData];
}

- (NSArray *)listOfSoundFilesAtDirectory:(NSString *)dir
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:dir]) {
        NSError *error;
        
        NSArray *listOfAllFiles = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:dir error:&error]];
        if (error) {
            NSLog(@"error: %@", [error localizedDescription]);
            return nil;
        }
        NSArray *listOfExtensions = [NSArray arrayWithObject:@"wav"];
        NSArray *listOfSoundFiles = [listOfAllFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension IN %@", listOfExtensions]];
        
        return listOfSoundFiles;
    } else {
        return nil;
    }
}

- (void)startNewTestButtonTouched
{
    if (!self.currentPatient) {
        UIAlertView *patientNotSelected = [[UIAlertView alloc] initWithTitle:@"Patient not Selected" message:@"Please select a patient before starting a new test." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [patientNotSelected setAlertViewStyle:UIAlertViewStyleDefault];
        [patientNotSelected show];
    } else {
        [self performSegueWithIdentifier:kShowTests sender:self];
    }
}

- (void)sendToDropbox
{
    DBAccount *account = [DBAccountManager sharedManager].linkedAccount;
    if (account) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
        [DBFilesystem setSharedFilesystem:filesystem];
        
        if ([self.selectedRows count] > 0) {
            self.uvc = [[UploadingViewController alloc] initWithFileToUpload:self.selectedRows];
            [self.view addSubview:self.uvc.view];
        }
    } else {
        [[DBAccountManager sharedManager] linkFromController:self.navigationController];
    }
}

-(void)uploadComplete:(UploadingViewController *)uvc
{
    [self.uvc.view removeFromSuperview];
    self.uvc.view = nil;
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.recordingsTable.isEditing) {
        [self.selectedRows removeObject:[self.tests objectAtIndex:[indexPath row]]];
        [self.deleteButton setTitle:[NSString stringWithFormat:@"Delete (%d)", [self.selectedRows count]]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.recordingsTable.isEditing) {
        [self.selectedRows addObject:[self.tests objectAtIndex:[indexPath row]]];
        [self.deleteButton setTitle:[NSString stringWithFormat:@"Delete (%d)", [self.selectedRows count]]];
    }
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
    self.tests = [[Test getTestsForPatient:self.currentPatient] mutableCopy];
    [self.recordingsTable reloadData];
    
    if (!self.footerView) {
        self.footerView = [self addFooterForEditMode];
        [self.view addSubview:self.footerView];
        [self.editButton setEnabled:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kShowTests] && self.currentPatient) {
        TestsViewController *testsViewController = segue.destinationViewController;
        testsViewController.currentPatient = self.currentPatient;
    }
}

@end

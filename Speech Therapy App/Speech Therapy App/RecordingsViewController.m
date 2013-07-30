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
#import "AudioPlayerViewController.h"
#import "Patient.h"
#import "Test.h"
#import "ViewConstants.h"

int const EditingModeBottomToolbarHeight = 44;

@interface RecordingsViewController ()

@property (nonatomic, strong) NSMutableArray *selectedRows;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIBarButtonItem *editButton;
@property (nonatomic, strong) UIBarButtonItem *deleteButton;
@property (nonatomic, strong) UploadingViewController *uvc;

@end

@implementation RecordingsViewController

@synthesize recordingsTable, searchBar, patientsButton, currentPatient;

- (void)setNavigationBarRightButtonItems
{
    NSMutableArray *rightButtonItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Start New Test" style:UIBarButtonItemStyleBordered target:self action:@selector(startNewTestButtonTouched)];
    [rightButtonItems addObject:button];
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(enableEditMode)];
    [self.editButton setEnabled:NO];
    [rightButtonItems addObject:self.editButton];
    [self.navigationItem setRightBarButtonItems:rightButtonItems];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedRows = [[NSMutableArray alloc] init];
    
    [self.recordingsTable setAllowsMultipleSelectionDuringEditing:YES];
    
    [self setNavigationBarRightButtonItems];
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

- (void)prepareForEditingModeWithEditButtonStyle:(UIBarButtonItemStyle)style title:(NSString *)title recordingsTableIsEditing:(BOOL)editing frame:(CGRect)rect
{
    [self.editButton setStyle:style];
    [self.editButton setTitle:title];
    [self.recordingsTable setEditing:editing animated:YES];
    [self.recordingsTable setFrame:rect];
}

- (void)enableEditMode
{
    if ([self.recordingsTable isEditing]) {
        [self prepareForEditingModeWithEditButtonStyle:UIBarButtonItemStyleBordered
                                                 title:@"Edit"
                              recordingsTableIsEditing:NO
                                                 frame:CGRectMake(self.recordingsTable.frame.origin.x,
                                                                  self.recordingsTable.frame.origin.y,
                                                                  self.recordingsTable.frame.size.width,
                                                                  self.recordingsTable.frame.size.height + EditingModeBottomToolbarHeight)];
        CGAffineTransform translateOut = CGAffineTransformMakeTranslation(0, EditingModeBottomToolbarHeight);
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.footerView.transform = translateOut;
        } completion:^(BOOL finished) {
            [self.footerView setHidden:YES];
            [self.view bringSubviewToFront:self.recordingsTable];
        }];
    } else {
        [self.deleteButton setTitle:@"Delete"];
        [self prepareForEditingModeWithEditButtonStyle:UIBarButtonItemStyleDone
                                                 title:@"Done"
                              recordingsTableIsEditing:YES
                                                 frame:CGRectMake(self.recordingsTable.frame.origin.x,
                                                                  self.recordingsTable.frame.origin.y,
                                                                  self.recordingsTable.frame.size.width,
                                                                  self.recordingsTable.frame.size.height - EditingModeBottomToolbarHeight)];
        [self.footerView setHidden:NO];
        [self.view bringSubviewToFront:self.footerView];
        
        CGAffineTransform translateIn = CGAffineTransformMakeTranslation(0, -EditingModeBottomToolbarHeight);
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.footerView.transform = translateIn;
        } completion:nil];
    }
}

- (UIBarButtonItem *)generateFixedSpaceBeforeButtonWithWidth:(CGFloat)width
{
    UIBarButtonItem *fixedSpacingBeforeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    [fixedSpacingBeforeButton setWidth:width];
    return fixedSpacingBeforeButton;
}

- (UIBarButtonItem *)generateEditingModeToolbarButtonWithName:(NSString *)name style:(UIBarButtonItemStyle)style selector:(SEL)selector width:(CGFloat)width
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:name style:style target:self action:selector];
    [barButton setWidth:width];
    return barButton;
}

- (UIView *)addFooterForEditMode
{
    UIToolbar *footerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.recordingsTable.frame.origin.y + self.recordingsTable.frame.size.height, self.recordingsTable.frame.size.width, 44)];
    
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    [buttons addObject:[self generateFixedSpaceBeforeButtonWithWidth:(([UIScreen mainScreen].bounds.size.width / 4.0) - (150 / 2.0) - 10)]];
    
    self.deleteButton = [self generateEditingModeToolbarButtonWithName:@"Delete"
                                                                 style:UIBarButtonItemStyleBordered
                                                              selector:@selector(deleteTestsButtonTouched)
                                                                 width:150];
    [self.deleteButton setTintColor:[UIColor redColor]];
    [buttons addObject:self.deleteButton];
    [buttons addObject:[self generateFixedSpaceBeforeButtonWithWidth:(([UIScreen mainScreen].bounds.size.width / 2) - 150 - 20)]];
    
    [buttons addObject:[self generateEditingModeToolbarButtonWithName:@"Send to Dropbox"
                                                                style:UIBarButtonItemStyleDone
                                                             selector:@selector(sendToDropbox)
                                                                width:150]];
    
    [footerToolbar setItems:buttons animated:YES];
    [footerToolbar setHidden:YES];
    return footerToolbar;
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
            self.uvc = [[UploadingViewController alloc] initWithFilesToUpload:self.selectedRows];
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
    } else {
        AudioPlayerViewController *apvc = [[AudioPlayerViewController alloc] init];
        apvc.currentTest = [self.tests objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:apvc animated:YES];
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
        [self didDismissPatientsPopover:nil];
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

//
//  PatientsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "PatientsViewController.h"
#import "NewPatientViewController.h"
#import "Patient.h"

@implementation PatientsViewController

@synthesize patientsTable, createNewPatientButton, doneButton;
@synthesize currentUser;

- (id)init
{
    self = [super init];
    if (self) {
        self.patientsTable = [[UITableView alloc] init];
        [self.patientsTable setDataSource:self];
        [self.patientsTable setDelegate:self];
        
        self.createNewPatientButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewPatient:)];
        [self.navigationItem setLeftBarButtonItem:self.createNewPatientButton];
        
        self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:nil];
        [self.navigationItem setRightBarButtonItem:self.doneButton];
        
        self.patients = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [self setView:self.patientsTable];
    
    self.patients = [[Patient getPatientsForUser:self.currentUser] mutableCopy];
    [self.patientsTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.patients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PatientCell"];
    }
    
    Patient *patient = [self.patients objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = patient.firstName;
    
    return cell;
}

- (CGSize)contentSizeForViewInPopover
{
    return CGSizeMake(320, 600);
}

- (void)createNewPatient:(id)sender
{
    NewPatientViewController *newPatientViewController = [[NewPatientViewController alloc] init];
    newPatientViewController.currentUser = self.currentUser;
    newPatientViewController.delegate = self;
    CGRect xibBounds = newPatientViewController.view.bounds;
    [newPatientViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [newPatientViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:newPatientViewController animated:YES completion:nil];
    
    newPatientViewController.view.superview.bounds = xibBounds;
}

- (void)modalFormViewControllerSubmitButtonTouched:(ModalFormViewController *)mfvc
{
    NewPatientViewController *npvc = (NewPatientViewController *) mfvc;
    Patient *patient = [Patient addPatientWithUsername:npvc.usernameField.text firstName:npvc.firstNameField.text lastName:npvc.lastNameField.text typeOfAutism:npvc.typeOfAutismField.text supervisor:self.currentUser];
    [self.patients insertObject:patient atIndex:0];
    [self.patientsTable reloadData];
}

@end

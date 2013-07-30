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

int const PopoverWidth = 320;
int const PopoverHeight = 600;

@implementation PatientsViewController

@synthesize patientsTable, currentUser;

- (id)init
{
    self = [super init];
    if (self) {
        self.patientsTable = [[UITableView alloc] init];
        [self.patientsTable setDataSource:self];
        [self.patientsTable setDelegate:self];
        
        UIBarButtonItem *createNewPatientButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewPatient)];
        [self.navigationItem setLeftBarButtonItem:createNewPatientButton];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTouched)];
        UIBarButtonItem *removePatientButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removePatient)];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:doneButton, removePatientButton, nil]];
        
        self.patients = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PatientCell"];
    }
    
    Patient *patient = [self.patients objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    cell.detailTextLabel.text = patient.typeOfAutism;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [Patient removePatient:[self.patients objectAtIndex:[indexPath row]]];
        [self.patients removeObjectAtIndex:[indexPath row]];
        [self.patientsTable reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectedPatient:)]) {
        [self.delegate selectedPatient:[self.patients objectAtIndex:[indexPath row]]];
    }
    
    if ([self.delegate respondsToSelector:@selector(didDismissPatientsPopover:)]) {
        [self.delegate didDismissPatientsPopover:self];
    }
}

- (CGSize)contentSizeForViewInPopover
{
    return CGSizeMake(PopoverWidth, PopoverHeight);
}

- (void)createNewPatient
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

- (void)removePatient
{
    if ([self.patientsTable isEditing]) {
        [self.patientsTable setEditing:NO animated:YES];
    } else {
        [self.patientsTable setEditing:YES animated:YES];
    }
}

- (void)doneButtonTouched
{
    if ([self.delegate respondsToSelector:@selector(didDismissPatientsPopover:)]) {
        [self.delegate didDismissPatientsPopover:self];
    }
}

- (void)modalFormViewControllerSubmitButtonTouched:(ModalFormViewController *)mfvc
{
    NewPatientViewController *npvc = (NewPatientViewController *) mfvc;
    Patient *patient = [Patient addPatientWithUsername:npvc.usernameField.text firstName:npvc.firstNameField.text lastName:npvc.lastNameField.text typeOfAutism:npvc.typeOfAutismField.text supervisor:self.currentUser];
    [self.patients insertObject:patient atIndex:0];
    [self.patientsTable reloadData];
}

@end

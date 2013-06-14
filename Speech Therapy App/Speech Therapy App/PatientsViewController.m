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
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {   
        self.patientsTable = [[UITableView alloc] init];
        [self setView:self.patientsTable];
        
        self.createNewPatientButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewPatient:)];
        [self.navigationItem setLeftBarButtonItem:self.createNewPatientButton];
        
        self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:nil];
        [self.navigationItem setRightBarButtonItem:self.doneButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.patients = [[NSMutableArray alloc] init];
    self.patients = [[Patient getPatientsForUser:self.currentUser] mutableCopy];
    [self.patientsTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.patients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell" forIndexPath:indexPath];
    
    Patient *patient = [self.patients objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = patient.username;
    
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
    CGRect xibBounds = newPatientViewController.view.bounds;
    [newPatientViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [newPatientViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:newPatientViewController animated:YES completion:nil];
    
    newPatientViewController.view.superview.bounds = xibBounds;
}

- (void)modalFormViewControllerDelegateSubmitButtonTouched:(ModalFormViewController *)mfvc
{
    NewPatientViewController *npvc = (NewPatientViewController *) mfvc;
    Patient *patient = [Patient addPatientWithUsername:npvc.usernameField.text firstName:npvc.firstNameField.text lastName:npvc.lastNameField.text typeOfAutism:npvc.typeOfAutismField.text supervisor:self.currentUser];
    [self.patients insertObject:patient atIndex:0];
    [self.patientsTable reloadData];
}

@end

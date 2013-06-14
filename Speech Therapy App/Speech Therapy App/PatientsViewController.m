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

@synthesize tableView, createNewPatientButton, doneButton;

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
    
    self.tableView = [[UITableView alloc] init];
//    [self.view addSubview:self.tableView];
    
    self.createNewPatientButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewPatient:)];
    [self.navigationItem setLeftBarButtonItem:self.createNewPatientButton];
    
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:nil];
    [self.navigationItem setRightBarButtonItem:self.doneButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGSize)contentSizeForViewInPopover
{
    return CGSizeMake(320, 600);
}

- (IBAction)createNewPatient:(id)sender
{
    NewPatientViewController *newPatientViewController = [[NewPatientViewController alloc] init];
    CGRect xibBounds = newPatientViewController.view.bounds;
    [newPatientViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    [newPatientViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:newPatientViewController animated:YES completion:nil];
    
    newPatientViewController.view.superview.bounds = xibBounds;
}

@end

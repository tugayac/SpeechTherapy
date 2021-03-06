//
//  RecordingsViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModalFormViewController.h"
#import "User.h"
#import "PatientsViewController.h"
#import "UploadingViewController.h"

extern int const EditingModeBottomToolbarHeight;

@interface RecordingsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate, PatientsPopoverDelegate, UploadingViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *recordingsTable;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *patientsButton;

@property (nonatomic, strong) UIPopoverController *patientsPopover;
@property (nonatomic, strong) NSMutableArray *tests;
@property (nonatomic, strong) Patient *currentPatient;
@property (nonatomic, strong) User *currentUser;

- (IBAction)viewPatients:(id)sender;

@end

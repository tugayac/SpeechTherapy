//
//  RecordingsViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPatientViewController.h"

@interface RecordingsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate, NewPatientViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *patientsButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *createNewRecordingButton;

@property (nonatomic, strong) UIPopoverController *patientsPopover;

- (IBAction)viewPatients:(id)sender;
- (IBAction)createNewRecording:(id)sender;

@end

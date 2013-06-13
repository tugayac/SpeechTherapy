//
//  PatientsViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *createNewPatientButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *doneButton;

- (IBAction)createNewPatient:(id)sender;

@end

//
//  PatientsViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *createNewPatientButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

- (IBAction)createNewPatient:(id)sender;

@end

//
//  PatientsViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/12/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModalFormViewController.h"
#import "User.h"

@interface PatientsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ModalFormViewControllerDelegate>

@property (nonatomic, strong) UITableView *patientsTable;
@property (nonatomic, strong) UIBarButtonItem *createNewPatientButton;
@property (nonatomic, strong) UIBarButtonItem *doneButton;

@property (nonatomic, strong) NSMutableArray *patients;
@property (nonatomic, strong) User *currentUser;

- (void)createNewPatient:(id)sender;

@end

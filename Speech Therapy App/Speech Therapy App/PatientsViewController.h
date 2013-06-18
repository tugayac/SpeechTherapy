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

@protocol PatientsPopoverDelegate;

@interface PatientsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ModalFormViewControllerDelegate>

@property (nonatomic, weak) id<PatientsPopoverDelegate> delegate;

@property (nonatomic, strong) UITableView *patientsTable;

@property (nonatomic, strong) NSMutableArray *patients;
@property (nonatomic, strong) User *currentUser;

- (void)createNewPatient;
- (void)removePatient;
- (void)doneButtonTouched;

@end

@protocol PatientsPopoverDelegate <NSObject>

@optional
- (void)didDismissPatientsPopover:(PatientsViewController *)pvc;
- (void)selectedPatient:(Patient *)patient;

@end
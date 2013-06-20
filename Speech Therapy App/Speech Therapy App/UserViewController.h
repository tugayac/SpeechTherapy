//
//  UserViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModalFormViewController.h"
#import "UserCollectionViewLayout.h"
#import "User.h"

@interface UserViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, ModalFormViewControllerDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate, CollectionViewLayoutDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *userCollection;

@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) User *selectedUser;

- (IBAction)addNewUser:(id)sender;
- (void)enterDeletionMode:(UILongPressGestureRecognizer *)gr;
- (void)exitDeletionMode:(UITapGestureRecognizer *)gr;
- (void)removeUser:(UIButton *)button;

@end

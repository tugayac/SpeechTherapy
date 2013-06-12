//
//  UserViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewUserViewController.h"

@interface UserViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, NewUserViewControllerDelegate> {
    NSMutableArray *users;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, strong) IBOutlet UICollectionView *userCollection;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

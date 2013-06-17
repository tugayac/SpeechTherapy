//
//  TestsViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/17/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface TestsViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) IBOutlet UICollectionView *testsCollection;

@property (nonatomic, strong) NSMutableArray *tests;
@property (nonatomic, strong) User *currentUser;

@end

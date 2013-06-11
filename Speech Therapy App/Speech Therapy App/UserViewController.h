//
//  UserViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/10/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate> {
    NSMutableArray *users;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, strong) IBOutlet UICollectionView *userCollection;
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)addUserWithUsername:(NSString *)username firstName:(NSString *)firstName lastName:(NSString *)lastName imageFile:(NSString *)imageURL;

@end

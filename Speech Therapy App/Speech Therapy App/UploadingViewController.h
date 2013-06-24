//
//  UploadingViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/23/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UploadingViewControllerDelegate;

@interface UploadingViewController : UIViewController

@property (nonatomic, weak) id<UploadingViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIProgressView *uploadProgress;
@property (nonatomic, weak) IBOutlet UILabel *uploadLabel;

- (id)initWithFileToUpload:(NSArray *)files;

@end

@protocol UploadingViewControllerDelegate <NSObject>

@optional
- (void)uploadComplete:(UploadingViewController *)uvc;

@end
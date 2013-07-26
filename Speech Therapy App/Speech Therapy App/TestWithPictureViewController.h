//
//  TestWithPictureViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 7/24/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "User.h"

@interface TestWithPictureViewController : UIViewController<AVAudioRecorderDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *revolvingImage;
@property (nonatomic, weak) IBOutlet UIButton *recordButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;
@property (nonatomic, weak) IBOutlet UILabel *imageTitle;

@property (nonatomic, strong) Patient *currentPatient;

@end

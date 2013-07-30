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

extern int const BitRate;
extern int const Channels;
extern float const SampleRate;

@interface TestWithPictureViewController : UIViewController<AVAudioRecorderDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *revolvingImageView;
@property (nonatomic, weak) IBOutlet UIButton *recordButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;
@property (nonatomic, weak) IBOutlet UILabel *imageTitle;

@property (nonatomic, strong) NSArray *listOfImageFiles;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *testName;

@property (nonatomic, strong) Patient *currentPatient;

- (void)setImages;

@end

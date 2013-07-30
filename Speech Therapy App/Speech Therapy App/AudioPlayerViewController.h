//
//  AudioPlayerViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 7/25/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Test.h"

extern double const SecondsInAMinute;
extern float const NotesCornerRadius;
extern float const NotesBorderWidth;
extern NSString *const PlayButtonImageFileName;
extern NSString *const StopButtonImageFileName;

@interface AudioPlayerViewController : UIViewController<AVAudioPlayerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *playAndStopButton;
@property (nonatomic, weak) IBOutlet UIButton *pauseButton;
@property (nonatomic, weak) IBOutlet UISlider *audioProgressSlider;
@property (nonatomic, weak) IBOutlet UILabel *timeLeft;
@property (nonatomic, weak) IBOutlet UILabel *timeElapsed;
@property (nonatomic, weak) IBOutlet UILabel *totalDuration;
@property (nonatomic, weak) IBOutlet UILabel *dateStarted;
@property (nonatomic, weak) IBOutlet UILabel *dateCompleted;
@property (nonatomic, weak) IBOutlet UITextView *notesView;

@property (nonatomic, strong) Test *currentTest;

@end

//
//  TestWithPictureViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 7/24/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "TestWithPictureViewController.h"
#import "Test.h"

int imageCounter = 0;

@interface TestWithPictureViewController ()

@property (nonatomic, strong) NSArray *listOfImageFiles;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSString *fileName;

- (void)handleSwipeGestureFrom:(UIGestureRecognizer *)gestureRecognizer;
- (IBAction)recordAudioButtonPressed:(id)sender;
- (IBAction)stopRecordButtonPressed:(id)sender;

@end

@implementation TestWithPictureViewController

@synthesize listOfImageFiles, stopButton, recordButton;

- (id)init
{
    self.listOfImageFiles = [[NSArray alloc] initWithObjects:@"head.png", @"tree.png", @"green.png", @"sleep.png", @"ear.png", @"teeth.png", @"needle.png", @"cheese.png", @"sneeze.png", @"wheel.png", nil];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"MMddYY_hhmmssa";
    self.fileName = [[dateFormat stringFromDate:[NSDate date]] stringByAppendingString:@".wav"];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:self.fileName];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityHigh],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt:2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSettings error:&error];
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [self.audioRecorder prepareToRecord];
    }
    
    return [self initWithNibName:@"TestWithPictureViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.stopButton setEnabled:NO];
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestureFrom:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    [self.revolvingImage setImage:[UIImage imageNamed:[self.listOfImageFiles objectAtIndex:imageCounter]]];
    [self.revolvingImage setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageTitle setText:@"Head"];
}

- (void)handleSwipeGestureFrom:(UIGestureRecognizer *)gestureRecognizer
{
    imageCounter++;
    if (imageCounter < 10) {
        NSMutableString *imageTitleString = [[NSMutableString alloc] initWithString:[self.listOfImageFiles objectAtIndex:imageCounter]];
        [imageTitleString deleteCharactersInRange:NSMakeRange(imageTitleString.length - 4, 4)];
        [imageTitleString replaceCharactersInRange:NSMakeRange(0, 1) withString:[[imageTitleString substringToIndex:1] capitalizedString]];
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.revolvingImage.alpha = 0.0f;
            self.imageTitle.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                [self.revolvingImage setImage:[UIImage imageNamed:[self.listOfImageFiles objectAtIndex:imageCounter]]];
                [self.imageTitle setText:imageTitleString];
                self.revolvingImage.alpha = 1.0f;
                self.imageTitle.alpha = 1.0f;
            }];
        }];
    } else {
        UIAlertView *doneAlertView = [[UIAlertView alloc] initWithTitle:@"Good Job!" message:@"You've completed the test. Awesome Job!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [doneAlertView show];
        
        if (self.audioRecorder.recording) {
            NSLog(@"Done Recording...");
            [self.audioRecorder stop];
            [Test addNewResultForTest:@"Voice Recording" takenBy:self.currentPatient startingOn:self.startTime endingOn:[NSDate date] withResult:self.fileName withNotes:@"None"];
        } else if (self.audioPlayer.playing) {
            [self.audioPlayer stop];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)recordAudioButtonPressed:(id)sender
{
    if (!self.audioRecorder.recording) {
        NSLog(@"Started Recording...");
        [self.stopButton setEnabled:YES];
        [self.recordButton setEnabled:NO];
        self.startTime = [NSDate date];
        [self.audioRecorder record];
    }
}

- (IBAction)stopRecordButtonPressed:(id)sender
{
    UIAlertView *interruptAlertView = [[UIAlertView alloc] initWithTitle:@"Audio Recording Stopped" message:@"Audio recording was interrupted by user." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [interruptAlertView show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encode error occured: %@", error.localizedDescription);
}

@end

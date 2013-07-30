//
//  TestWithPictureViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 7/24/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "TestWithPictureViewController.h"
#import "Test.h"

int const BitRate = 16;
int const Channels = 2;
float const SampleRate = 44100.0f;

int imageCounter;

@implementation TestWithPictureViewController

@synthesize listOfImageFiles, stopButton, recordButton;

- (void)setImages
{
    self.listOfImageFiles = [[NSArray alloc] initWithObjects:@"head.png", @"tree.png", @"green.png", @"sleep.png", @"ear.png", @"teeth.png", @"needle.png", @"cheese.png", @"sneeze.png", @"wheel.png", nil];
}

- (void)generateStringFromCurrentDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"MMddYY_hhmmssa";
    self.fileName = [[dateFormat stringFromDate:[NSDate date]] stringByAppendingString:@".wav"];
}

- (NSURL *)generateSoundFileURL
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:self.fileName];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    return soundFileURL;
}

- (id)init
{
    imageCounter = 0;
    [self setImages];

    [self generateStringFromCurrentDate];
    NSURL *soundFileURL = [self generateSoundFileURL];
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityHigh],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:BitRate],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt:Channels],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:SampleRate],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSettings error:&error];
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [self.audioRecorder prepareToRecord];
    }
    
    return [self initWithNibName:@"TestWithPictureViewController" bundle:nil];
}

- (void)setupRevolvingImageView
{
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestureFrom:)];
    [swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    [self.revolvingImageView setImage:[UIImage imageNamed:[self.listOfImageFiles objectAtIndex:imageCounter]]];
    [self.revolvingImageView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupRevolvingImageView];
    [self.imageTitle setText:@"Head"];
    [self.stopButton setEnabled:NO];
    
    UIAlertView *testNameAlertView  = [[UIAlertView alloc] initWithTitle:@"Test Name" message:@"Please enter a name for the test:" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [testNameAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [testNameAlertView show];
}

- (NSMutableString *)generateImageTitleFromImageFileName
{
    NSMutableString *imageTitleString = [[NSMutableString alloc] initWithString:[self.listOfImageFiles objectAtIndex:imageCounter]];
    [imageTitleString deleteCharactersInRange:NSMakeRange(imageTitleString.length - 4, 4)];
    [imageTitleString replaceCharactersInRange:NSMakeRange(0, 1) withString:[[imageTitleString substringToIndex:1] capitalizedString]];
    return imageTitleString;
}

- (void)handleSwipeGestureFrom:(UIGestureRecognizer *)gestureRecognizer
{
    [self recordAudioButtonPressed:nil];
    
    imageCounter++;
    if (imageCounter < [self.listOfImageFiles count]) {
        NSMutableString *imageTitleString = [self generateImageTitleFromImageFileName];
        
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.revolvingImageView.alpha = 0.0f;
            self.imageTitle.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                [self.revolvingImageView setImage:[UIImage imageNamed:[self.listOfImageFiles objectAtIndex:imageCounter]]];
                [self.imageTitle setText:imageTitleString];
                self.revolvingImageView.alpha = 1.0f;
                self.imageTitle.alpha = 1.0f;
            }];
        }];
    } else {
        UIAlertView *doneAlertView = [[UIAlertView alloc] initWithTitle:@"Awesome Job!" message:@"You've completed the test. You can enter notes here if you want to: "delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [doneAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [doneAlertView show];
        
        if (self.audioRecorder.recording) {
            [self.audioRecorder stop];
        }
    }
}

- (IBAction)recordAudioButtonPressed:(id)sender
{
    if (!self.audioRecorder.recording) {
        [self.stopButton setEnabled:YES];
        [self.recordButton setEnabled:NO];
        self.startTime = [NSDate date];
        [self.audioRecorder record];
    }
}

- (IBAction)stopRecordButtonPressed:(id)sender
{
    UIAlertView *interruptAlertView = [[UIAlertView alloc] initWithTitle:@"Audio Recording Stopped" message:@"Audio recording was interrupted by user." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [interruptAlertView show];
    
    [self.audioRecorder stop];
    
    NSURL *soundFileURL = [self generateSoundFileURL];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtURL:soundFileURL error:&error];
    if (error) {
        NSLog(@"Error occured while deleting: %@", error.localizedDescription);
    }
    
    self.audioRecorder = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Test Name"]) {
        self.testName = [[alertView textFieldAtIndex:0] text];
    } else if ([alertView.title isEqualToString:@"Awesome Job!"]) {
        if ([self.fileName length] == 0) {
            [self generateStringFromCurrentDate];
        }
        [Test addNewResultForTest:self.testName takenBy:self.currentPatient startingOn:self.startTime endingOn:[NSDate date] withResult:self.fileName withNotes:[[alertView textFieldAtIndex:0] text]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encode error occured: %@", error.localizedDescription);
}

@end

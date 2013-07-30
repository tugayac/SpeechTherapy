//
//  AudioPlayerViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 7/25/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "AudioPlayerViewController.h"

#import <QuartzCore/QuartzCore.h>

double const SecondsInAMinute = 60.0;
float const NotesCornerRadius = 5.0f;
float const NotesBorderWidth = 1.0f;
NSString *const PlayButtonImageFileName = @"play.png";
NSString *const StopButtonImageFileName = @"stopLarge.png";

@interface AudioPlayerViewController ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSTimer *audioProgressSliderTimer;

- (IBAction)playAndStopButtonPressed:(id)sender;
- (IBAction)pauseButtonPressed:(id)sender;
- (void)updateProgressSlider;

@end

@implementation AudioPlayerViewController

- (id)init
{
    return [self initWithNibName:@"AudioPlayerViewController" bundle:nil];
}

- (void)setupAudioPlayer
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:self.currentTest.resultsPath];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.audioPlayer.delegate = self;
    
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    }
}

- (void)setupNotesTextView
{
    [self.notesView.layer setCornerRadius:NotesCornerRadius];
    [self.notesView.layer setMasksToBounds:YES];
    [self.notesView.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.notesView.layer setBorderWidth:NotesBorderWidth];
}

- (void)setTimeLabelsWithTotalDuration:(NSTimeInterval)totalDuration andCurrentTime:(NSTimeInterval)currentTime
{
    [self.timeLeft setText:[NSString stringWithFormat:@"%.0f:%02.0f", (totalDuration - currentTime) / SecondsInAMinute, fmod(totalDuration - currentTime, SecondsInAMinute)]];
    [self.timeElapsed setText:[NSString stringWithFormat:@"%.0f:%02.0f", currentTime / SecondsInAMinute, fmod(currentTime, SecondsInAMinute)]];
}

- (void)setValuesOfUIElements
{
    NSTimeInterval time = [self.audioPlayer duration];
    [self setTimeLabelsWithTotalDuration:time andCurrentTime:0.0];
    [self.totalDuration setText:[NSString stringWithFormat:@"%.0f:%02.0f", time / SecondsInAMinute, fmod(time, SecondsInAMinute)]];
    [self.audioProgressSlider setMaximumValue:time];
    [self.dateStarted setText:[self.currentTest.dateStarted descriptionWithLocale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]];
    [self.dateCompleted setText:[self.currentTest.dateStarted descriptionWithLocale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]];
    [self.notesView setText:self.currentTest.notes];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pauseButton setEnabled:NO];
    
    [self setupAudioPlayer];
    [self setupNotesTextView];
    [self setValuesOfUIElements];
}

- (void)setPlayAndStopButtonImageTo:(UIImage *)image AndEnablePauseButton:(BOOL)enable
{
    [self.playAndStopButton setImage:image forState:UIControlStateNormal];
    [self.pauseButton setEnabled:enable];
}

- (void)resetAudioPlayer
{
    [self.audioProgressSliderTimer invalidate];
    self.audioProgressSliderTimer = nil;
    [self.audioPlayer setCurrentTime:0.0];
    [self.audioProgressSlider setValue:0.0 animated:YES];
}

- (IBAction)playAndStopButtonPressed:(id)sender
{
    if (!self.audioPlayer.playing) {
        [self setPlayAndStopButtonImageTo:[UIImage imageNamed:StopButtonImageFileName] AndEnablePauseButton:YES];
        self.audioProgressSliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgressSlider) userInfo:nil repeats:YES];
        [self.audioPlayer play];
    } else {
        NSTimeInterval time = [self.audioPlayer duration];
        [self setTimeLabelsWithTotalDuration:time andCurrentTime:0.0];
        [self setPlayAndStopButtonImageTo:[UIImage imageNamed:PlayButtonImageFileName] AndEnablePauseButton:NO];
        [self resetAudioPlayer];
        [self.audioPlayer stop];
    }
}

- (IBAction)pauseButtonPressed:(id)sender
{
    if (self.audioPlayer.playing) {
        [self.playAndStopButton setEnabled:NO];
        [self.audioPlayer pause];
    } else {
        [self.playAndStopButton setEnabled:YES];
        [self.audioPlayer play];
    }
}

- (void)updateProgressSlider
{
    NSTimeInterval currentTime = [self.audioPlayer currentTime];
    NSTimeInterval totalDuration = [self.audioPlayer duration];
    [self.audioProgressSlider setValue:currentTime animated:YES];
    [self setTimeLabelsWithTotalDuration:totalDuration andCurrentTime:currentTime];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self setPlayAndStopButtonImageTo:[UIImage imageNamed:PlayButtonImageFileName] AndEnablePauseButton:NO];
    [self resetAudioPlayer];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Decode error occured: %@", error.localizedDescription);
}

@end

//
//  AudioPlayerViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 7/25/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "AudioPlayerViewController.h"

#import <QuartzCore/QuartzCore.h>

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pauseButton setEnabled:NO];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:self.currentTest.resultsPath];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.audioPlayer.delegate = self;

    NSTimeInterval time = [self.audioPlayer duration];
    [self.totalDuration setText:[NSString stringWithFormat:@"%.0f:%02.0f", time / 60.0, fmod(time, 60.0)]];
    [self.dateStarted setText:[self.currentTest.dateStarted descriptionWithLocale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]];
    [self.dateCompleted setText:[self.currentTest.dateStarted descriptionWithLocale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]]];
    
    [self.notesView.layer setCornerRadius:5.0f];
    [self.notesView.layer setMasksToBounds:YES];
    [self.notesView.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.notesView.layer setBorderWidth:1.0f];
    [self.notesView setText:self.currentTest.notes];
    
    [self.audioProgressSlider setMaximumValue:time];
    [self.timeLeft setText:[NSString stringWithFormat:@"%.0f:%02.0f", time / 60.0, fmod(time, 60.0)]];
    
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    }
}

- (IBAction)playAndStopButtonPressed:(id)sender
{
    if (!self.audioPlayer.playing) {
        [self.playAndStopButton setImage:[UIImage imageNamed:@"stopLarge.png"] forState:UIControlStateNormal];
        self.audioProgressSliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgressSlider) userInfo:nil repeats:YES];
        [self.audioPlayer play];
        [self.pauseButton setEnabled:YES];
    } else {
        [self.playAndStopButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        [self.audioProgressSliderTimer invalidate];
        self.audioProgressSliderTimer = nil;
        [self.audioPlayer setCurrentTime:0.0];
        [self.audioProgressSlider setValue:0.0 animated:YES];
        [self.audioPlayer stop];
        [self.pauseButton setEnabled:NO];
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
    [self.audioProgressSlider setValue:currentTime animated:YES];
    
    NSTimeInterval totalDuration = [self.audioPlayer duration];
    [self.timeElapsed setText:[NSString stringWithFormat:@"%.0f:%02.0f", currentTime / 60.0, fmod(currentTime, 60.0)]];
    [self.timeLeft setText:[NSString stringWithFormat:@"%.0f:%02.0f", (totalDuration - currentTime) / 60.0, fmod(totalDuration - currentTime, 60.0)]];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.pauseButton setEnabled:NO];
    [self.playAndStopButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self.audioPlayer setCurrentTime:0.0];
    [self.audioProgressSlider setValue:0.0 animated:YES];
    [self.audioProgressSliderTimer invalidate];
    self.audioProgressSliderTimer = nil;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Decode error occured: %@", error.localizedDescription);
}

@end

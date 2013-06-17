//
//  VoiceRecordViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/14/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "VoiceRecordViewController.h"

@implementation VoiceRecordViewController

@synthesize audioPlayer, audioRecorder;

- (id)init
{
    return [self initWithNibName:@"VoiceRecordViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.playButton setEnabled:NO];
    [self.stopButton setEnabled:NO];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"MMddYY_hhmmssa";
    NSString *dateString = [[dateFormat stringFromDate:[NSDate date]] stringByAppendingString:@".wav"];
    
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:dateString];
    
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
}

- (IBAction)recordAudio:(id)sender
{
    if (!self.audioRecorder.recording) {
        [self.playButton setEnabled:NO];
        [self.stopButton setEnabled:YES];
        [self.audioRecorder record];
    }
}

- (IBAction)playAudio:(id)sender
{
    if (!self.audioRecorder.recording) {
        [self.stopButton setEnabled:YES];
        [self.recordButton setEnabled:NO];
        
        NSError *error;
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioRecorder.url error:&error];
        self.audioPlayer.delegate = self;
        
        if (error) {
            NSLog(@"error: %@", [error localizedDescription]);
        } else {
            [self.audioPlayer play];
        }
    }
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:docsDir]) {
        NSError *error;
        
        NSArray *listOfSoundFiles = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:docsDir error:nil]];
        if (error) {
            NSLog(@"error: %@", [error localizedDescription]);
        }
        
        for (NSString *file in listOfSoundFiles) {
            NSString *selectedSound = [docsDir stringByAppendingPathComponent:[listOfSoundFiles objectAtIndex:0]];
            NSLog(@"%@", selectedSound);
        }
    }
}

- (IBAction)stop:(id)sender
{
    [self.stopButton setEnabled:NO];
    [self.playButton setEnabled:YES];
    [self.recordButton setEnabled:YES];
    
    if (self.audioRecorder.recording) {
        [self.audioRecorder stop];
    } else if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
    }
}

- (void)doneButtonTouched:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.recordButton setEnabled:YES];
    [self.stopButton setEnabled:NO];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"Decode error occurred");
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encode error occurred");
}

@end

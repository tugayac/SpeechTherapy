//
//  UploadingViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/23/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <dropbox/dropbox.h>
#import <QuartzCore/QuartzCore.h>

#import "UploadingViewController.h"
#import "Test.h"

@interface UploadingViewController ()

@property (nonatomic, strong) NSArray *filesToUpload;

@end

@implementation UploadingViewController

- (id)initWithFileToUpload:(NSArray *)files
{
    self = [super initWithNibName:@"UploadingViewController" bundle:nil];
    if (self) {
        self.filesToUpload = files;
        self.view.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - self.view.bounds.size.height - 124, self.view.frame.size.width, self.view.frame.size.height);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view.layer setCornerRadius:5.0f];
    
    [self.uploadProgress setProgress:0.0f];
    
    [self.uploadLabel setText:[NSString stringWithFormat:@"File 1 of %d", [self.filesToUpload count]]];
    
    [self performSelectorInBackground:@selector(uploadFiles) withObject:nil];
}

- (void)uploadFiles
{
    for (int i = 0; i < [self.filesToUpload count]; i++) {
        Test *test = self.filesToUpload[i];
        DBPath *path =[[DBPath root] childPath:test.resultsPath];
        DBFile *file = [[DBFilesystem sharedFilesystem] createFile:path error:nil];
        
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = dirPaths[0];
        NSString *audioFile = [docsDir stringByAppendingPathComponent:test.resultsPath];
        NSData *audioBytes = [NSData dataWithContentsOfFile:audioFile];
        
        [file writeData:audioBytes error:nil];
        
        while (file.status.state == DBFileStateUploading) {
            [self performSelectorOnMainThread:@selector(updateProgress:) withObject:[NSNumber numberWithFloat:file.status.progress] waitUntilDone:NO];
            [self performSelectorOnMainThread:@selector(updateOnFile:) withObject:[NSNumber numberWithInt:i + 1] waitUntilDone:NO];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(uploadComplete:)]) {
        [self.delegate uploadComplete:self];
    }
}

- (void)updateProgress:(NSNumber *)progress
{
    [self.uploadProgress setProgress:progress.floatValue animated:YES];
}

- (void)updateOnFile:(NSNumber *)fileNum
{
    [self.uploadLabel setText:[NSString stringWithFormat:@"File %d of %d", fileNum.intValue, [self.filesToUpload count]]];
}

@end

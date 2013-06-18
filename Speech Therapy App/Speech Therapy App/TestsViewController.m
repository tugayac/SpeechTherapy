//
//  TestsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/17/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "TestsViewController.h"
#import "VoiceRecordViewController.h"
#import "Cell.h"
#import "ViewConstants.h"

@implementation TestsViewController

@synthesize testsCollection;

- (void)viewDidLoad
{
    self.tests = [[NSMutableArray alloc] init];
    
    [self.tests addObject:@"Voice Recording"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.tests count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCell" forIndexPath:indexPath];
    
    cell.userLabel.text = [self.tests objectAtIndex:[indexPath row]];
    cell.userImage.image = [UIImage imageNamed:@"Audio.png"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        VoiceRecordViewController *vrvc = [[VoiceRecordViewController alloc] init];
        vrvc.currentPatient = self.currentPatient;
        [vrvc setModalPresentationStyle:UIModalPresentationFullScreen];
        [vrvc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:vrvc animated:YES completion:nil];
    }
}

@end

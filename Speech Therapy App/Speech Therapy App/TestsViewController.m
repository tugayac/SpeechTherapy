//
//  TestsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/17/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "TestsViewController.h"
#import "TestWithPictureViewController.h"
#import "SecondTestViewController.h"
#import "TestCell.h"

@implementation TestsViewController

@synthesize testsCollection;

- (void)viewDidLoad
{
    self.tests = [[NSMutableArray alloc] init];
    
    // Add new test name here
    [self.tests addObject:@"Voice Test 1"];
    [self.tests addObject:@"Voice Test 2"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.tests count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCell" forIndexPath:indexPath];
    
    cell.testLabel.text = [self.tests objectAtIndex:[indexPath row]];
    cell.testImage.image = [UIImage imageNamed:@"Audio.png"];
    
    return cell;
}

- (void)initializeAndDisplayTestWithPictureViewController:(TestWithPictureViewController *)vc
{
    vc.currentPatient = self.currentPatient;
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [vc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        TestWithPictureViewController *tpvc = [[TestWithPictureViewController alloc] init];
        [self initializeAndDisplayTestWithPictureViewController:tpvc];
    } else if ([indexPath row] == 1) {
        SecondTestViewController *stvc = [[SecondTestViewController alloc] init];
        [self initializeAndDisplayTestWithPictureViewController:stvc];
    }
    // Add the next else if statement here
}

@end

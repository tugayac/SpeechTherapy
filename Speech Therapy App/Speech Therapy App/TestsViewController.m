//
//  TestsViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/17/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "TestsViewController.h"
#import "TestWithPictureViewController.h"
#import "TestCell.h"
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
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestCell" forIndexPath:indexPath];
    
    cell.testLabel.text = [self.tests objectAtIndex:[indexPath row]];
    cell.testImage.image = [UIImage imageNamed:@"Audio.png"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        TestWithPictureViewController *tpvc = [[TestWithPictureViewController alloc] init];
        tpvc.currentPatient = self.currentPatient;
        [tpvc setModalPresentationStyle:UIModalPresentationFullScreen];
        [tpvc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:tpvc animated:YES completion:nil];
    }
}

@end

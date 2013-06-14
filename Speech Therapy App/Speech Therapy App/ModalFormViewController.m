//
//  ModalFormViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/13/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ModalFormViewController.h"

@implementation ModalFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setTextFieldBorder:(UITextField *)textField toColor:(UIColor *)color
{
    [textField.layer setCornerRadius:8.0f];
    [textField.layer setMasksToBounds:YES];
    [textField.layer setBorderColor:[color CGColor]];
    [textField.layer setBorderWidth:1.0f];
}

- (IBAction)submitButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(modalFormViewControllerSubmitButtonTouched:)]) {
        [self.delegate modalFormViewControllerSubmitButtonTouched:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

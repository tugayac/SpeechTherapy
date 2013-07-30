//
//  ModalFormViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/13/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ModalFormViewController.h"

float const TextFieldCornerRadius = 8.0f;
float const TextFieldBorderWidth = 1.0f;

@implementation ModalFormViewController

- (BOOL)text:(NSString *)text lengthLessThan:(NSUInteger)number {
    if ([text length] < number) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setTextFieldBorder:(UITextField *)textField toColor:(UIColor *)color
{
    [textField.layer setCornerRadius:TextFieldCornerRadius];
    [textField.layer setMasksToBounds:YES];
    [textField.layer setBorderColor:[color CGColor]];
    [textField.layer setBorderWidth:TextFieldBorderWidth];
}

- (IBAction)checkTextFieldContentLength:(id)sender
{
    UITextField *textField = (UITextField *) sender;
    if (textField.text.length < 1) {
        [self setTextFieldBorder:textField toColor:[UIColor redColor]];
    } else {
        [self setTextFieldBorder:textField toColor:[UIColor greenColor]];
    }
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

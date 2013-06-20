//
//  ModalFormViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/13/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalFormViewControllerDelegate;

@interface ModalFormViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) id<ModalFormViewControllerDelegate> delegate;

- (IBAction)checkTextFieldContentLength:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;

- (BOOL)text:(NSString *)text lengthLessThan:(NSUInteger)number;
- (void)setTextFieldBorder:(UITextField *)textField toColor:(UIColor *)color;

@end

@protocol ModalFormViewControllerDelegate <NSObject>

@optional
- (void)modalFormViewControllerSubmitButtonTouched:(ModalFormViewController *)mfvc;

@end
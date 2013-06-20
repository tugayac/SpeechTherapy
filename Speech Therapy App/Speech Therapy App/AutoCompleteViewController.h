//
//  AutoCompleteViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/19/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AutoCompleteViewControllerDelegate;

@interface AutoCompleteViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<AutoCompleteViewControllerDelegate> delegate;

@property (nonatomic, strong) UITableView *suggestionsTable;

@property (nonatomic, strong) NSArray *allSuggestions;
@property (nonatomic, strong) NSMutableArray *currentSuggestions;

- (void)updateSuggestionsBasedOnInput:(NSString *)textInput;

@end

@protocol AutoCompleteViewControllerDelegate <NSObject>

@optional
- (void)autoCompleteSuggestionSelected:(NSString *)suggestion;

@end

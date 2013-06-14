//
//  AutoCompleteViewController.h
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/14/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoCompleteViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableOfSuggestions;

@property (nonatomic) CGRect initialFrame;
@property (nonatomic, strong) NSMutableArray *suggestions;

- (id)initWithFrame:(CGRect)rect;

@end

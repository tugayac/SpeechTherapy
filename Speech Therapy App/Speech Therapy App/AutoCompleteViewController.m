//
//  AutoCompleteViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/14/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "AutoCompleteViewController.h"

@implementation AutoCompleteViewController

@synthesize initialFrame, suggestions;

- (id)initWithFrame:(CGRect)rect
{
    self.suggestions = [[NSMutableArray alloc] init];
    
    self.tableOfSuggestions = [[UITableView alloc] init];
    [self.tableOfSuggestions setDataSource:self];
    [self.tableOfSuggestions setDelegate:self];
    
    self.initialFrame = rect;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setView:self.tableOfSuggestions];
    [self.suggestions addObject:@"Suggestion 1"];
    [self.suggestions addObject:@"Suggestion 2"];
    [self.suggestions addObject:@"Suggestion 3"];
    
    CGRect frame = CGRectMake(self.initialFrame.origin.x, self.initialFrame.origin.y + self.initialFrame.size.height, self.initialFrame.size.width, [self.tableOfSuggestions rowHeight] * 3);
    [self.view setFrame:frame];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.suggestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestionCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SuggestionCell"];
    }
    
    cell.textLabel.text = [self.suggestions objectAtIndex:[indexPath row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28.0f;
}

@end

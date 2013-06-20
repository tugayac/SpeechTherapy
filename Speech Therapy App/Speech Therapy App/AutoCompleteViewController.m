//
//  AutoCompleteViewController.m
//  Speech Therapy App
//
//  Created by Arda Tugay on 6/19/13.
//  Copyright (c) 2013 Arda Tugay. All rights reserved.
//

#import "AutoCompleteViewController.h"

@implementation AutoCompleteViewController

@synthesize currentSuggestions, allSuggestions;

- (id)init
{
    self = [super init];
    if (self) {
        self.suggestionsTable = [[UITableView alloc] init];
        [self.suggestionsTable setDataSource:self];
        [self.suggestionsTable setDelegate:self];
        
        self.currentSuggestions = [[NSMutableArray alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TypesOfAutism" ofType:@"plist"];
        self.allSuggestions = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setView:self.suggestionsTable];
}

- (void)updateSuggestionsBasedOnInput:(NSString *)textInput
{
    textInput = [textInput lowercaseString];
    for (NSString *entry in self.allSuggestions) {
        NSString *lowercaseEntry = [entry lowercaseString];
        for (int i = 0; i < [textInput length]; i++) {
            if (i + 1 > [entry length]) {
                if (![self.currentSuggestions containsObject:entry]) {
                    [self.currentSuggestions addObject:entry];
                }
                break;
            }
            
            if ([textInput characterAtIndex:i] == [lowercaseEntry characterAtIndex:i]) {
                if (i + 1 == [textInput length] && ![self.currentSuggestions containsObject:entry]) {
                    [self.currentSuggestions addObject:entry];
                } else {
                    continue;
                }
            } else {
                [self.currentSuggestions removeObject:entry];
                break;
            }
        }
    }
    
    [self.suggestionsTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentSuggestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestionCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SuggestionCell"];
    }
    
    cell.textLabel.text = [self.currentSuggestions objectAtIndex:[indexPath row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(autoCompleteSuggestionSelected:)]) {
        [self.delegate autoCompleteSuggestionSelected:[self.currentSuggestions objectAtIndex:[indexPath row]]];
    }
}

@end

//
//  XTJHistoryViewController.m
//  XTJournal
//
//  Created by Rogers, Brian A on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XTJHistoryViewController.h"

@interface XTJHistoryViewController ()

@end

@implementation XTJHistoryViewController

@synthesize dataStore;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataStore count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *plainCell = @"plainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:plainCell];
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:plainCell];
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [[dataStore allKeys] objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{	
    UIViewController *destination = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"HistoryDetail"])
    {
        //TODO: Fix this when Xcode 4.4 comes out.
        [destination setValue:[NSNumber numberWithBool:NO] forKey:@"startsInEditMode"];
        [destination setValue:[NSNumber numberWithBool:YES] forKey:@"isReadOnly"];

        
        NSString *dateAsString;
        dateAsString = ((UITableViewCell *)sender).textLabel.text;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM yyyy"];
        NSDate *dateOfEntry = [formatter dateFromString:dateAsString];
        [destination setValue:dateOfEntry forKey:@"date"];
        [destination setValue:dataStore forKey:@"dataStore"];
        
    }    
}

@end

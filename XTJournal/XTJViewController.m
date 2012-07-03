//
//  XTJViewController.m
//  XTJournal
//
//  Created by Rogers, Brian A on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XTJViewController.h"
#import "XTJEditorViewController.h"

#define kFilename       @"data.plist"

@implementation XTJViewController

@synthesize dataStore;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = [self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        dataStore = [[NSDictionary alloc] initWithContentsOfFile:filePath].mutableCopy;
    }
    else {
        dataStore = [[NSMutableDictionary alloc] init];
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

	
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{	
    UIViewController *destination = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"Today"])
    {
        NSDate *dateNow = [NSDate date];
        //dateNow = [dateNow dateByAddingTimeInterval:86400];
        // This is a transition to the Edit Today mode.
        // Leave the Date value as an NSDate for now. Eventually we'll want it for the Core Data implementation
        [destination setValue:dateNow forKey:@"date"];
        //TODO: Fix this when Xcode 4.4 comes out.
        [destination setValue:[NSNumber numberWithBool:YES] forKey:@"initialEditMode"];
        
        NSString *dateAsString;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMM yyyy"];
        dateAsString = [formatter stringFromDate:dateNow];
        if([dataStore objectForKey:dateAsString] == nil)
            [dataStore setValue:@"" forKey:dateAsString];
        [destination setValue:dataStore forKey:@"dataStore"];

    }    
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES     );
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    if(dataStore != nil)
    {
        [dataStore writeToFile:[self dataFilePath] atomically:YES];
    }
}

@end

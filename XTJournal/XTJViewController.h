//
//  XTJViewController.h
//  XTJournal
//
//  Created by Rogers, Brian A on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTJViewController : UIViewController

@property (strong, nonatomic) NSMutableDictionary* dataStore;

- (NSString *)dataFilePath;
- (void)applicationWillResignActive:(NSNotification *)notification;

@end

//
//  XTJHistoryViewController.h
//  XTJournal
//
//  Created by Rogers, Brian A on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTJHistoryViewController : UITableViewController <UITableViewDataSource>

@property (strong, nonatomic) NSMutableDictionary* dataStore;

@end

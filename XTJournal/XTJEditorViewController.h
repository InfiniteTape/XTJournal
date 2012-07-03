//
//  XTJEditorViewController.h
//  XTJournal
//
//  Created by Rogers, Brian A on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTJEditorViewController : UIViewController

@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSString* text;
@property (nonatomic) bool initialEditMode;

@property (strong, nonatomic) IBOutlet UINavigationItem* titleBarText;
@property (strong, nonatomic) IBOutlet UITextView* textView;

@end

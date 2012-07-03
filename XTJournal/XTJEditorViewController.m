//
//  XTJEditorViewController.m
//  XTJournal
//
//  Created by Rogers, Brian A on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XTJEditorViewController.h"

@interface XTJEditorViewController ()

@end

@implementation XTJEditorViewController

NSString *today;

@synthesize titleBarText;
@synthesize textView;
@synthesize date = _date;

-(void) setDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    today = [formatter stringFromDate:date];
    titleBarText.title = today;
    _date = date;
}

@synthesize initialEditMode = _initialEditMode;

-(void) setInitialEditMode:(bool)initialEditMode
{
    _initialEditMode = initialEditMode;
    if(_initialEditMode && (textView != nil))
        [textView becomeFirstResponder];
}

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
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    NSString *text = [dataStore objectForKey:today];
    [textView setText:text];
    
    if(_initialEditMode)
    {
        [textView becomeFirstResponder];
        NSRange range = NSMakeRange(textView.text.length - 1, 1);
        [textView scrollRangeToVisible:range];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [textView endEditing:YES];
    [dataStore setValue:textView.text forKey:today];
    	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    textView = nil;
    titleBarText = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil];
    CGRect endRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect newRect = textView.bounds;
    //Down size your text view
    newRect.size.height -= endRect.size.height;
    textView.frame = newRect;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil];
    CGRect newRect = textView.superview.bounds;
    //Down size your text view
    textView.frame = newRect;
    [UIView commitAnimations];
}

@end

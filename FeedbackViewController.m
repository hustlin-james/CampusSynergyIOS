//
//  FeedbackViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/6/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "FeedbackViewController.h"


@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
    
    //This is so when the user touches outside the keyboard, it
    //will disapppear
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //Set the border for the feedback input view
    [[self.feedbackInputView layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.feedbackInputView layer] setBorderWidth:1];
    [[self.feedbackInputView layer] setCornerRadius:0];
}

-(void)dismissKeyboard {
    [[self feedbackInputView] resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

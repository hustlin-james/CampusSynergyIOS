//
//  LogInViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (id)init {
    self = [super init];
    if (self) {
        // Initialize self.
        
        self.view.backgroundColor = [UIColor whiteColor];
        //self.navigationController.navigationItem.title = @"Add Event";
        self.title = @"Login";
        
    }
    return self;
}

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
    
    //self.title = @"Login";
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginSubmitButton:(id)sender {
    
    NSLog(@"Submit button has been pushed.  Validating input.");
    
    //Check the user username and password input
    //and that they are valid
    
    
    //Then go to the parse API and retrieve the
    //information and make sure the user exists
    
    
    //If the everything is good then write the information to
    //a plist file and set the
    
    //userLoggedIn
    
}
@end

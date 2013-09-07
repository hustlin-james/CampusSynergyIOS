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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //username
    if(textField.tag == self.usernameField.tag){
        [self.usernameField resignFirstResponder];
        return YES;
    }
    //password
    else if(textField.tag == self.passwordField.tag){
        [self.passwordField resignFirstResponder];
        return YES;
    }
    else{
        return YES;
    }
    
}

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
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    self.passwordField.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginSubmitButton:(id)sender {
    
    //NSLog(@"Submit button has been pushed.  Validating input.");
    
    //Check the user username and password input
    //and that they are valid

    //Then go to the parse API and retrieve the
    //information and make sure the user exists
    //If the everything is good then write the information to
    //a plist file and set the
    
    //userLoggedIn
    
    if ([[self.usernameField text] isEqualToString: @""] || [[self.passwordField text] isEqualToString: @""]){
       
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please Correctly Input the Username and Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [error show];
    }
    else{
        //Connect to API and check
        //Send a parse login request
        NSString *usernameStringTrimmed =[self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        NSString *passwordStringTrimmed =
        [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSString *name_string = [self loginUsingParseAPI:usernameStringTrimmed andPassword:passwordStringTrimmed];
        
        if(name_string == nil){
            NSLog(@"Invalid Login");
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Invalid Login" message:@"Couldn't find Username and Password" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
            [error show];
        }
        else{
            NSLog(@"Name: %@", name_string);
             //Write the login information into a plist file
             //for persistence
            
            //name_string is the publisher name
            //usernameStringTrimmed = name_string;
            
            [self writeLoginInfoToPlistFile:name_string];
            
            AddEventViewController *addEventVc =
            [self.storyboard instantiateViewControllerWithIdentifier:@"AddEventVC"];
            
            addEventVc.publisher = name_string;
            //addEventVc.app_id = [self app_id];
            //addEventVc.rest_id = [self rest_id];
            
            [self.navigationController pushViewController:addEventVc animated:YES];
            
        }
    }
    
}


- (NSString *)loginUsingParseAPI: (NSString *)username andPassword: (NSString *)myPassword{
    
    PFUser *myUser = [PFUser logInWithUsername:username password:myPassword];
    if(myUser == nil){
        //log in failed
        return nil;
    }
    else{
        //log in successful
        NSString *publisher = [myUser objectForKey:@"name"];
        NSLog(@"publisher: %@", publisher);
        return publisher;
    }
}

- (void)writeLoginInfoToPlistFile:(NSString *)publisher_name_string{
    
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    NSString *documentsDirectory = [sysPaths objectAtIndex:0];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:@"parse_user.plist"];
    
    NSLog(@"Login Wrote File Path: %@", filePath);
    
    NSMutableDictionary *plistDict = plistDict = [[NSMutableDictionary alloc] init]; // needs to be mutable
    
    NSDateFormatter *currentTime = [[NSDateFormatter alloc] init];
    [currentTime setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString =
    [currentTime stringFromDate:[NSDate date]];
    
    NSLog(@"timestamp logged as: %@", dateString);
    
    [plistDict setValue:publisher_name_string forKey:@"username"];
    [plistDict setValue:dateString forKey:@"logged_in_timestamp"];
    
    BOOL didWriteToFile = [plistDict writeToFile:filePath atomically:YES];

    if (didWriteToFile) {
        NSLog(@"Loging Wrote to file.");
        NSLog(@"plist: %@", [plistDict description]);
    } else {
        NSLog(@"Error login failed to write to file");
    }
    
}
@end

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
    
    NSLog(@"LoginVC APP ID: %@", self.app_id);
    NSLog(@"LoginVC Rest ID: %@", self.rest_id);

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
        
        NSString *parse_url = @"https://api.parse.com/1/login";
        
        NSString *usernameStringTrimmed =[self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        NSString *passwordStringTrimmed =
        [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        parse_url = [parse_url stringByAppendingFormat:@"?username=%@",usernameStringTrimmed];
        parse_url = [parse_url stringByAppendingFormat:@"&password=%@",passwordStringTrimmed];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:parse_url]];
        
        [request setHTTPMethod:@"GET"];
        [request setValue:[self app_id] forHTTPHeaderField:@"X-Parse-Application-Id"];
        [request setValue:[self rest_id] forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseCode = nil;
        
        NSData *loginResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
        
        NSString *dataAsString = [[NSString alloc] initWithData: loginResponseData encoding:NSUTF8StringEncoding];
        NSLog(@"Login Data Retrieved UTF8: %@", dataAsString);
        
        //Parse the data that was retrieved
        NSError *json_error;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:loginResponseData options:NSJSONReadingAllowFragments error:&json_error];
        
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        NSString *name_string = (NSString *)[deserializedDictionary objectForKey:@"name"];
        
        if(name_string == nil){
            NSLog(@"Invalid Login");
            
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Invalid Login" message:@"Couldn't find Username and Password" delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil, nil];
            
            [error show];
        }
        else{
            NSLog(@"Name: %@", name_string);
             //Write the login information into a plist file
             //for persistence
            
            [self writeLoginInfoToPlistFile];
            
            AddEventViewController *addEventVc =
            [self.storyboard instantiateViewControllerWithIdentifier:@"AddEventVC"];
            
            addEventVc.publisher = name_string;
            addEventVc.app_id = [self app_id];
            addEventVc.rest_id = [self rest_id];
            
            [self.navigationController pushViewController:addEventVc animated:YES];
            
        }
    }
    
}

- (void)writeLoginInfoToPlistFile{
    
    NSString *usernameStringTrimmed =[self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *passwordStringTrimmed =
    [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    NSString *documentsDirectory = [sysPaths objectAtIndex:0];
    NSString *filePath =  [documentsDirectory stringByAppendingPathComponent:@"parse_user.plist"];
    
    NSLog(@"Login Wrote File Path: %@", filePath);
    
    NSMutableDictionary *plistDict = plistDict = [[NSMutableDictionary alloc] init]; // needs to be mutable
    
    /*
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    } else {
        // Doesn't exist, start with an empty dictionary
        plistDict = [[NSMutableDictionary alloc] init];
    }
     */
    
    [plistDict setValue:usernameStringTrimmed forKey:@"username"];
    [plistDict setValue:passwordStringTrimmed forKey:@"password"];
    
    BOOL didWriteToFile = [plistDict writeToFile:filePath atomically:YES];

    if (didWriteToFile) {
        NSLog(@"Loging Wrote to file.");
        NSLog(@"plist: %@", [plistDict description]);
    } else {
        NSLog(@"Error login failed to write to file");
    }
    
}
@end

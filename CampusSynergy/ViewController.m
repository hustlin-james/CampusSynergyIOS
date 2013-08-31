//
//  ViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //AddEventViewController *addEvent = [[AddEventViewController alloc] init];
    //[self.navigationController pushViewController:addEvent animated:YES];
    
    MKCoordinateRegion region = {{0.0, 0.0} , {0.0, 0.0}};
    
    region.center.latitude = 32.733332;
    region.center.longitude = -97.116288;
    region.span.latitudeDelta = .05f;
    region.span.longitudeDelta = .05f;
    
    [self.mapView setRegion:region animated:YES];
    [self.mapView setDelegate:self];
    
    //Construct the Polygons/Events objects
    
    
    //Called UtilFunctsion
    
    [UtilFunctions getEventsFromParseASJSON];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//The is the Add Event Button in the Main View Navigation Bar
- (IBAction)addEventPressed:(id)sender {
    
    //Check for a plist file for the user
    
    NSLog(@"AddEvent Button was pressed, checking to see if user loggedin");
    
    BOOL userLoggedIn = YES;
    
    if (userLoggedIn){
        NSLog(@"User is logged in, creating the addeventVC");
        //AddEventViewController *addEventVC = [[AddEventViewController alloc] init];
        AddEventViewController *addEventVC =
        [self.storyboard instantiateViewControllerWithIdentifier:@"AddEventVC"];
        
        addEventVC.JSONVALUE = @"{event_name: \"Test Event\"}";
        
        [self.navigationController pushViewController:addEventVC animated:YES];
    }
    else{
        NSLog(@"User is not logged in, creating the loginVC");
        //LogInViewController *loginVC = [[LogInViewController alloc] init];
        LogInViewController *loginVC = 
        [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}
@end

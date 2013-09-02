//
//  AllEventsForBuildingViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsForBuildingViewController.h"

@interface AllEventsForBuildingViewController ()

@end

@implementation AllEventsForBuildingViewController

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
    
    NSString *buildNameText = [[NSString alloc]
                               initWithFormat:@"All Events for building: %@", [self buildingNameString]];
    
    self.buildingName.text = buildNameText;
    
    [self retrieveAllEventsForBuildingFromParse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Call the parse API
-(void) retrieveAllEventsForBuildingFromParse{
    
    NSLog(@"myAppId: %@", [self myAppId]);
    NSLog(@"myRestId: %@", [self myRestId]);
    
    EventsData *buildingEvents = [[EventsData alloc] initWithAppId:[self myAppId] andRestID:[self myRestId]];
    
    NSData *responseData =
    [buildingEvents getEventsForBuilding:[self buildingNameString]];
    
    NSLog(@"ResponseData: %@", responseData);
    
    NSString *dataAsString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@ Building Events: %@",
          [self buildingNameString], dataAsString);
}

@end

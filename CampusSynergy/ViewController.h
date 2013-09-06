//
//  ViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AddEventViewController.h"
#import "LogInViewController.h"
#import "XMLElement.h"
#import "EventsData.h"
#import "AllEventsViewController.h"
#import "AllEventsForBuildingViewController.h"
#import "AllEventsSegue.h"
#import <objc/runtime.h>

@interface ViewController : UIViewController <MKMapViewDelegate, NSXMLParserDelegate>

//Events Methods
- (IBAction)allEventsPressed:(id)sender;
- (IBAction)addEventPressed:(id)sender;
- (IBAction)refreshButton:(id)sender;

//Object Variables
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic, strong) NSXMLParser *xmlParser;

@property(nonatomic, strong) XMLElement *rootElement;
@property(nonatomic, strong) XMLElement *currentElementPointer;


//allJSONEvents is the old version for parse
//propaly gona remove these later
@property(nonatomic, strong) NSData *allJSONEvents;
@property(nonatomic, strong) NSArray *eventObjects;
//end

//this is using the objective c parse API
//@property(nonatomic, strong) NSArray *parseEventObjects;

@end

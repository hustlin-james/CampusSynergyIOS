//
//  ViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UtilFunctions.h"
#import "AddEventViewController.h"
#import "LogInViewController.h"
#import "XMLElement.h"

@interface ViewController : UIViewController <MKMapViewDelegate, NSXMLParserDelegate>

- (IBAction)addEventPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic, strong) NSXMLParser *xmlParser;

@property(nonatomic, strong) XMLElement *rootElement;
@property(nonatomic, strong) XMLElement *currentElementPointer;


@end

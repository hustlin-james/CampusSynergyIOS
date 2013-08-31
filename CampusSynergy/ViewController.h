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

@interface ViewController : UIViewController <MKMapViewDelegate>

- (IBAction)addEventPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

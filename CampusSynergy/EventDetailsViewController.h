//
//  EventDetailsViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface EventDetailsViewController : UIViewController

@property(copy, nonatomic) NSString* eventTitleText;
@property(copy, nonatomic) NSString* eventDescriptionText;
@property(copy, nonatomic) NSString* eventBuildingText;
//@property(copy, nonatomic) NSString* eventRoomText;
@property(copy, nonatomic) NSString* publisherText;
@property(copy, nonatomic) NSString* startTimeDescriptionText;

@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionTextView;

@property (weak, nonatomic) IBOutlet UITextView *startTimeDescriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *buildingLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;

- (IBAction)mainMapButton:(id)sender;

@end

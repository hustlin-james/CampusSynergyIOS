//
//  EventDetailsViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailsViewController : UIViewController

@property(copy, nonatomic) NSString *eventTitle;
@property(copy, nonatomic) NSString *eventDescription;
@property(copy, nonatomic) NSString *buildingString;
@property(copy, nonatomic) NSString *roomString;
@property(copy, nonatomic) NSString *startingTime;
@property(copy, nonatomic) NSString *dateField;
@property(copy, nonatomic) NSString *durationField;

@end

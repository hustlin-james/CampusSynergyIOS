//
//  AllEventsViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDetailsViewController.h"

@interface AllEventsViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//Store the information of all events in here
@property(strong, nonatomic) NSArray *eventsArray;

//@property(strong, nonatomic) NSData *allEventsAsJSON;

@property(strong, nonatomic) NSString *username;

//parse events API array
@property(copy, nonatomic) NSArray *parseEventObjects;

@end

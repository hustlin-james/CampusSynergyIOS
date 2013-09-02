//
//  AllEventsForBuildingViewController.h
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsData.h"

@interface AllEventsForBuildingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *buildingName;
@property (copy, nonatomic) NSString *buildingNameString;


@property (copy, nonatomic) NSString *myAppId;
@property (copy, nonatomic) NSString *myRestId;

@end

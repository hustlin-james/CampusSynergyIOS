//
//  AllEventsSegue.h
//  CampusSynergy
//
//  Created by feifan meng on 9/4/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "AllEventsViewController.h"

@interface AllEventsSegue : UIStoryboardSegue

//Use this to transfer data from the source view to the destination view
//i.e. from ViewController to the AllEventsViewController
@property(nonatomic, strong) NSData *allJSONEvents;
@property(nonatomic, strong) NSString *username;

@property(nonatomic, copy) NSArray *parseEventObjects;

@end

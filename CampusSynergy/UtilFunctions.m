//
//  UtilFunctions.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "UtilFunctions.h"

@implementation UtilFunctions

//Use the Parse API
+ (NSArray *)getEventsFromParseASJSON{
    NSString *result = @"";
    
    //Add Code here to Connect to the Parse API and form a JSON String
    //stored in result
    
    //Testing
    /*
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar2" forKey:@"foo"];
    [testObject save];
     */
    
    //JSON String Format
    //{"bldName": "...", "date":"...", "duration":"..."
    // , "location":"...",longDescription":"...", "publisher"
    
    PFQuery *query = [PFQuery queryWithClassName:@"campus_synergy"];
    [query whereKey:@"bldName" equalTo:@"MAC"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", [object objectForKey:@"bldName"]);
                //NSDate *myDate = [object objectForKey:@"date"];
                
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                [df setDateFormat:@"yyy-MM-dd"];
                NSString *myDate = [df stringFromDate:[object objectForKey:@"date"]];
                
                NSLog(@"%@",[myDate description]);
                NSLog(@"%@", [object objectForKey:@"duration]"]);
               
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return result;
}

@end

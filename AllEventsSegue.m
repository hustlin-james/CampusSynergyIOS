//
//  AllEventsSegue.m
//  CampusSynergy
//
//  Created by feifan meng on 9/4/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsSegue.h"
#import "QuartzCore/QuartzCore.h"

@implementation AllEventsSegue


-(void)perform {
    ViewController *sourceViewController = (ViewController*)[self sourceViewController];
    
    AllEventsViewController *destinationController = (AllEventsViewController*)[self destinationViewController];
    
    CATransition *transition = [CATransition animation];
    /*
    transition.duration = 0;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     */
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
 
    [sourceViewController.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
    
    //destinationController.allEventsAsJSON = [sourceViewController allJSONEvents];
   //destinationController.allEventsAsJSON = [self allJSONEvents];
    destinationController.username = [self username];
    
    
    NSLog(@"IN PARSEEVENTOBJECTS: %@", [self parseEventObjects]);
    //new Parse API
    destinationController.parseEventObjects = [self parseEventObjects];
    
    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
}
@end

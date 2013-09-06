//
//  EventsData.h
//  CampusSynergy
//
//  Created by feifan meng on 9/1/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface EventsData : NSObject

- (id) initWithAppId: (NSString *)myAppId andRestID: (NSString *)restID;
- (void)printMyIDs;
- (NSData *) getEventsAndReturnJSON;
- (NSData *) getEventsForBuilding: (NSString *)myBuilding;
- (NSData *)uploadDataToParseWithREST: (NSString *)jsonString;
+ (BOOL)saveEventsToParse: (NSString *)bldName andDate: (NSDate *)date andDuration: (NSNumber *)duration andLongDescription:(NSString *)longDescription andPublisher: (NSString *) publisher  andRoom: (NSNumber *)room andTitle: (NSString *)title;
@end

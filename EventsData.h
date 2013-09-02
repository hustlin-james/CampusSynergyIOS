//
//  EventsData.h
//  CampusSynergy
//
//  Created by feifan meng on 9/1/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventsData : NSObject

- (id) initWithAppId: (NSString *)myAppId andRestID: (NSString *)restID;
- (void)printMyIDs;
- (NSData *) getEventsAndReturnJSON;

@end

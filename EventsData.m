//
//  EventsData.m
//  CampusSynergy
//
//  Created by feifan meng on 9/1/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "EventsData.h"

@implementation EventsData{
    NSString *app_id;
    NSString *rest_id;
}

- (id)init{
    if ( self = [super init] ) {
        app_id = @"";
        rest_id = @"";
        return self;
    } else
        return nil;
}

- (id) initWithAppId: (NSString *)myAppId andRestID: (NSString *)restID{
    
    //Check that the super was successfuly initialed
    if ( self = [super init] ) {
        app_id = myAppId;
        rest_id = restID;
        return self;
    } else
        return nil;
}

- (NSData *) getEventsAndReturnJSON{
    if ([app_id isEqualToString:@""]|| [rest_id isEqualToString:@""]){
        return nil;
    }
    else{
        return [self useParseRESTAPI];
    }
    
}

- (NSData *) useParseRESTAPI{
    NSString *parse_url = @"https://api.parse.com:443/1/classes/campus_synergy";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:parse_url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:app_id forHTTPHeaderField:@"X-Parse-Application-Id"];
    [request setValue:rest_id forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    //return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    return oResponseData;
}

- (void)printMyIDs{
    NSLog(@"appID: %@, restID: %@", app_id, rest_id);
}

@end
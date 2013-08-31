//
//  UtilFunctions.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "UtilFunctions.h"

@implementation UtilFunctions

//Copied the code from: http://alexefish.com/post/29843064002/fetching-every-row-of-a-table-with-parse-and-pfquery
//Recursively retrieves all the objects from parse
+ (void)findAllObjectsWithQuery:(PFQuery *)query withBlock:(void (^)(NSArray *objects, NSError *error))block
{
    __block NSMutableArray *allObjects = [NSMutableArray array];
    __block NSUInteger limit = 1000;
    __block NSUInteger skip = 0;
    
    typedef void  (^FetchNextPage)(void);
    FetchNextPage __weak __block weakPointer;
    
    FetchNextPage strongBlock = ^(void)
    {
        [query setLimit: limit];
        [query setSkip: skip];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error)
            {
                // The find succeeded. Add the returned objects to allObjects
                [allObjects addObjectsFromArray:objects];
                
                if (objects.count == limit) {
                    // There might be more objects in the table. Update the skip value and execute the query again.
                    skip += limit;
                    [query setSkip: skip];
                    // Go get more results
                    weakPointer();
                }
                else
                {
                    // We are done so return the objects
                    block(allObjects, nil);
                }
                
            }
            else
            {
                block(nil,error);
            }
        }];
    };
    weakPointer = strongBlock;
    strongBlock();
}

//Use the Parse API
+ (NSString *)getEventsFromParseASJSON{
    
    //Add Code here to Connect to the Parse API and form a JSON String
    //stored in result
    
    //JSON String Format
    //{"bldName": "...", "date":"...", "duration":"..."
    // , "location":"...",longDescription":"...", "publisher":"..."
    //,"room":"...", "timeStart":"...", "title":"..."
    
    NSMutableString *json_result = [NSMutableString stringWithString:@"{\"result\": ["];
    
    PFQuery *query = [PFQuery queryWithClassName:@"campus_synergy"];
    //NSArray *parse_result = [NSArray alloc];
    
    [self findAllObjectsWithQuery:query withBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            //NSLog(@"Loaded All Objects from parsed: %@",objects);
            
            NSLog(@"Retrieved %d Events from parsed.", [objects count]);
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            
            for(int i = 0; i < [objects count]; i++){
                PFObject *myObject = [objects objectAtIndex:i];
                
                //NSMutableString *single_result = [NSString stringWithFormat:@"%@", @"{"];
                NSMutableString *single_result = [[NSMutableString alloc] initWithString: @"{"];

                [single_result appendString:@"Hello"];
                
                NSLog(@"%@", single_result);
                
                
                NSString *bld_name = [self createJSONString:@"bldName" withValue: (NSString *)[myObject objectForKey:@"bldName"] withComma:NO];
                
               
                
                
                /*
                 [single_result stringByAppendingString: [self createJSONString:@"date" withValue:(NSString *)[dateFormatter dateFromString:[myObject objectForKey:@"date"]] withComma:NO]];
                 */
                /*
                [single_result stringByAppendingString: [self createJSONString:@"location" withValue:[myObject objectForKey:@"location"] withComma:NO]];
                 */
                
                 [single_result stringByAppendingString: [self createJSONString:@"longDescription" withValue:(NSString *)[myObject objectForKey:@"longDescription"] withComma:NO]];
                
               
                if(i == [objects count] - 1){
                    //Don't add comma
                    [single_result stringByAppendingString:@"}"];
                    
                }
                else{
                    [single_result stringByAppendingString:@"},"];
                }
              
               // NSLog(@"%@", single_result);
            }
        }
    }];
    
    //[json_result stringByAppendingString:@"]}"];
    
   // NSLog(@"JSON String from parsed: %@", json_result);
    
    //NSString *result = [NSString stringWithString:json_result];
    NSString *result = @"";
    
    return result;
}

+ (NSString *) createJSONString: (NSString *)keyName withValue: (NSString *)myValue withComma: (BOOL) yesOrNo{
   
    if (yesOrNo){
        //NSLog(@"%@",[NSString stringWithFormat:@"{\"%@\":\"%@\"},", keyName, myValue]);
        return [NSString stringWithFormat:@"{\"%@\":\"%@\"},", keyName, myValue];
    }
    else{
        //NSLog(@"%@", [NSString stringWithFormat:@"{\"%@\":\"%@\"},", keyName, myValue]);
        return [NSString stringWithFormat:@"{\"%@\":\"%@\"}", keyName, myValue];
    }
}


@end

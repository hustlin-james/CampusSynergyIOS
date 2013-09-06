//
//  AllEventsForBuildingViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 9/2/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsForBuildingViewController.h"

@interface AllEventsForBuildingViewController ()

@end

@implementation AllEventsForBuildingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    

    self.buildingEventsTable.dataSource = self;
    self.buildingEventsTable.delegate = self;
    
    NSString *buildNameText = [[NSString alloc]
                               initWithFormat:@"All Events for building: %@", [self buildingNameString]];
    
    self.buildingName.text = buildNameText;
    self.title = [self buildingNameString];
    
    //Create an NSArray with each event name
    NSError *error = nil;
    
    //NSJONReadingAllowFragments: Allows the deserialization of JSON data whose root top-level object is not an array or a dictionary
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self allEvents] options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
    //NSLog(@"JSON DICT: %@", [deserializedDictionary objectForKey:@"results"]);
    
    NSArray *myResults = [[NSArray alloc] initWithArray:[deserializedDictionary objectForKey:@"results"]];
    
    //NSLog(@"Array: %@", myResults);
    
    NSMutableArray *myEventsTitleArray = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *result in myResults){
        //NSLog(@"Event Title: %@", [result objectForKey:@"title"]);
        if([[result objectForKey:@"bldName"] isEqualToString:[self buildingNameString]] ){
            [myEventsTitleArray addObject: result];
            
            //each result is an nsdictionary from an array of myResults
            
            NSLog(@"myEventsTitleArray: %@", result);
        }
    }
    
    self.eventsArray = [[ NSArray alloc] initWithArray:myEventsTitleArray];
    
    if (self.eventsArray != nil && [self.eventsArray count] > 0){
        NSLog(@"Events Array Created");
    }
    
    //filter out all the non related buildings
    NSMutableArray *myParseEventsArray = [[NSMutableArray alloc]init];
    
    for(PFObject *event in [self parseEventArray]){
        if([[event objectForKey:@"bldName"] isEqualToString:
           [self buildingNameString]]){
            [myParseEventsArray addObject: event];
        }
    }
    self.parseEventArray = [[NSArray alloc] initWithArray:myParseEventsArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//This is pretty much how many tables cells should be generated
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   //NSLog(@"Generating %d Table cells", (int)[self.eventsArray count]);
    
    //return [self.eventsArray count];
    return [self.parseEventArray count];
}

//Setings for a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //This is the identifier for the table cells, it is in the attributes thing
    NSString *cellIdentifier = @"EventsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    /*
    NSString *eventString = [[self.eventsArray objectAtIndex:indexPath.row]
                             objectForKey:@"title"];
    
    NSString *subTitle = [[self.eventsArray objectAtIndex:indexPath.row]
                          objectForKey:@"bldName"];
    */
    //new parse stuff
    NSString *parseEventString = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *parseSubTitle =[[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    
    
    [cell.textLabel setText:parseEventString];
    [cell.detailTextLabel setText: parseSubTitle];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventDetailsViewController *eventDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    
    eventDetailsVC.navigationItem.hidesBackButton = NO;
    //Set the all event properties

    /*
    //Set the fields for the eventdetails object
    NSString *eventsTitle = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    eventDetailsVC.eventTitleText = eventsTitle;
    NSString *eventDescript = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"longDescription"];
    eventDetailsVC.eventDescriptionText = eventDescript;
    NSString *roomString = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"room"];
    eventDetailsVC.eventRoomText = roomString;
    NSString *buildingString = [[self.eventsArray objectAtIndex:indexPath.row]
                                objectForKey:@"bldName"];
    eventDetailsVC.eventBuildingText = buildingString;
    eventDetailsVC.publisherText = [self username];
    NSString *iso_date = [[[self.eventsArray objectAtIndex:indexPath.row]
                           objectForKey:@"date"] objectForKey:@"iso"];
    NSLog(@"ISO Date: %@", iso_date);
    
    //THIS IS CORRECCT
    NSDateFormatter *rawDateFormatter = [ [NSDateFormatter alloc] init];
    [rawDateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"];
    NSDate *myRawDate = [rawDateFormatter dateFromString:iso_date];
    NSLog(@"Raw Date: %@", myRawDate.description);
    
    //rawDateFormatter.timeZone = [NSTimeZone systemTimeZone];

    [rawDateFormatter setDateFormat:@"hh:mm a"];
    NSString *myTime = [rawDateFormatter stringFromDate:myRawDate];
    NSLog(@"myTime: %@", myTime);
    
    [rawDateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *myDate = [rawDateFormatter stringFromDate:myRawDate];
    NSLog(@"myDate: %@", myDate);
    
    NSString *duration = [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"duration"];
    
     */
    /*
     This event starts at 04:07 PM 09/06/2013 and it takes 11.0 hours
     to finish.
     */
    
    /*
    NSString *startTimeText = [[NSString alloc] initWithFormat:@"This event starts at %@ %@ and it takes %@ hours to finish", myTime, myDate, duration];
    eventDetailsVC.startTimeDescriptionText = startTimeText;
     */
    
    
    //objective c parse library
    NSString *myEventsTitle
    = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    eventDetailsVC.eventTitleText = myEventsTitle;
    
    NSString *myEventDescription = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"longDescription"];
    eventDetailsVC.eventDescriptionText = myEventDescription;
    
    NSString *myRoomString = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"room"];
    eventDetailsVC.eventRoomText = myRoomString;
    
    NSString *myBuildingString = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    eventDetailsVC.eventBuildingText = myBuildingString;
    
    eventDetailsVC.publisherText = [self username];
    
    NSString *myDuration = [[self.parseEventArray objectAtIndex:indexPath.row] objectForKey:@"duration"];
    
    NSDate *parseDate = [[self.parseEventArray objectAtIndex:indexPath.row]
                         objectForKey:@"date"];
    
    NSLog(@"parseDate: %@", parseDate);
    NSLog(@"parseDate description: %@", parseDate.description);
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *myParseTime = [timeFormatter stringFromDate:parseDate];
    
    [timeFormatter setDateFormat:@"hh:mm a"];
    NSString *myParseDate = [timeFormatter stringFromDate:parseDate];
    
    NSString *myStartTimeText = [[NSString alloc] initWithFormat:@"This event starts at %@ %@ and it takes %@ hours to finish", myParseTime, myParseDate, myDuration];
    eventDetailsVC.startTimeDescriptionText = myStartTimeText;
    
    [self.navigationController pushViewController:eventDetailsVC animated:YES];
}

@end

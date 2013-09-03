//
//  AllEventsViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AllEventsViewController.h"

@interface AllEventsViewController ()

@end

@implementation AllEventsViewController

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
	// Do any additional setup after loading the view.
    
    //Event change this to dynamically retrieve all the events
    //from the parsed server
    
    NSLog(@"Creating the dataSource and the delegate for the view cells.");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
   // NSLog(@"All Events JSON in AllEventsViewController: %@", [self allEventsAsJSON]);
    
    //Create an NSArray with each event name
    NSError *error = nil;
    
    //NSJONReadingAllowFragments: Allows the deserialization of JSON data whose root top-level object is not an array or a dictionary
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self allEventsAsJSON] options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
    //NSLog(@"JSON DICT: %@", [deserializedDictionary objectForKey:@"results"]);
    
    NSArray *myResults = [[NSArray alloc] initWithArray:[deserializedDictionary objectForKey:@"results"]];
    
    NSLog(@"Array: %@", myResults);
    
    NSMutableArray *myEventsTitleArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *result in myResults){
        //NSLog(@"Event Title: %@", [result objectForKey:@"title"]);
        //[myEventsTitleArray addObject: [result objectForKey:@"title"]];
        [myEventsTitleArray addObject: result];
    }
        
    self.eventsArray = [[NSArray alloc] initWithArray:myEventsTitleArray];
    
    if (self.eventsArray != nil && [self.eventsArray count] > 0){
        NSLog(@"Events Array Created");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//This is pretty much how many tables cells should be generated
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@"Generating %d Table cells", (int)[self.eventsArray count]);
    
    return [self.eventsArray count];
}

//Setings for a cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //This is the identifier for the table cells, it is in the attributes thing
    NSString *cellIdentifier = @"EventsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString *eventString =
    [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    NSString *subLabel =
    [[self.eventsArray objectAtIndex:indexPath.row] objectForKey:@"bldName"];
    
    [cell.textLabel setText:eventString];
    [cell.detailTextLabel setText: subLabel];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventDetailsViewController *eventDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EventDetailVC"];
    
        //Set properties of the EventDetailsViewController Object
    [self.navigationController pushViewController:eventDetailsVC animated:YES];
}

@end

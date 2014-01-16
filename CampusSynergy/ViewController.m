//
//  ViewController.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "ViewController.h"


@interface ViewController (){
    EventsData *myEventsData;
    NSString *myAppId;
    NSString *myRestId;
    NSString *username;

    NSArray *parseEventObjects;
    
    NSArray *allBuildings;
    
    NSDate *refreshPreviousTime;
    NSDate *refreshCurrentTime;
    
    NSMutableDictionary *buildingAndPoints;
    BOOL shownParseConnectError;
    
    NSDictionary *buildingWithEvent;
}
@end

@implementation ViewController

//static BOOL overlaysGenerated = NO;

-(void)viewDidAppear:(BOOL)animated{
    //[self initializeView:NO];
}

- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"Main Map View just appeared.");
    
    shownParseConnectError=NO;
    [self parseAPIEventsRetrieve];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeView:YES];
}
- (void)initializeView: (BOOL)willAnimate{
    //Check if the parse_user.plist file is in the Documents directory
    //And that the username,password contains values
    //userLoggedIn = YES;
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory ,NSUserDomainMask, YES);
    NSString *documentsDirectory = [sysPaths objectAtIndex:0];
    NSString *filePath =  [documentsDirectory
                           stringByAppendingPathComponent:@"parse_user.plist"];
    
    NSLog(@"File Path: %@", filePath);
    
    NSMutableDictionary *plistDict; // needs to be mutable
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
    
        if ([plistDict objectForKey:@"username"] == nil || [plistDict objectForKey:@"logged_in_timestamp"]){
            
            NSLog(@"Initiating username: ...");
            plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
            NSLog(@"plist exists. Value: %@", [plistDict description]);
            
            //Check that the logged_in_timestamp is less than the current timestamp
            NSString *timestampOnPlist = [plistDict objectForKey:@"logged_in_timestamp"];
            
            NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *timestampDate = [formatter dateFromString:timestampOnPlist];
            NSLog(@"timestampDate on plist: %@", timestampDate);
            
            NSString *temp = [formatter stringFromDate:timestampDate];
            NSLog(@"as string: %@", temp);
            
            int month = 60*60*24*30;
            NSDate *eventDatePlusDuration =
            [timestampDate dateByAddingTimeInterval:month];
            NSLog(@"timestampDate added 30 days: %@",eventDatePlusDuration);
            
            NSString *currentTimestampStr = [formatter stringFromDate: [NSDate date]];
            NSDate *currentTimestamp = [formatter dateFromString:currentTimestampStr];
            
            
            if ([eventDatePlusDuration timeIntervalSinceDate:currentTimestamp] < 0){
                NSLog(@"timestamp has expired, user needs to login.");
            }
            else{
                username = [plistDict objectForKey:@"username"];
                NSLog(@"Username is: %@", username);
            }
            
        }
        else{
            username = nil;
        }
        
    } else {
        NSLog(@"parse_user.plist does not exist");
        // Doesn't exist, start with an empty dictionary
        plistDict = [[NSMutableDictionary alloc] init];
    }
    //Add the username to the username property
    if(username != nil){
        NSLog(@"user logged in");
    }
    else{
        NSLog(@"user not logged in");
    }
    
	// Do any additional setup after loading the view, typically from a nib.
    [self startMapConstruction:willAnimate];
}

- (void)startMapConstruction: (BOOL)willAnimate{
    //AddEventViewController *addEvent = [[AddEventViewController alloc] init];
    //[self.navigationController pushViewController:addEvent animated:YES];
    
    MKCoordinateRegion region = {{0.0, 0.0} , {0.0, 0.0}};
    
    region.center.latitude = 32.733332;
    region.center.longitude = -97.116288;
    region.span.latitudeDelta = .01f;
    region.span.longitudeDelta = .01f;
    
    [self.mapView setRegion:region animated:willAnimate];
    [self.mapView setDelegate:self];
    
    //Start the Process to get Events Data
    
    //Remove this later?
    [self.activityIndicator startAnimating];
    myEventsData = [[EventsData alloc] initWithAppId:myAppId andRestID:myRestId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self performSelectorOnMainThread:@selector(startGetEventsAndPolygonConstruction) withObject:nil
                            waitUntilDone:YES];
    });
    
}

- (void)startGetEventsAndPolygonConstruction{
    
    [self parseAPIEventsRetrieve];
    
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay{
    
    MKPolygonView *v= nil;
    if ([overlay
         isKindOfClass:[MKPolygon class]]){
        v = [[MKPolygonView alloc] initWithPolygon:(MKPolygon *)overlay];
        v.fillColor = [[UIColor redColor] colorWithAlphaComponent:.1];
        v.strokeColor = [[UIColor redColor] colorWithAlphaComponent:.8];
        v.lineWidth = 2;
    }
    return v;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Custom Segue for All Events button
    if ([[segue identifier] isEqualToString:@"AllEventsSegueId"]) {
        NSLog(@"This is the AllEventsButton in prepareForSegue");
        //((AllEventsSegue *)segue).allJSONEvents = [self allJSONEvents];
        ((AllEventsSegue *)segue).username = username;
        
        NSLog(@"BEFORE ALLEVENTSSEGUE: %@",  parseEventObjects);
        ((AllEventsSegue *)segue).parseEventObjects=parseEventObjects
        ;
    }
}

//Check Internet Connection
- (BOOL)checkForNetwork
{
    
    BOOL connection = YES;
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            NSLog(@"There's no internet connection at all. Display error message now.");
            connection=NO;
            break;
        case ReachableViaWWAN:
            NSLog(@"We have a 3G connection");
            connection=YES;
            break;
        case ReachableViaWiFi:
            NSLog(@"We have WiFi.");
            connection=YES;
            break;
        default:
            connection=YES;
            break;
    }
    
    return connection;
}


//The is the Add Event Button in the Main View Navigation Bar
- (IBAction)addEventPressed:(id)sender {
    
    //Check for a plist file for the user
    NSLog(@"AddEvent Button was pressed, checking to see if user loggedin");
    //BOOL userLoggedIn = NO;
    
    if (username != nil){
        //Check that there is an internet connection
        if ([self checkForNetwork]){
            NSLog(@"User is logged in, creating the addeventVC");
            //AddEventViewController *addEventVC = [[AddEventViewController alloc] init];
            AddEventViewController *addEventVC =
            [self.storyboard instantiateViewControllerWithIdentifier:@"AddEventVC"];
            addEventVC.publisher = username;
            addEventVC.allBuildings = allBuildings;
            NSLog(@"total builds: %i", [allBuildings count]);
            [self.navigationController pushViewController:addEventVC animated:YES];
        }
        else{
            NSLog(@"No Connection");
            UIAlertView *noConnection =
            [[UIAlertView alloc] initWithTitle:@"No Connection" message:@"Unable to detect internet connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [noConnection show];
        }
    }
    else{
        NSLog(@"User is not logged in, creating the loginVC");
        //LogInViewController *loginVC = [[LogInViewController alloc] init];
        LogInViewController *loginVC = 
        [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        loginVC.allBuildings = allBuildings;
        //loginVC.app_id = myAppId;
        //loginVC.rest_id = myRestId;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (void)parseAPIEventsRetrieve{
    
    //Call the parse server
    [[self activityIndicator] startAnimating];
    PFQuery *query = [PFQuery queryWithClassName:@"campus_synergy"];
    [query setLimit: 1000];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            //Current the current time
            NSMutableArray *validEvents = [[NSMutableArray alloc] init];
            //NSDate *current_time = [NSDate date];
            //NSLog(@"current_time: %@", current_time);
            
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            //NSLog(@"dateString: %@", dateString);
            NSDate *current_time = [dateFormatter dateFromString:dateString];
            //NSLog(@"date: %@", current_time);
            
            
            for (PFObject *event in objects){
                NSDate *eventDate = [event objectForKey:@"date"];
                NSString *myDurationString = [event objectForKey:@"duration"];
                
                //durationInt is in hours
                int durationInt = [myDurationString intValue];
                int durationIntToSeconds = 60*60*durationInt;
                NSDate *eventDatePlusDuration =
                [eventDate dateByAddingTimeInterval:durationIntToSeconds];
                
                NSString *tempString = [dateFormatter stringFromDate:eventDatePlusDuration];
                
                NSDate *eventDatePlusDurationFormatted =
                [dateFormatter dateFromString:tempString];
                
                if([eventDatePlusDurationFormatted  timeIntervalSinceDate:current_time] < 0.0f){
                    //NSLog(@"Event is in the past: %@", [event objectForKey:@"title"]);
                }
                else{
                  
                    [validEvents addObject:event];
                }
                
            }
            
            parseEventObjects = [[NSArray alloc] initWithArray:validEvents];
            
            //NSLog(@"parseEventObjects: %@", parseEventObjects);
            
            
            NSMutableDictionary *buildEventsMutable =
            
            [[NSMutableDictionary alloc] init];
            
            for(PFObject *myObject in parseEventObjects){
                //NSLog(@"building: %@", [myObject objectForKey:@"bldName"]);
                
                [buildEventsMutable setValue:@"Here" forKey:[myObject objectForKey:@"bldName"]];
            }
        
            buildingWithEvent =
            [[NSDictionary alloc] initWithDictionary:buildEventsMutable];
            
            //return null
            //NSLog(@"buildingWithEvent: %@", [buildingWithEvent objectForKey:@"DFDF"]);
            //NSLog(@"buildingWithEvent: %@", [buildingWithEvent objectForKey:@"ARB"]);
        
            //if(overlaysGenerated == NO){
            
                //Map Construction
                NSArray *myArray = [self createPolygonCoordinateList:@"buildings"];
                
                if(myArray != nil){
                    [self.mapView addOverlays:myArray];
                    
                     
                }
                else{
                    UIAlertView *error =
                    [[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable To Load Map" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [error show];
                }
            
                //overlaysGenerated = YES;
            //}
            
            //[self.activityIndicator stopAnimating];
            
            [[self activityIndicator] stopAnimating];
            
        } else {
            // Log details of the failure
            NSLog(@"Parse Event Retrieval Error: %@ %@", error, [error userInfo]);
            [[self activityIndicator] stopAnimating];
            
            UIAlertView *parseError
            = [[UIAlertView alloc] initWithTitle:@"Event Retrievel Error" message:@"Unable to retrieve the events please check your internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            if(shownParseConnectError == NO){
                [parseError show];
                shownParseConnectError = YES;
            }
           
                
        
        }
    }];
}

- (IBAction)refreshButton:(id)sender {
    if([self refreshHitPreventer] == YES){
        NSLog(@"Firing off Refresh hit.");
        [self parseAPIEventsRetrieve];
    }
    else{
        //NSLog(@"Preventing Refresh hit.");
    }
}

- (BOOL)refreshHitPreventer{
    
    BOOL myVal = YES;
    if(refreshPreviousTime == nil){
        refreshPreviousTime = [NSDate date];
    }
    if(refreshPreviousTime != nil){
        refreshCurrentTime = [NSDate date];
        if([refreshCurrentTime timeIntervalSinceDate:refreshPreviousTime]
           > 5){
            //fire of request
            refreshPreviousTime = [NSDate date];
            //return YES;
        }
        else{
            //return NO;
            myVal = NO;
        }
    }
    return myVal;
}

//filePath is the xml file where the coordinates to draw the polygons are located
//Just gona leave this in the main
//Returns in array of MKPolygon coordinates
- (NSArray *)createPolygonCoordinateList: (NSString *)filePath{
    
    NSLog(@"In createPolygonCoordinateList");
    //Load the file and parse the xml
    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:filePath ofType:@"xml"];
    
    NSData *xml = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
    
    self.xmlParser = [[NSXMLParser alloc] initWithData:xml];
    
    self.xmlParser.delegate = self;
    
    if ([self.xmlParser parse]){
        NSLog(@"XML Parse Completed");
    }
    else{
        NSLog(@"XML Parse failed.");
    }
    
    NSMutableArray *mutableOverlaysArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *allBuildingsName = [[NSMutableArray alloc] init];
    
    //each building
    for(XMLElement *aBuilding in self.rootElement.subElements){
        
        //This represents whether or not a building has an event
        NSString *buildingHere =[buildingWithEvent objectForKey:[aBuilding.attributes objectForKey:@"name"]];
        
        //NSLog(@"buildingHere: %@", buildingHere);
    
        [allBuildingsName addObject:[aBuilding.attributes objectForKey:@"name"]];
        
        //Check if the overlay for the building is already there if not then add it
        BOOL overlayExists = NO;
        
        for(int i =0; i < [self.mapView.overlays count]; i++){
            
            NSString *overlayTitle =
            [[self.mapView.overlays objectAtIndex:i] title];
            
            if([overlayTitle isEqualToString:[aBuilding.attributes objectForKey:@"name"]]){
                overlayExists = YES;
            }
            
        }
        
        //building must have events and the overlay must not already exist
        if(buildingHere != nil && overlayExists == NO){
            
            int numberOfPoints = [aBuilding.subElements count]/2;
            CLLocationCoordinate2D points[numberOfPoints];
            
            BOOL alternator = YES;
            int pointsIndex = 0;
        
            if(buildingAndPoints == nil){
                buildingAndPoints = [[NSMutableDictionary alloc] init];
            }
            
            NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
            //if YES then lat else long
            for(int i = 0; i < [aBuilding.subElements count]; i++){
                if (alternator){
                    alternator = NO;
                }
                else{
                    XMLElement *lat = aBuilding.subElements[i - 1];
                    XMLElement *longVal = aBuilding.subElements[i];
                    points[pointsIndex] = CLLocationCoordinate2DMake([lat.text doubleValue], [longVal.text doubleValue]);
                    
                    CustomPoint *cp = [[CustomPoint alloc] initWithLat:[lat.text doubleValue] andLong:[longVal.text doubleValue]];
                    
                    [pointsArray addObject:cp];
                    
                    pointsIndex++;
                    alternator = YES;
                }
            }
            
            MKPolygon* coordinates = [MKPolygon polygonWithCoordinates:points count:numberOfPoints];
            
            NSString *buildingTitle = [aBuilding.attributes objectForKey:@"name"];
            [coordinates setTitle:buildingTitle];
            
            [mutableOverlaysArray addObject:coordinates];
            
            NSArray *regularArray = [[NSArray alloc] initWithArray:pointsArray];
             
            [buildingAndPoints setValue:regularArray forKey:buildingTitle];
        }
    }
    
    allBuildings = [[NSArray alloc] initWithArray:allBuildingsName];
    NSArray *myArray = [[NSArray alloc] initWithArray:mutableOverlaysArray];
    return myArray;
}

//XML Parser Delegate Functions
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    self.rootElement = nil;
    self.currentElementPointer = nil;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if(self.rootElement == nil) {
        self.rootElement = [[XMLElement alloc] init];
        self.currentElementPointer = self.rootElement;
    }
    else{
        XMLElement *newElement = [[XMLElement alloc] init];
        newElement.parent = self.currentElementPointer;
        [self.currentElementPointer.subElements addObject:newElement];
        self.currentElementPointer = newElement;
    }
    
    self.currentElementPointer.name = elementName;
    self.currentElementPointer.attributes = attributeDict;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if([self.currentElementPointer.text length] > 0){
        self.currentElementPointer.text = [self.currentElementPointer.text stringByAppendingString:string];
    }
    else{
        self.currentElementPointer.text = string;
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.currentElementPointer = self.currentElementPointer.parent;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    self.currentElementPointer = nil;
}


//This will return the building string if the touch is in the polygon or nil if it is not
- (NSString *)calculatePointInPolygon: (CGPoint) polygonViewPoint andRenderer: (MKOverlayRenderer *)myView{
    
    NSString *myBuildingName = nil;
    
    //Just testing out the AL building and its points
    NSArray *buildings = [buildingAndPoints allKeys];

    for(NSString *buildingName in buildings){
        
        NSArray *myArray = [buildingAndPoints objectForKey:buildingName];
        
        //First do a preliminary check
        float xMin = 0;
        float xMax = 0;
        float yMin = 0;
        float yMax = 0;

        CLLocationCoordinate2D temp = CLLocationCoordinate2DMake([[myArray objectAtIndex:0] myLat], [[myArray objectAtIndex:0] myLong]);
        CGPoint firstMapViewPoint = [myView pointForMapPoint:MKMapPointForCoordinate(temp)];
        
        xMin = firstMapViewPoint.x;
        xMax = firstMapViewPoint.x;
        yMin = firstMapViewPoint.y;
        yMax = firstMapViewPoint.y;
        
        for(CustomPoint *pointInArray in myArray){
            CLLocationCoordinate2D temp = CLLocationCoordinate2DMake([pointInArray myLat], [pointInArray myLong]);
            MKMapPoint mapPoint = MKMapPointForCoordinate(temp);
            CGPoint mapViewPoint = [myView pointForMapPoint:mapPoint];
            
            if(xMin > mapViewPoint.x){
                xMin = mapViewPoint.x;
            }
            
            if (xMax < mapViewPoint.x){
                xMax = mapViewPoint.x;
            }
            
            if(yMin > mapViewPoint.y){
                yMin = mapViewPoint.y;
            }
            
            if(yMax < mapViewPoint.y){
                yMax = mapViewPoint.y;
            }
            
        }
        
        /*
        NSLog(@"xMin: %f", xMin);
        NSLog(@"yMin: %f", yMin);
        NSLog(@"xMax: %f", xMax);
        NSLog(@"yMax: %f", yMax);
         */
        
        //Implement the ray casting algorithm
        
        BOOL inside = NO;
        
        for(int i = 0; i < [myArray count] + 1; i++){
            
            int modded_num = i % [myArray count];
            CLLocationCoordinate2D temp = CLLocationCoordinate2DMake(
                                                                     [[myArray objectAtIndex:modded_num] myLat], [[myArray objectAtIndex:modded_num] myLong]);
            CGPoint otherPoint = [myView pointForMapPoint:MKMapPointForCoordinate(temp)];
        
            if (polygonViewPoint.y > fminf(firstMapViewPoint.y, otherPoint.y) ) {
                
                if ( polygonViewPoint.y <= fmaxf(firstMapViewPoint.y, otherPoint.y)){
                    
                    if (polygonViewPoint.x <= fmaxf(firstMapViewPoint.x, otherPoint.x)){
                        
                        float xints = 0;
                        if (firstMapViewPoint.y != otherPoint.y){
                            //(y-p1y)*(p2x-p1x)/(p2y-p1y)+p1x
                             xints = (polygonViewPoint.y - firstMapViewPoint.y)*(otherPoint.x - firstMapViewPoint.x)/(otherPoint.y - firstMapViewPoint.y) + firstMapViewPoint.x;
                        }
                        
                        if(firstMapViewPoint.x == otherPoint.x || polygonViewPoint.x <= xints){
                            inside = !inside;
                        }
                    }
                }
                
            }
            
            firstMapViewPoint.x = otherPoint.x;
            firstMapViewPoint.y = otherPoint.y;
        }//End of for
        
        if(inside){
            NSLog(@"inside a building %@, breaking loop", buildingName);
            myBuildingName = buildingName;
            break;
        }
        
    }
    
    //Will return nil if touch in no polygon
    return myBuildingName;
}

//Algorithm from: http://stackoverflow.com/questions/14524718/is-cgpoint-in-mkpolygonview
//With appropiate modifications
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Touch event began");
    
    MKMapView *mapView = (MKMapView *)self.mapView;
    
    MKPolygonView *tappedOverlay = nil;

    int i = 0;
    for (id<MKOverlay> overlay in mapView.overlays)
    {
        MKPolygonView *view = (MKPolygonView *)[self.mapView viewForOverlay:overlay];
       
        
        //MKPolygonView *view = (MKPolygonView *)[self.mapView rendererForOverlay:overlay];
    
        //MKOverlayRenderer *myView = [self.mapView rendererForOverlay:overlay];
        //self.mapView viewFor
        
        MKOverlayRenderer *myView = [[MKOverlayRenderer alloc] initWithOverlay:overlay];
        
        //MKMapRect myMapRect = [myView.overlay boundingMapRect];
        
        //if(view)
        if (myView){
            
            CGPoint touchPoint = [[touches anyObject] locationInView:self.mapView];
            
            //CGPoint newTouchPoint = [myView pointForMapPoint:<#(MKMapPoint)#>]
            
            CLLocationCoordinate2D touchMapCoordinate =
            [mapView convertPoint:touchPoint toCoordinateFromView:mapView];
            
            
            //NSLog(@"lat: %f, long: %f", touchMapCoordinate.latitude, touchMapCoordinate.longitude);
            
            MKMapPoint mapPoint = MKMapPointForCoordinate(touchMapCoordinate);
            
            //CGPoint polygonViewPoint = [view pointForMapPoint:mapPoint];
            CGPoint polygonViewPoint = [myView pointForMapPoint:mapPoint];
            
            NSString *buildingName =
            [self calculatePointInPolygon: polygonViewPoint andRenderer:myView];
        
            //if(CGPathContainsPoint(tempPath.path, NULL, polygonViewPoint, NO)){
            if (buildingName != nil){
                
                tappedOverlay = view;
                tappedOverlay.tag = i;
                
                //If it hits this part then it is in one of the overlays in the map
                //NSLog(@"In an Overlay");
                //NSLog(@"Overlay Info: %@", [overlay title]);
                
                AllEventsForBuildingViewController *allEventsForBuildingVC
                = [self.storyboard instantiateViewControllerWithIdentifier:@"EventsForBuildingVC"];
                
                /*
                NSString *myString
                = [[NSString alloc] initWithFormat:@"%@",[overlay title] ];
                 */
                
                allEventsForBuildingVC.username = username;
                allEventsForBuildingVC.buildingNameString = buildingName;
                //allEventsForBuildingVC.myAppId = myAppId;
                //allEventsForBuildingVC.myRestId = myRestId;
                
                //Using the objective c api
                allEventsForBuildingVC.parseEventArray =  parseEventObjects;
                
                [self.navigationController pushViewController:allEventsForBuildingVC animated:YES];
            
                break;
            }
            else{
                //NSLog(@"Touch is not in the overlay");
            }
        }
        i++;
    }
    
}

@end

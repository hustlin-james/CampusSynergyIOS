//
//  CustomPoint.m
//  CampusSynergy
//
//  Created by feifan meng on 9/18/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "CustomPoint.h"

@implementation CustomPoint

- (id)initWithLat:(float)aLat andLong:(float)aLong{
    self = [super init];
    if (self) {
        self.myLat = aLat;
        self.myLong = aLong;
    }
    return self;
}

@end

//
//  CustomPoint.h
//  CampusSynergy
//
//  Created by feifan meng on 9/18/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomPoint : NSObject

@property (assign)float myLat;
@property (assign)float myLong;

- (id)initWithLat:(float)aLat andLong:(float)aLong;

@end

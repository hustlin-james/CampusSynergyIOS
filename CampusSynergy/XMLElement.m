
//
//  XMLElement.m
//  CampusSynergy
//
//  Created by feifan meng on 9/1/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "XMLElement.h"

@implementation XMLElement

//if you try self.subElements it will generate a loop.  don't really understand this

- (NSMutableArray *)subElements{
    if ( _subElements == nil){
        _subElements = [[NSMutableArray alloc] init];
    }
    return _subElements;
}

@end

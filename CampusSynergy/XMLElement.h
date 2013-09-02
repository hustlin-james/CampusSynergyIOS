//
//  XMLElement.h
//  CampusSynergy
//
//  Created by feifan meng on 9/1/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLElement : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSDictionary *attributes;
@property(nonatomic, strong) NSMutableArray *subElements;
@property(nonatomic, weak) XMLElement *parent;

@end

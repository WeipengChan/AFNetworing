//
//  ParentYuerListResponseData.m
//  AFNetworing
//
//  Created by YunInfo on 14-5-30.
//  Copyright (c) 2014年 BBA. All rights reserved.
//

#import "ParentYuerListResponseData.h"
#import "MUResponseSerializer.h"

#import "DataObject.h"

@implementation ParentYuerListResponseData

- (NSDictionary *)propertyMap
{
    
    // There is no need to map all properties, only those which you want to have diffrent names;
    return   @{};
}

- (Class)classForElementsInArrayProperty:(NSString *)propertyName
{
//    if ([propertyName isEqualToString:]) {
//        
//    }
    return [DataObject class];
}

@end

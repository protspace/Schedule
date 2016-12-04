//
//  TripsListResponseModel.m
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "TripsListResponseModel.h"

@class TripModel;

@implementation TripsListResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"trips" : @"trips",
             };
}

#pragma mark - JSON Transformer

+ (NSValueTransformer *)tripsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:TripModel.class];
}



@end

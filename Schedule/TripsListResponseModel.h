//
//  TripsListResponseModel.h
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import "TripModel.h"

@interface TripsListResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray *trips;

@end

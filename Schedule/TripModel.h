//
//  TripModel.h
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MTLModel.h"

@interface TripModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *tripId;
@property (nonatomic, copy) NSString *providerLogo;
@property (nonatomic, copy) NSNumber *priceEur;
@property (nonatomic, copy) NSString *departure;
@property (nonatomic, copy) NSString *arrival;
@property (nonatomic, copy) NSNumber *numberOfStops;



@end

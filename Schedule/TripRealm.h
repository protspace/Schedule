//
//  TripRealm.h
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/2/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "TripModel.h"

@interface TripRealm : RLMObject

@property NSNumber<RLMInt> *tripId;
@property NSString *providerLogo;
@property NSNumber<RLMFloat> *priceEur;
@property NSString *departure;
@property NSString *arrival;
@property NSString *duration;
@property NSNumber<RLMInt> *numberOfStops;

- (id)initWithMantleModel:(TripModel *)tripModel;

@end

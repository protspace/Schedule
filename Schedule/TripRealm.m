//
//  TripRealm.m
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/2/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "TripRealm.h"

@implementation TripRealm

- (id)initWithMantleModel:(TripModel *)tripModel{
    self = [super init];
    if(!self) return nil;
    
    self.tripId = tripModel.tripId;
    self.providerLogo = tripModel.providerLogo;
    self.priceEur = tripModel.priceEur;
    self.departure = tripModel.departure;
    self.arrival = tripModel.arrival;
    self.duration = [self getDurationFromDeparture:self.departure andArrival:self.arrival];
    self.numberOfStops = tripModel.numberOfStops;
    return self;
}

- (NSString *)getDurationFromDeparture:(NSString *)departure andArrival:(NSString *)arrival {
    if (!departure || !arrival) {
        return @"";
    }
    NSDateFormatter *df= [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm "];
    NSDate *dateDeparture = [df dateFromString:departure];
    NSDate *dateArrival = [df dateFromString:arrival];
    
    return [self stringFromTimeInterval:[dateArrival timeIntervalSinceDate:dateDeparture]];
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02ld:%02ld%@", (long)hours, (long)minutes, @"h"];
}

@end

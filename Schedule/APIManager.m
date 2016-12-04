//
//  APIManager.m
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "APIManager.h"
#import "Mantle.h"



@implementation APIManager

- (NSURLSessionDataTask *)getTripsForType:(TravelType)type success:(void (^)(TripsListResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure{
    
    NSString *path = @"";
    switch (type) {
        case TravelTypeAir:
            path = TripsFlightsListPath;
            break;
        case TravelTypeTrain:
            path = TripsTrainsListPath;
            break;
        case TravelTypeBus:
            path = TripsBusesListPath;
            break;
        default:
            path = TripsFlightsListPath;
            break;
    }
    
    return [self GET:path parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {

        NSDictionary *responseDictionary = (NSDictionary *)responseObject;
        NSDictionary *responseDict = [[NSDictionary alloc] initWithObjectsAndKeys:responseDictionary, @"trips",  nil];
        //NSLog(@"responseDict: %@", responseDict);

        NSError *error;
        TripsListResponseModel *list = [MTLJSONAdapter modelOfClass:TripsListResponseModel.class
                                                   fromJSONDictionary:responseDict error:&error];
        NSLog(@"model trips count = %ld", list.trips.count);
        success(list);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"response = %@", operation.response);
        NSLog(@"Error: %@", error);
        failure(error);
        //NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:error.data options:kNilOptions error:nil]);
    }];

}

@end

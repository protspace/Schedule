//
//  APIManager.h
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "SessionManager.h"
#import "TripsListResponseModel.h"

@interface APIManager : SessionManager

- (NSURLSessionDataTask *)getTripsForType:(TravelType)type success:(void (^)(TripsListResponseModel *responseModel))success failure:(void (^)(NSError *error))failure;

@end

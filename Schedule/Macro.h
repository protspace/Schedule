//
//  Macro.h
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/2/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#endif /* Macro_h */


#pragma mark - Api

#define BaseURL @"https://api.myjson.com/bins"

#define TripsFlightsListPath @"w60i"
#define TripsTrainsListPath @"3zmcy"
#define TripsBusesListPath @"37yzm"

#define ApiKeyId @"id"
#define ApiKeyProviderLogo @"provider_logo"
#define ApiKeyPriceEur @"price_in_euros"
#define ApiKeyDeparture @"departure_time"
#define ApiKeyArrival @"arrival_time"
#define ApiKeyNumberOfStops @"number_of_stops"

#define ApiLogoSize @"63"

#pragma mark UI
#pragma mark colors

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define COLOR_GREEN_COLOR RGBColor(9, 187, 7)
#define COLOR_WHITE_COLOR RGBColor(255, 255, 255)

#pragma mark - Enum

typedef NS_ENUM(NSInteger, TravelType) {
    TravelTypeAir = 0,
    TravelTypeTrain,
    TravelTypeBus,
    
};

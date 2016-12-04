//
//  TripModel.m
//  Schedule
//
//  Created by Ievgen Sagidulin on 12/3/16.
//  Copyright © 2016 Ievgen Sagidulin. All rights reserved.
//

#import "TripModel.h"

@implementation TripModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tripId": ApiKeyId,
             @"providerLogo": ApiKeyProviderLogo,
             @"priceEur": ApiKeyPriceEur,
             @"departure": ApiKeyDeparture,
             @"arrival": ApiKeyArrival,
             @"numberOfStops": ApiKeyNumberOfStops,
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"priceEur"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id price, BOOL *success, NSError *__autoreleasing *error) {
            if ([price isKindOfClass:[NSNumber class]]) {
                return [(NSNumber *)price stringValue];
            } else if ([price isKindOfClass:[NSString class]]) {
                return (NSString *)price;
            } else {
                return @"price";
            }
        } reverseBlock:^id(NSString *priceString, BOOL *success, NSError *__autoreleasing *error) {
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterCurrencyStyle;
            return [f numberFromString:priceString];
        }];
    }
    
    if ([key isEqualToString:@"providerLogo"]) {
        return [MTLValueTransformer transformerUsingForwardBlock:^id(id url, BOOL *success, NSError *__autoreleasing *error) {
            if ([url isKindOfClass:[NSString class]]) {
                return [(NSString *)url stringByReplacingOccurrencesOfString:@"{size}" withString:ApiLogoSize];
            } else {
                return @"";
            }
        } reverseBlock:^id(NSString *url, BOOL *success, NSError *__autoreleasing *error) {
            return url;
        }];
    }

    
    return nil;
}

@end

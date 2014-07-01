//
//  DistanceMatrixWrapper.m
//  DistanceMatrixWrapper
//
//  Created by Antonio Pinho on 26/04/14.
//  Copyright (c) 2014 evolution. All rights reserved.
//

#import "DistanceMatrixWrapper.h"
#import "DMResult.h"

#define GOOGLE_DISTANCE_MATRIX_WRAPPER_API_URL @"https://maps.googleapis.com/maps/api/distancematrix/json?"

@implementation DistanceMatrixWrapper

- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        self.units = DMUnitsMetric;
        self.travelMode = DMModeDriving;
        self.language = DMLanguageDefault;
    }
    
    return self;
}

+ (DistanceMatrixWrapper *) sharedInstance {
    
    static DistanceMatrixWrapper *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DistanceMatrixWrapper alloc] init];
    });
    
    return instance;
}

- (NSMutableDictionary *)createParams:(NSArray *)origins andDestinations:(NSArray *)destinations {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params addEntriesFromDictionary:@{@"origins" :[origins componentsJoinedByString:@"|"]}];
    [params addEntriesFromDictionary:@{@"destinations" :[destinations componentsJoinedByString:@"|"]}];
    [params addEntriesFromDictionary:@{@"key" : self.api_key}];
    [params addEntriesFromDictionary:@{@"sensor" : @"true"}];
    
    if(self.units == DMUnitsImperial) {
        [params addEntriesFromDictionary:@{@"units" : @"imperial"}];
    }
    
    if(self.travelMode == DMModeWalking) {
        [params addEntriesFromDictionary:@{@"mode": @"walking"}];
    } else if(self.travelMode == DMModeBicycling) {
        [params addEntriesFromDictionary:@{@"mode": @"bicycling"}];
    }
    
    if(self.language == DMLanguagePT_PT) {
        [params addEntriesFromDictionary:@{@"language": @"pt-pt"}];
    }

    return params;
}

- (void)fetchDistance:(NSArray *)origins andDestinations:(NSArray *)destinations  success:(void (^)(NSArray *results))success failure:(void (^)(NSError *error))failure order:(BOOL)ascending{
    
    if(!self.api_key) {
        failure([NSError errorWithCustomDescription:@"DistanceMatrixWrapper error: must set google api_key property"]);
        return;
    }
    
    if (!origins || !destinations || origins.count == 0 || destinations.count == 0) {
        failure([NSError errorWithCustomDescription:@"DistanceMatrixWrapper error: origins / destinations should not be empty/nil"]);
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:GOOGLE_DISTANCE_MATRIX_WRAPPER_API_URL parameters:[self createParams:origins andDestinations:destinations] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *statusCode = responseObject[@"status"];
        
        if(![statusCode isEqualToString:@"OK"]) {

            NSString *errorDescription = responseObject[@"error_message"] ? [NSString stringWithFormat:@"DistanceMatrixWrapper error! Code %@ (%@)",statusCode,responseObject[@"error_message"]] :
            [NSString stringWithFormat:@"DistanceMatrixWrapper error! Code %@",statusCode];
            
            failure([NSError errorWithCustomDescription:errorDescription]);
            
            return;
        }
        
        NSArray *rows = responseObject[@"rows"];
        NSArray *originAddresses = responseObject[@"origin_addresses"];
        NSArray *destinationAddresses = responseObject[@"destination_addresses"];

        if(rows.count != originAddresses.count || originAddresses.count != origins.count || destinationAddresses.count != destinations.count) {
            failure(nil);
            return;
        }
        
        NSMutableArray *results = [[NSMutableArray alloc] init];
       
        for (int i = 0;  i < origins.count;  i++) {
            NSDictionary *row = [rows objectAtIndex:i];
            NSArray *elements = row[@"elements"];
            
            if([self resultNotFound:elements]) {
                failure([NSError errorWithCustomDescription:[NSString stringWithFormat:@"DistanceMatrixWrapper Error: Route not found!"]]);
                return;
            }
            
            for (int j = 0; j < destinations.count; j++) {
                DMResult *result = [[DMResult alloc] initWithDicionary:[elements objectAtIndex:j] origin:origins[i] andDestination:destinations[j]];
                [results addObject:result];
            }
        }

        NSSortDescriptor *durationSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"duration" ascending:ascending];
        NSSortDescriptor *distanceSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:ascending];

        if(success) {
            success([results sortedArrayUsingDescriptors:@[durationSortDescriptor,distanceSortDescriptor]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

- (BOOL)resultNotFound:(NSArray *)elements {
    if (elements.count > 0) {
        NSString *elementStatus = [elements objectAtIndex:0][@"status"];
        
        if([elementStatus isEqualToString:@"NOT_FOUND"]) {
            return YES;
        }
    }
    return NO;
}


@end

//
//  DMResult.m
//  DistanceMatrixWrapper
//
//  Created by Antonio Pinho on 26/04/14.
//  Copyright (c) 2014 evolution. All rights reserved.
//

#import "DMResult.h"

@implementation DMResult

- (instancetype)initWithDicionary:(NSDictionary *)json origin:(NSString *)origin andDestination:(NSString *)destination {
    
    if (self = [super init]) {
        
        self.origin = origin;
        self.destination = destination;
        
        self.duration = json[@"duration"][@"value"];
        self.durationText = json[@"duration"][@"text"];
        
        self.distance = json[@"distance"][@"value"];
        self.distanceText = json[@"distance"][@"text"];
        
        return self;
    }
    
    return nil;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Origin: %@ | Destination: %@ | Duration: %@ | DurationText: %@ | Distance: %@ | DistanceText: %@",self.origin, self.destination, self.duration, self.durationText, self.distance, self.distanceText];
}




@end

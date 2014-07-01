//
//  DMResult.h
//  DistanceMatrixWrapper
//
//  Created by Antonio Pinho on 26/04/14.
//  Copyright (c) 2014 evolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMResult : NSObject

@property(nonatomic, strong) NSString  *origin;
@property(nonatomic, strong) NSString  *destination;
@property(nonatomic, strong) NSNumber *duration;
@property(nonatomic, strong) NSString *durationText;
@property(nonatomic, strong) NSNumber *distance;
@property(nonatomic, strong) NSString *distanceText;

- (instancetype) initWithDicionary:(NSDictionary *)json origin:(NSString *)origin andDestination:(NSString *)destination;

@end

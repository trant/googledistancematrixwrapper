//
//  DistanceMatrixWrapper.h
//  DistanceMatrixWrapper
//
//  Created by Antonio Pinho on 26/04/14.
//  Copyright (c) 2014 evolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistanceMatrixWrapper : NSObject

typedef NS_ENUM(NSInteger, DMUnits) {
    DMUnitsMetric,
    DMUnitsImperial
};

typedef NS_ENUM(NSInteger, DMMode) {
    DMModeDriving,
    DMModeWalking,
    DMModeBicycling
};

typedef NS_ENUM(NSInteger, DMLanguage) {
    DMLanguageDefault,
    DMLanguagePT_PT
};

@property(nonatomic, assign) DMUnits units;
@property(nonatomic, assign) DMMode travelMode;
@property(nonatomic, assign) DMLanguage language;
@property(nonatomic, strong) NSString *api_key;

+ (DistanceMatrixWrapper *) sharedInstance;

- (void)fetchDistance:(NSArray *)origins andDestinations:(NSArray *)destinations  success:(void (^)(NSArray *results))success failure:(void (^)(NSError *error))failure order:(BOOL)ascending;

@end

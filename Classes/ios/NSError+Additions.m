//
//  NSError+Additions.m
//  DistanceMatrixWrapper
//
//  Created by Antonio Pinho on 05/05/14.
//  Copyright (c) 2014 evolution. All rights reserved.
//

#import "NSError+Additions.h"

@implementation NSError (Additions)

+ (NSError *)errorWithCustomDescription:(NSString *)description {
    return [NSError errorWithDomain:@"DistanceMatrixWrapper" code:0 userInfo:@{@"errorCustomDescription" : description}];
}

- (NSString *)customDescription {
    return [self.userInfo objectForKey:@"errorCustomDescription"];
}



@end
